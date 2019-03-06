Return-Path: <SRS0=JWD1=RJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B512C43381
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 22:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99CF206DD
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfCFWjG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:39:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbfCFWjF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Mar 2019 17:39:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26MYsxt025508
        for <linux-integrity@vger.kernel.org>; Wed, 6 Mar 2019 17:39:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r2mcafd3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2019 17:39:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 6 Mar 2019 22:39:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Mar 2019 22:38:59 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x26Mcw8A31129664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 22:38:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B692A42059;
        Wed,  6 Mar 2019 22:38:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130D04205F;
        Wed,  6 Mar 2019 22:38:58 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Mar 2019 22:38:57 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Wed, 06 Mar 2019 17:38:57 -0500
In-Reply-To: <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030622-0028-0000-0000-00000350E02D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030622-0029-0000-0000-0000240F4F8D
Message-Id: <1551911937.31706.217.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060153
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-03-06 at 10:31 -0800, Matthew Garrett wrote:
> On Wed, Mar 6, 2019 at 4:30 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-03-05 at 12:27 -0800, Matthew Garrett wrote:
> > > But what's the threat? If an attacker is in a position to inject
> > > additional IMA policy then in general they're already in a position to
> > > violate other security assumptions. Admins who have a threat model
> > > that includes an attacker being able to do this are already requiring
> > > signed policy. What's the threat that requiring signed policy for this
> > > specific option mitigates?
> >
> > That might be true, but this "feature" isn't a minor change.  It
> > totally changes the IMA measurement list meaning, without any
> > indication of the change in meaning.
> 
> Ok. Would annotating the audit message to indicate that the hash was
> provided directly by the filesystem be sufficient? 

The audit log doesn't have the same security properties as the TPM
quote and IMA measurement list.  Nor does the attestation server
necessarily have access to it.

> I'm not clear on
> why an admin would set this flag without having read the documentation
> for it - like many security features, enabling an inappropriate
> combination of them may result in bad things happening.  I'm not keen
> on tying it to signing because:
> 
> a) There are multiple configurations where requiring signed policy
> doesn't give a security benefit - if the IMA policy is part of a
> verified or measured initramfs, we already have integrity guarantees
> and adding an additional layer of signing doesn't win us anything (eg,
> in this configuration the IMA key may be loaded from the initramfs as
> well, so an attacker able to modify policy could add an additional
> signing key).

Agreed, as long as there is no possibility of additional files being
installed/downloaded to the rootfs or files on other filesystems being
accessed before the IMA keyring is locked or a custom policy is
installed, a verified or measured initramfs might be enough.

This implies that both the custom policy and the keys loaded onto the
IMA keyring are included in the initramfs, which isn't what is
currently being done today.  My preference would be to remove the
original method of loading unsigned IMA policies, but that could/would
break existing systems.

> b) Users who are already using signed policy won't get the additional
> hint that you think is necessary.

But they would have to knowingly add "get_hash" to the IMA policy and
have signed it.

> I'm happy to add this if there's a real threat model around it, but
> requiring signing for something other than security reasons seems like
> it's conflating unrelated issues.

A colleague said, relying on the filesystem to provide the file hash
extends the TCB to include filesystems.

Mimi

