Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1407CC65C20
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B05213A2
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 21:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B05213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJIEcW (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:32:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbeJIEcV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 00:32:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98LEuwT017747
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 17:18:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0a453n2n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 17:18:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 22:18:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 22:18:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98LIXQA21364740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 21:18:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 041384C052;
        Tue,  9 Oct 2018 00:18:11 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ADEC4C044;
        Tue,  9 Oct 2018 00:18:10 +0100 (BST)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Oct 2018 00:18:10 +0100 (BST)
Subject: Re: [PATCH] Open a new file instance if no read permissions on files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date:   Mon, 08 Oct 2018 17:18:32 -0400
In-Reply-To: <20181008153014.vb4hd7xdpbsbbrxg@merlin>
References: <20181005214213.ickkfgu5a7tzzenk@merlin>
         <1538874061.4914.16.camel@linux.ibm.com>
         <20181008121455.za53z7kgfizgtiv7@merlin>
         <1539005279.15382.119.camel@linux.ibm.com>
         <20181008153014.vb4hd7xdpbsbbrxg@merlin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100821-0016-0000-0000-000002103A80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100821-0017-0000-0000-000032679C33
Message-Id: <1539033512.15382.133.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080199
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008211832.uBHiusaapWNwAKvbA4Uc_2TT0j3j5z2pSjHZ-cK70yY@z>

On Mon, 2018-10-08 at 10:30 -0500, Goldwyn Rodrigues wrote:
> On  9:27 08/10, Mimi Zohar wrote:
> > On Mon, 2018-10-08 at 07:14 -0500, Goldwyn Rodrigues wrote:
> > 
> > > 
> > > > >  
> > > > > +	if (!(file->f_mode & FMODE_READ)) {
> > > > > +		struct file *f;
> > > > 
> > > > I would define "struct file *f = file" above, at the beginning of
> > > > function, and "free(f)" below, without modifying "file".
> > > 
> > > I suppose you mean fput(f).
> > 
> > yes
> > 
> > > Okay, if it makes code more understandable.
> > 
> > Thanks
> > > 
> > > > 
> > > > > +		int flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
> > > > 
> > > > Doesn't O_RDONLY need to be added?
> > > 
> > > No. O_RDONLY is zero. But I think I should add it for readability. The
> > > compiler will optimize it eventually.
> > > 
> > > > Please fix the line length.
> > > > 
> > > > 
> > > > > +		f = dentry_open(&file->f_path, flags, file->f_cred);
> > > > > +		if (IS_ERR(f))
> > > > > +			return PTR_ERR(f);
> > 
> > It's late in the release cycle to be making this change.  Would it
> > make sense for now to fallback to modifying the original file
> > descriptor on failure and emit a message?
> 
> Yes, perhaps and it may still succeed. Won't it be misleading if it does?
> Would ima_update_xattr() be a good place? Not sure if it would spew too
> many messages if there is an issue. I am all in for modifying the
> original file->f_flags on failure. Just not sure about the error
> message.

The message should be an indication that the dentry_open() failed.  So
it needs to be in ima_calc_file_hash.  Perhaps use either
pr_info_ratelimited or even pr_info_once() to limit the number of
messages.

> Currently, when we perform IMA hash calculation on a O_WRONLY file with
> overlayfs, there is no error in dmesg. Just EACCES on the _next_ write
> which makes it difficult to conclude whats wrong.

There should be an AUDIT_INTEGRITY_DATA message emitted by
ima_collect_measurement().

Mimi

