Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A3C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 22:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740B222C7
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 22:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfBLWv5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:51:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730088AbfBLWv5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 17:51:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CMmg73004034
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 17:51:56 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qm3u18837-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 17:51:55 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Feb 2019 22:51:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 22:51:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CMpnUK56229978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 22:51:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6030A405B;
        Tue, 12 Feb 2019 22:51:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A87A4054;
        Tue, 12 Feb 2019 22:51:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.85])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Feb 2019 22:51:47 +0000 (GMT)
Subject: Re: [RFC PATCH 0/5] Fix overlayfs on EVM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>, Fabian Vogt <fvogt@suse.de>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Date:   Tue, 12 Feb 2019 17:51:37 -0500
In-Reply-To: <CAOQ4uxgSZv7t5HznAhsWrzv3e3VwQ7sbZrjgjfRsviq-wsr7EA@mail.gmail.com>
References: <20190211165323.9369-1-iforster@suse.com>
         <CAOQ4uxhyk7BEmQYf8D6j8FvYJGaxPoa2oJePeF42jbdp__=PSA@mail.gmail.com>
         <3938260.lArqBy00Sx@linux-e202.suse.de>
         <CAOQ4uxgSZv7t5HznAhsWrzv3e3VwQ7sbZrjgjfRsviq-wsr7EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021222-4275-0000-0000-0000030EBE3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021222-4276-0000-0000-0000381CD4F3
Message-Id: <1550011897.12743.310.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120156
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> > > If my assumptions so far are correct, then the effort for making
> > > IMA/EVM work with overlayfs should focus around finding the
> > > places where overlayfs uses lower level vfs interface (often
> > > vfs_xxx helpers) and make sure that the IMA hooks are place
> > > in those lower vfs interfaces, just like vfs_create() patch does
> > > and like vfs_tmpfile() patch did before it.
> >
> > So basically turning on NOIMA for overlayfs while ensuring that integrity
> > checks and operations still perform as expected?
> >
> 
> Yes.
> As far as IMA is concerned, Overlayfs is like a filesystem user from kernel.
> Very similar to knfsd in that respect.

Fabian, if you're thinking of disabling IMA-appraisal on overlay filesystems, 
have you tried defining an appraise policy rule based on the overlayfs
magic number (eg. dont_appraise fsmagic=0x794c7630)?

Mimi

