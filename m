Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333CC10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D5820880
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDIMFK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:05:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbfDIMFK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 08:05:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39C0Zkp014430
        for <linux-integrity@vger.kernel.org>; Tue, 9 Apr 2019 08:05:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rrt8utctd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2019 08:05:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Apr 2019 13:05:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 13:05:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39C519k50069528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 12:05:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB4AA405F;
        Tue,  9 Apr 2019 12:05:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A57DEA4055;
        Tue,  9 Apr 2019 12:05:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.143])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 12:05:00 +0000 (GMT)
Subject: Re: appraisal reset safety
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 09 Apr 2019 08:04:49 -0400
In-Reply-To: <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com>
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
         <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
         <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
         <1554729047.17244.95.camel@linux.ibm.com>
         <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
         <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040912-0008-0000-0000-000002D7E721
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040912-0009-0000-0000-0000224406C9
Message-Id: <1554811489.4192.15.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090078
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-04-09 at 14:46 +0300, Janne Karhunen wrote:
> On Tue, Apr 9, 2019 at 10:58 AM Janne Karhunen <janne.karhunen@gmail.com> wrote:
> >
> > On Mon, Apr 8, 2019 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > > The question of how much/how little to measure/appraise/audit is based
> > > on policy and affects the integrity of the system and its performance.
> > >  Detecting and updating the file hash each time the file changes would
> > > have major performance repercussions.  Even that wouldn't solve the
> > > problem, as the file change is in cache.  Writing the file hash as an
> > > xattr and making the file change persistent needs to be coordinated,
> > > probably at the filesystem level.
> >
> > As an experiment, I will add 'ima_file_update' function and call it
> > from few strategic spots (such as vfs write) and see how far that can
> > go removing the crash-recovery band-aid.

Remember somehow EVM will need to be updated as well for it to work.

> Adding ima_file_update in there seems to work fine and things stay
> nicely up to date. It is certainly heavy, but maybe this is only
> needed when sync() is intentionally being called for the fd?

I was thinking the same thing.
> 
> void ima_file_update(struct file *file)
> {
>         struct inode *inode = file_inode(file);
>         struct integrity_iint_cache *iint;
> 
>         if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>                 return;
> 
>         iint = integrity_iint_find(inode);
>         if (!iint)
>                 return;
> 
>         iint->flags &= ~IMA_COLLECTED;
>         ima_update_xattr(iint, file);
> }
> 

I would think there needs to be some locking here.  

> It would take an additional integrity hook, of course.

That's fine.

Mimi

