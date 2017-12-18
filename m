Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758627AbdLRPa5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 10:30:57 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBIFThtv041426
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 10:30:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2exd8d9jvx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 10:30:56 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 18 Dec 2017 15:30:52 -0000
Subject: Re: ima:  temporary "next-queued-testing" branch  (UPDATE)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next <linux-next@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        James Morris <jmorris@namei.org>
Date: Mon, 18 Dec 2017 10:30:47 -0500
In-Reply-To: <1513029726.3530.29.camel@linux.vnet.ibm.com>
References: <1512564458.4698.33.camel@linux.vnet.ibm.com>
         <1513029726.3530.29.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513611047.5221.18.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Stephen,

On Mon, 2017-12-11 at 17:02 -0500, Mimi Zohar wrote:
> On Wed, 2017-12-06 at 07:47 -0500, Mimi Zohar wrote:
> > Hi -
> > 
> > Before upstreaming "ima: re-introduce own integrity cache lock", I've
> > pushed the following patches to the next-queued-testing branch for
> > testing.  We'll resync with the linux-security tree based on -rc3,
> > hopefully next week.
> > 
> > d79d361c25d7 ima: re-introduce own integrity cache lock
> > 4e94bcf160f2 ima: support new "hash" and "dont_hash" policy actions
> > bd1fa1e14733 ima: Fix line continuation format
> > cf46932b9a02 ima: pass filename to ima_rdwr_violation_check()
> > 4aad0b3845e4 ima: log message to module appraisal error
> 
> We're now sync'ed with the security tree next-general branch.  There
> are a few differences, nothing major, between the "next-queued-
> testing" branch and the "next-integrity" branch.
> 
> For those posting IMA/EVM patches, please base them on the   
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> branch.
> 
> Sorry for any inconveniences this might have caused.

As the integrity subsystem is now back in sync with the security tree,
 I'd really appreciate if you could include the integrity tree in
linux-next.  Instead of including the integrity "next" branch as
previously, could you include the "next-integrity" branch instead?

thanks!

Mimi
