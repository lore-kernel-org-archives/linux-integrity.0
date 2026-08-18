Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5D33F5AA
	for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081992; cv=none; b=rBn3lsMOQ73P4Wv+zT2CcLactzBwrQXRwz2ItszDcIJN3yQVNUzjUFiVsc5DxxbfaCs/Wxt5/RSZazd/kCCNMcKVr++nbt0TO7puyOTRwooXelnzaB6gPme72XL9OHtx0VkPFESu2o/nGv4e/lHZLh+3cEtOd2uIT40RhKz+Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081992; c=relaxed/simple;
	bh=4+UTR7Z7d5DwpYL503R5TO4vWVuUTpEXPr+HACLyLwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbGNW9ZhgSfascxavQMbIC1dOzVDIpCpjVk9zw7ZSMA5m+L7Yu+h+bQj1EZxVWOoqbSHBmf7//zUuw6XW2oVV14EDyokZXVlBNrqodooOlLiGq7RqlfXcUpDwp1aQ6oGFrmLseaZXC87Y1/+5v/fPGIyRPSR4QrrfbYR/aSCLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IWN95f3c; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IWN95f3c"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so100996b6e.0
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2026 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081989; x=1787686789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LtuU+tO63aCvSR2Bm+1jaIeVmDj7SPmB1MVl55mOpg=;
        b=IWN95f3cMOxRF+fBlNnOSw+rrp0ZpsiKqQjJ9stXCvtFf7CUTfu2wdGOack2yKuIiB
         VB3N1aVnyZlajTHLCj7RjVNyacvyCIsjJVhngX7pDrChtAHSf/qvBdnXYimvu1NN/wuL
         3PNesodW7M1u02AQtAry1FG4NumJyEQtOeJSqFlYs1YyttW1J34bEHhMZIJ/DRXiEY3k
         SH3HA1TusuGOUYSFC7bEXpj04AbRVyJ4r9/ur46BFJ5kvyWnXtYwqSxAoTqNJUg7YXOJ
         WQ1LcrWL5r6+7rM6BQCcAcj+/0Yqb71EnuNn79yvBBgWCJenpBudRPjW/FDy/tRXCXqH
         v1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081989; x=1787686789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LtuU+tO63aCvSR2Bm+1jaIeVmDj7SPmB1MVl55mOpg=;
        b=eRxiUhXsD3OMS4/aIMa41lHvXHlU3c1q+e9JbXOVrsYqMuu8nK2IZhEPGMy4kyDczQ
         bap+NX1ddkVkq9v3f6M3RnRsmVqwnK8MDsN8PY3aswegZVkxxV0YAypn+Fzw5vVr/rCI
         mk2J2L5a79+k83TFhutMvPnh9PMWVmzKNqrz/kl25kJQ3cfn6xvet0vQu13rfS5tsECv
         NkQYe+oQbFmRxNA+TmzCifPNwDbAa7YuChZi6aXrLUg8r2JdjCL8A5X+2JJadPT4HLmj
         gJIByifQwMHW9q7xEjmv3EDTEQy/EWZaHPtO4EnMfGcd+u3uL+dq2VjsYzu0pRU0M+uA
         8RYA==
X-Forwarded-Encrypted: i=1; AHgh+RqY9E+6AgwXptvB+PwM/B+w0AzJEMtUtFM7IHZTjXNoZC2udx0hGLFZUtRoLjdmu0VZQRFcysPNiKX+CwgcAhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWZp5vXZ8tJ9L7jpNT76VWzcrBXCwPZo9HFcTHhlaIVjm6zEB
	xUD8AGO7h9jtgMmY4hMIz2NC1YakFD7FxR1FGitRXtC6KglE8Qfnql6PjxBola2lwm0=
X-Gm-Gg: AR+sD11yO+/i0rZh60c0QUnsfBdexdkSN7GbjPxPI50LC1xknsgeI6MS0xYduagTiXK
	/3cbq/rj5yGF1QZEX3xe3XtrZkujCpECcG6RWQI50HI1nNSQLHbC/zQ4tnDB2+1JdbxUMQu0DIK
	A5FwyTo4Tl2pBOB//MU2NzTGCjBAPD5nrfzzrrtGd7YGwdZozmaxnNVlBEto0cSIq6XLQ6ioXNO
	96cja78NgAMnsGibSmMQukUvT4aB8WKgrv3zjIqBgo85RHDQVqpHBOCeX6SB8asRmwBVuk9APy8
	dMQ5oDeLqpmjvCJ6jIGwr9+Tl0WcxtiNobZEEN6l1pKOMYBOtN4C2Ndh6oaNdcwAn0hDbSNR/f0
	AuwEaghWb97lAYIOixJsHQRIm68zWLcL23pgRuFsuWLwodwgxBjdv4RikGpaHC/f5v14I+ZUo4k
	ToblZC+NV5NZQtyBMg7VIT78ycCFt1bIxMraco0oo=
X-Received: by 2002:a05:6808:c1e3:b0:4b2:98a3:a567 with SMTP id 5614622812f47-4b2b8fd69d1mr746b6e.4.1787081988851;
        Tue, 18 Aug 2026 12:39:48 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2960e32dasm4070878b6e.15.2026.08.18.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:39:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 14:39:44 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
Message-ID: <5jqpdvvwpkrtsvtujrxm4mnuggsaztmm7etwmus3gwznxh5fch@gs5aducakh4q>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
 <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
 <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
 <415f81878ac595830e5b5051a5828311c2434e03.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415f81878ac595830e5b5051a5828311c2434e03.camel@linux.ibm.com>

On Mon, Aug 17, 2026 at 07:32:43PM -0400, Mimi Zohar wrote:
> On Mon, 2026-08-17 at 17:40 -0500, Frederick Lawler wrote:
> > On Mon, Aug 17, 2026 at 06:21:57PM -0400, Mimi Zohar wrote:
> > > On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> > > > On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
> > > > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > > > 
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > 
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> > > > > 
> > > > > ======================================================
> > > > > WARNING: possible circular locking dependency detected
> > > > > syzkaller #0 Not tainted
> > > > > ------------------------------------------------------
> > > > > syz.3.857/8643 is trying to acquire lock:
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> > > > > 
> > > > > but task is already holding lock:
> > > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
> > > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863
> > > > > 
> > > > 
> > > > I had AI whip up a reproducer for this, but it's not mutually exclusive to the
> > > > added patch. Tested by running reproducer, then unapplied patch, still
> > > > reproduced on v7.2-rc4.
> > > > 
> > > > I'll need to simplify it before I post it.
> > > > 
> > > > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)
> > > > 
> > > > See below for un-applied repro result.
> > > 
> > > Hi Fred,
> > > 
> > > In response to this syzbot, I responded:
> > 
> > Sorry, I must've missed that.
> > 
> > > Like other pseudo filesystems, configfs files should not be measured by IMA.  To
> > > addresss this particular bug, please add a rule to the builtin
> > > dont_measure_rules[] and default_appraise_rule[] policies.
> > > 
> > > Without the configfs filesystem being in policy, can you reproduce the deadlock?
> > 
> > I was not able to.
> 
> Do have time to post 2 patches - one to move the configfs magic number to
> magic.h and the other to update the IMA builtin policies?

Sure thing. Here's the post[1].

I rebased on linux-integrity/next-integrity.
(forgot to include that in cover)

Best,
Fred

[1]: https://lore.kernel.org/all/20260818-configfs-v1-0-a2329043cf86@cloudflare.com/
