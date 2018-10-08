Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8867AC65C20
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5839520858
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 13:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5839520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeJHUkA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:40:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbeJHUkA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 16:40:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98DO7C5063797
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 09:28:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n06w3kdkb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 09:28:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 14:28:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 14:28:12 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98DSB7G22675570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 13:28:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0594E4203F;
        Mon,  8 Oct 2018 16:27:49 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E68342041;
        Mon,  8 Oct 2018 16:27:48 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.101.74])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Oct 2018 16:27:47 +0100 (BST)
Subject: Re: [PATCH] Open a new file instance if no read permissions on files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date:   Mon, 08 Oct 2018 09:27:59 -0400
In-Reply-To: <20181008121455.za53z7kgfizgtiv7@merlin>
References: <20181005214213.ickkfgu5a7tzzenk@merlin>
         <1538874061.4914.16.camel@linux.ibm.com>
         <20181008121455.za53z7kgfizgtiv7@merlin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100813-0008-0000-0000-0000027C82B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100813-0009-0000-0000-000021E5B930
Message-Id: <1539005279.15382.119.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008132759.ut-f1FrgvAIFjHUTxsPermO-HCbUN0ZVfua6BgChXvA@z>

On Mon, 2018-10-08 at 07:14 -0500, Goldwyn Rodrigues wrote:

> 
> > >  
> > > +	if (!(file->f_mode & FMODE_READ)) {
> > > +		struct file *f;
> > 
> > I would define "struct file *f = file" above, at the beginning of
> > function, and "free(f)" below, without modifying "file".
> 
> I suppose you mean fput(f).

yes

> Okay, if it makes code more understandable.

Thanks
> 
> > 
> > > +		int flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
> > 
> > Doesn't O_RDONLY need to be added?
> 
> No. O_RDONLY is zero. But I think I should add it for readability. The
> compiler will optimize it eventually.
> 
> > Please fix the line length.
> > 
> > 
> > > +		f = dentry_open(&file->f_path, flags, file->f_cred);
> > > +		if (IS_ERR(f))
> > > +			return PTR_ERR(f);

It's late in the release cycle to be making this change.  Would it
make sense for now to fallback to modifying the original file
descriptor on failure and emit a message?

Mimi


> > > +		read = 1;
> > > +		file = f;
> > 
> > With the above change, no need to modify "file".
> 

