Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0087C65C20
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 11:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC332085B
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 11:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC332085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJHSgg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeJHSgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 14:36:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98BJQ1Z038892
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 07:25:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n031r3g08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 07:25:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 12:25:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 12:25:13 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98BPCXX62914746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 11:25:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88798A405B;
        Mon,  8 Oct 2018 14:24:46 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB984A4040;
        Mon,  8 Oct 2018 14:24:45 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.101.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Oct 2018 14:24:45 +0100 (BST)
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 08 Oct 2018 07:25:00 -0400
In-Reply-To: <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100811-0020-0000-0000-000002D10486
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100811-0021-0000-0000-0000211F67FB
Message-Id: <1538997900.15382.90.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008112500.ALspUKJQWzOTkXU7ycHaCNhllW70ZrC5eZQ6wvEQp8o@z>

On Fri, 2018-10-05 at 12:25 -0700, Matthew Garrett wrote:
> On Fri, Oct 5, 2018 at 11:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Right, the correct behavior should be not to trust FUSE filesystems,
> > but since we don't break userspace there is the
> > "ima_policy=fail_securely" boot command line option.
> 
> There seem to be two scenarios:
> 
> 1) You trust FUSE mounts, perhaps because you have some other policy
> in place to ensure that only trusted binaries can mount stuff. In this
> scenario you already trust that the filesystem will give you
> consistent results when you read data from it - 

In the trusted mount scenario, we trust the data should not change
between calculating the file hash and reading the file data, making it
similar to other local filesystems.  Unlike other local filesystems,
however, we can't detect when the file changes.  For this reason we
need to re-calculate the file hash to measure/appraise the file each
time.

> it seems reasonable to
> also trust it to give you back an accurate hash if you ask for one.

Going from trusting the filesystem to behave properly, to trusting the
file hash that the filesystem provides is a major leap.  We don't do
this today for any local filesystem.

> 2) You don't trust FUSE mounts, in which case you pass
> ima_policy=fail_securely. This patch doesn't change that behaviour.
> 
> I agree that using FUSE in general is incompatible with IMA's goals,
> but it's possible to configure systems where you can ensure that only
> trustworthy code is involved. In that scenario this patch improves
> performance without compromising security.

If you trust a FUSE filesystem to not only behave properly, but also
to return file hashes, what is the value of measuring/appraising the
files?  Define a custom policy that doesn't measure/appraise files on
FUSE filesystems.

Mimi

