Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AEBC43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831120652
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 20:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCGUs3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:48:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbfCGUs3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 15:48:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27Kihg4129606
        for <linux-integrity@vger.kernel.org>; Thu, 7 Mar 2019 15:48:27 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r38ya55vu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2019 15:48:27 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Mar 2019 20:48:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 20:48:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x27KmMgc13172948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 20:48:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBBF4C052;
        Thu,  7 Mar 2019 20:48:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A1AE4C040;
        Thu,  7 Mar 2019 20:48:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 20:48:21 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Thu, 07 Mar 2019 15:48:10 -0500
In-Reply-To: <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <20190226215034.68772-4-matthewgarrett@google.com>
         <1551369834.10911.195.camel@linux.ibm.com>
         <1551377110.10911.202.camel@linux.ibm.com>
         <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
         <1551391154.10911.210.camel@linux.ibm.com>
         <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
         <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
         <1551731553.10911.510.camel@linux.ibm.com>
         <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
         <1551791930.31706.41.camel@linux.ibm.com>
         <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
         <1551815469.31706.132.camel@linux.ibm.com>
         <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
         <1551875418.31706.158.camel@linux.ibm.com>
         <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
         <1551911937.31706.217.camel@linux.ibm.com>
         <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
         <1551923650.31706.258.camel@linux.ibm.com>
         <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030720-0008-0000-0000-000002C9F567
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030720-0009-0000-0000-0000223604D6
Message-Id: <1551991690.31706.416.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-03-06 at 20:19 -0800, Matthew Garrett wrote:
> On Wed, Mar 6, 2019 at 5:54 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2019-03-06 at 15:36 -0800, Matthew Garrett wrote:
> >
> > > > But they would have to knowingly add "get_hash" to the IMA policy and
> > > > have signed it.
> > >
> > > But in the non-signed case they'd still need to knowingly add
> > > "get_hash" to the IMA policy. Why does signing indicate stronger
> > > understanding of policy?
> >
> > Nobody is suggesting that signing the policy is a stronger indication
> > of understanding the policy.  Signing the policy simply limits which
> > policies may be loaded.
> 
> I'm not sure I understand the additional risk, though. Either a
> filesystem is already being measured using a full read, in which case
> adding an additional rule won't change behaviour, or it's not being
> measured at all, in which case there's no incentive for an attacker to
> add a new rule.

In an environment where the initramfs contains everything, including
the IMA policy, and is verified, then what you're saying is true - the
IMA policy doesn't need to be signed.  However, the existing dracut
and systemd IMA modules read the IMA policy not from the initramfs,
but from real root.  In this environment where the IMA policy is on
real root, an attacker could modify the IMA policy.  I realize this is
an existing problem, not particular to "get_hash'.  Unlike other
policy changes, the attestation server would have no way of detecting
this particular change.

> > There is also a difference between trusting the filesystem "read" and
> > the filesystem "get_hash" implementation, that have yet to be written.
> 
> In both cases we're placing trust in the filesystem's correctness.
> It's certainly possible for the get_hash call to be broken, but that's
> something we can put additional testing into.

The call itself wouldn't be broken, but determining if the filesystem
is actually calculating/re-calculating the file hash properly or
simply returning a stored/cached value.  I do see the benefit of the
filesystems being responsible for the file hash.  Perhaps I'm just
being overly cautious.  I'd like to hear other people's opinions.

Mimi

