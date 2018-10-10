Return-Path: <SRS0=X323=MW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBADC43441
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Oct 2018 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63222150C
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Oct 2018 11:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63222150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeJJSbS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:31:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbeJJSbR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 14:31:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AB9aXI143305
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 07:09:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1fb2jnve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 07:09:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 10 Oct 2018 12:09:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 12:09:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9AB9RtG4391232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 11:09:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AFE15205F;
        Wed, 10 Oct 2018 14:09:00 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.86.222])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8F1DF52059;
        Wed, 10 Oct 2018 14:08:59 +0100 (BST)
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        chuck.lever@oracle.com
Date:   Wed, 10 Oct 2018 07:09:15 -0400
In-Reply-To: <CACdnJusJ83MH+e7N4qXwS9iMTFLVoQzZrW=zNBHaTwr+LLHL8g@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
         <1538997900.15382.90.camel@linux.ibm.com>
         <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
         <1539038432.15382.181.camel@linux.ibm.com>
         <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
         <1539108259.15382.221.camel@linux.ibm.com>
         <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
         <1539118367.15382.247.camel@linux.ibm.com>
         <CACdnJusJ83MH+e7N4qXwS9iMTFLVoQzZrW=zNBHaTwr+LLHL8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101011-0016-0000-0000-0000021114B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101011-0017-0000-0000-0000326882BA
Message-Id: <1539169755.15382.274.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181010110915.6moCg2kIbxF3vGNFIzI4Nvk7tpgf2Jtbxoj4RgRb4yo@z>

On Tue, 2018-10-09 at 14:32 -0700, Matthew Garrett wrote:
> On Tue, Oct 9, 2018 at 1:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > > The performance hit is more noticeable over remote filesystems, but we
> > > have large binaries that take several seconds to hash even on local
> > > filesystems. Would it be helpful to try to define the assumptions that
> > > IMA makes in terms of whether or not it produces trustworthy results?
> > > It feels like it's be easier to talk about this if we have a more
> > > formal set of conditions to take into consideration.
> >
> > [Cc'ing Chuck Lever]
> >
> > Integrity of files on remote filesystems should probably be discussed
> > in the context of fs-verity, not FUSE filesystems.
> 
> Hm. We /could/ fake up fs-verity style behaviour, but we're not
> talking about files that are expected to be immutable so it would seem
> like there might be mismatched semantics there.

If these aren't immutable files, then the file hash needs to be
calculated and re-calculated on file change.  Trust between the kernel
and FUSE isn't bi-directional.  IMA already supports hardware crypto
acceleration.  (Refer to the "ima.ahash_minsize" and
"ima.ahash_bufsize" boot command line options.)  Why is it better that
FUSE calculates the file hash than the kernel?

Mimi

