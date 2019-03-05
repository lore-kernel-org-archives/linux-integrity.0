Return-Path: <SRS0=PR+Z=RI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29AC43381
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF9205F4
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCETvS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:51:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbfCETvR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Mar 2019 14:51:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25JnJgG051956
        for <linux-integrity@vger.kernel.org>; Tue, 5 Mar 2019 14:51:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r1xwht88x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Mar 2019 14:51:15 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 5 Mar 2019 19:51:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 19:51:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25JpAk555574530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Mar 2019 19:51:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF56AE045;
        Tue,  5 Mar 2019 19:51:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD099AE058;
        Tue,  5 Mar 2019 19:51:09 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 19:51:09 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Tue, 05 Mar 2019 14:51:09 -0500
In-Reply-To: <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030519-0008-0000-0000-000002C8ECB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030519-0009-0000-0000-00002234F467
Message-Id: <1551815469.31706.132.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-03-05 at 10:39 -0800, Matthew Garrett wrote:
> On Tue, Mar 5, 2019 at 5:19 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2019-03-04 at 14:10 -0800, Matthew Garrett wrote:
> > > I'm not clear on why requiring signed policies is helpful here. If you
> > > allow FUSE mounts at all then you need to trust the FUSE filesystem to
> > > return good results, in which case you can trust it to return valid
> > > hashes. If you don't trust the FUSE filesystem then generating the
> > > hash via read doesn't win you anything - the filesystem can return one
> > > set of data on the initial IMA hashing, and then return a second set
> > > later. Requiring signed policy doesn't change that.
> >
> > You're defining a new generic file ops "get_hash", but are using FUSE,
> > a specific filesystem, as an example.  Requiring the IMA policy to be
> > signed when using "get_hash", is proof of the sysadmin's agreement to
> > bypass actually reading and calculating the file hash.
> 
> We can trust in-kernel filesystems to return reliable information.
> Network filesystems have the same issue as FUSE - we're trusting that
> the remote endpoint won't give us different information on successive
> reads. What's the threat that's blocked by requiring signed policy
> here?

Today, IMA calculates the file hash by reading the file.  If
"get_hash" is a generic filesystem ops, then any filesystem could
implement it, properly or not.  sysadmins shouldn't have to review
kernel code to understand the source of the file hash, but should be
able to assume that unless they explicitly authorize "get_hash" usage,
IMA reads the file and calculates the file hash.

Mimi

