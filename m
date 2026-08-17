Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96B3EDE5F
	for <linux-integrity@vger.kernel.org>; Mon, 17 Aug 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006411; cv=none; b=BWVP96MvN6Uu8cxc8guFXPfnQR2xYPJvjkMuz85dUE6NGY8nLaknOo14hznCc3u8yCVQI7vRATmfhDblpfREyl+aLepGKl91tDaEUlj67hfJxHH5JbTVf/tqZ/WH3KVXWSPtV2j07jYCPHxLggV86LeI709kwLt3ydRAvRoo75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006411; c=relaxed/simple;
	bh=5pK2wFAPykXYbWKw9j+9CU+Sf7TV/OAwc60EQIbTSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPI446vG3SYqE/RgnDSeDlh9n1DJ6ThpncyRAcmvrFzwfdvsIyBXKwD+WJoujLrCLYAve7N6mEsb0WRMLH10i+dwdPGSlI8CF60l81wxJQAJzbvhqf1VGuZbe7LHyrrc1DkFZWy3L5tfWKeKSoIT4Xw1AauZE1gcj7inFqAQ5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e2Q7BH8I; arc=none smtp.client-ip=74.125.224.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e2Q7BH8I"
Received: by mail-yx2-f10.google.com with SMTP id 956f58d0204a3-66c711552cbso3213396d50.1
        for <linux-integrity@vger.kernel.org>; Mon, 17 Aug 2026 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787006408; x=1787611208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97BG6VtICGPgHi+9DUaQeQ2mZyM1OOusq8xn45jRUgo=;
        b=e2Q7BH8IVMaa7RPRFWTUM6wzLHffkALCx2eCbs7NQ8EDyB8QbrvTrCNxX2TXsxyOXU
         ke8t+PxxxZ2V8LvWCrEDIic83vL/EQvgjBNR85bzi9GWOW/zdFPdKf7v+pEt3pH0+W+3
         SQdFGDZWAMwx56Ez9enhwesft0CuiwBFcKbEhv29obGiTFTCRst9lRDIBmNaJE5lmgZu
         mMk/Q2rft08JBuFMekpcCA7nrjipyNYqQ6sdMl33LW1jEyVwmj33S9Sxyn3DFNqV7lS3
         gcppLHvzjPKVZWB7chQMGrsrx93XA1j7C3LxwUPokz4AmSqlqApKjNmWDTm9Vpro3kes
         9fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787006408; x=1787611208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97BG6VtICGPgHi+9DUaQeQ2mZyM1OOusq8xn45jRUgo=;
        b=T5dpe53DILsT5a+Yjtmkwk+7m+DUQpwW+CyEVqgtzbMk7rzYMwVS2KOY3N3X/hiTcI
         Sj7CdCf/3X501uiSfmxrBgLTD1FkXuXuE3777VLmF1El7iwZVJkYhXyVpkQhIMU3I7KL
         BszLG+CBsMmZcQ/e9WRkRhaOa9/JlHfC0IuNDB/ZfnflqWWvBwSGO3ruYprok/w03vzq
         WJlJ69Cp4/YEuNy7f+TEeHfvLICcyvtqmQwwEQTY/i2gH4FRGwe0VWhqHS3qC3ZHf85q
         spagI020mDPZNUrMAGVtZpvHBhqJz83xyC5D2fSdcBI3kQ9TgjgOW3xT3uLEpPxFTI1b
         tzyg==
X-Forwarded-Encrypted: i=1; AHgh+Rogu7MjS6te4AthtvmkDsyHmmcHqdJQeBKWXvTONR6t0s10wv8pYIRKnMHHPNpYBYcnq4z4ZS+LxVOcTZKhao0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hbv4IOc0pX15Hjf27xjD8Z6pxxYPekapdcvKSXNvhO4rxm7H
	V795bPX8wO22ugR3oDiv2bHI6KG88bSn53Ql46KLWvr01zpsXZ8I30gmIB07vJAXVSU=
X-Gm-Gg: AR+sD124uQPU16WOURM+E3k+4wR3tKf4k2xVU/wjZxs/oIeC+THkPrykt5BLp3UwVhC
	cdInfOhSqE3G/cG2CiubxAqspySB4+eENeAInZA2PkY4E+j7TuE0GJTGBW24pbAGYcTyYcQXLJH
	niqW+lZS3qy5fSwG4y8Q2sHI5lKjR8OnkYkYPrP5PRFLj+mDio/yknUtsvjzODTuQ7pOYXC5p6y
	hSJbkCalPqjQe0G9BvCIT5nEECc+aaw8lRCTKUulj7W/YAz5y0KSo+/kT3rOdSddZQnriFKxXMX
	vPOztmsv5VBg5llgHWxPa8Iosp+TMRZzfUz+fOOsINYM0hXy5LtUZWw8mUL96VTW4Zzfq2xZawk
	b3alqNs6bRDjYXBaAE9Q0e2cJgJnyE80XyyjXe0CcmPRfd/JplEx/VZoWuE7M1HOPVdEET9zgs5
	V+vNXqYgGB0IkZTXxF05csF57piZ5B+M230huF1NA=
X-Received: by 2002:a05:690e:43c7:b0:668:db:8c35 with SMTP id 956f58d0204a3-66cb9d15d3cmr1260532d50.20.1787006408368;
        Mon, 17 Aug 2026 15:40:08 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb57903d5sm1391547d50.14.2026.08.17.15.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:40:07 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:40:05 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
Message-ID: <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
 <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>

On Mon, Aug 17, 2026 at 06:21:57PM -0400, Mimi Zohar wrote:
> On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> > On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> > > 
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > syzkaller #0 Not tainted
> > > ------------------------------------------------------
> > > syz.3.857/8643 is trying to acquire lock:
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> > > 
> > > but task is already holding lock:
> > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
> > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863
> > > 
> > 
> > I had AI whip up a reproducer for this, but it's not mutually exclusive to the
> > added patch. Tested by running reproducer, then unapplied patch, still
> > reproduced on v7.2-rc4.
> > 
> > I'll need to simplify it before I post it.
> > 
> > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)
> > 
> > See below for un-applied repro result.
> 
> Hi Fred,
> 
> In response to this syzbot, I responded:

Sorry, I must've missed that.

> Like other pseudo filesystems, configfs files should not be measured by IMA.  To
> addresss this particular bug, please add a rule to the builtin
> dont_measure_rules[] and default_appraise_rule[] policies.
> 
> Without the configfs filesystem being in policy, can you reproduce the deadlock?

I was not able to.

Best,
Fred
