Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30343F0A0
	for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245781; cv=none; b=Sib6yW636Vbl2Ouk4BJMklygJCn5ufC2GqM/p9DWLOV9cT5jhKnSM2r5kKkI//IVAEH18GbOxR2SUUt6d/uvKk+4CDVRtb1V/g8uMdljrP7eG8apECm2zDzWy14okRKsT93KvFWldilOwZ+GZB153XtBArvKegNjTh5qgrSjQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245781; c=relaxed/simple;
	bh=jFb4NEgm+qGAeWQCHHZdv0QEx4x5XRSd5vEwmjfSPAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNIN03OSQJsxTUvOhV3cgGw1Fo4ZWiTYo/pOC5imzp5BRFwRCiXuOBYvss09jhC8tMgCOB/0GosfK8RHdi3OC1x+f3rMxinjbHwe5l7pB/XFEzoItd/uZQlvJiKR4M6voGhyYLfzJ1+yLcdXKsR5axIQcT0hLB0b6T6JCmLt564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSz/Ksf4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsR0PWIp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MG3HkDac; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScDslEyu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSz/Ksf4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsR0PWIp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MG3HkDac";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScDslEyu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C803F7C3BB;
	Tue, 28 Jul 2026 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785245767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txwnUYha9Sxl5FyRqjyaQvZAcHk+Y32HHqjnfCKkrrQ=;
	b=TSz/Ksf4KZQpwcdUbvQN1lo2kizsjyxpaT13xgVD1ttwVCsy27S2NiYdCiIyuy9la8IcUc
	dr1sPAZuRdMK4iubDGkLrbt6RprrRpLHiT4akmSVEkI0/vwhtpRNK4vBz4JGybwg0oyKt1
	PQlJPtHHKm37dL7iMcPKys1D6kYfdjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785245767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txwnUYha9Sxl5FyRqjyaQvZAcHk+Y32HHqjnfCKkrrQ=;
	b=bsR0PWIp0TdYaG2Oc6trK8PXaRPXK/czOwxXgF1eMUP/xB8ctH5Pa5sIWUBsT1JyfoD2/A
	3BcNDIcO21OlgsDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785245762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txwnUYha9Sxl5FyRqjyaQvZAcHk+Y32HHqjnfCKkrrQ=;
	b=MG3HkDaccFpxwpNjWzXCNxfZNF7C/ZUu/nlr+pgdnzCu9sdXxBS4NKkvKR+NU6N6/rvWuR
	rgqdYt/isKZZxgOh4SQqi5vKXwh043uLdkYWN7e1857U89x2xunF2eMAHUFKUlZct4UvdK
	G5Z1eWy8eZPLFS/pB7chrMzJRAOK0kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785245762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txwnUYha9Sxl5FyRqjyaQvZAcHk+Y32HHqjnfCKkrrQ=;
	b=ScDslEyuzPTWw6dFeoTWWnMJHUPLpfSBstedDjVYlkyatrnAnWNzIcb0oMZJ2WXMtADKs8
	WDQ7mYVywuiXJ1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14704779B3;
	Tue, 28 Jul 2026 13:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcHlOUGwaGr3YAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 13:36:01 +0000
Date: Tue, 28 Jul 2026 15:35:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
Message-ID: <20260728133556.GA1128467@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260728114224.1055009-1-pvorel@suse.cz>
 <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
X-Spam-Score: -2.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]

Hi Mimi,

once you have time, I'd appreciate your comments. Thanks!

> Hi Petr,

> On Tue, Jul 28, 2026 at 01:42:24PM +0200, Petr Vorel wrote:
> > ima_setup.sh: Fix check_policy_writable() for kernel < 4.5

> > -	# workaround for kernels < v4.18 without fix
> > +
> > +	# Workaround for kernels < v4.18 without fix
> >  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > -	echo "" 2> log > $IMA_POLICY
> > -	grep -q "Device or resource busy" log && return 1
> > +	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
> > +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")

> Is CONFIG_IMA_WRITE_POLICY really the reason for the 4.5 boundary here?

> On >= 4.5 ima_release_policy() runs ima_check_policy(), which returns
> -EINVAL when ima_temp_rules is empty. The empty write therefore sets
> valid_policy = 0, ima_delete_rules() is called and IMA_FS_BUSY is
> cleared, so the probe stays non-destructive even when
> CONFIG_IMA_WRITE_POLICY=n.

Well, CONFIG_IMA_WRITE_POLICY did not exist in kernel < 4.5 (not sure if that's
obvious from the comment I added).

> What makes < 4.5 different is the absence of ima_check_policy(): there
Yes, that's true that ima_check_policy() was added in v4.5.

> the empty write is committed and securityfs_remove() drops the policy
> file. Would it be clearer to state that, and to keep the v4.18
> permission workaround in a separate paragraph, since the two comments
> describe unrelated things?

> > +	if tst_kvcmp -ge 4.5; then
> > +		echo "" 2> log > $IMA_POLICY
> > +		grep -q "Device or resource busy" log && return 1
> > +	fi
> >  	return 0

> With this, require_policy_writable() no longer TCONFs on < 4.5, so
> ima_policy.sh test2 ("verify that policy file is not opened concurrently
> and able to loaded multiple times") now runs there.

Hm, maybe test2() does not really makes sense to run on < v4.5. But test1()
certainly does. And echo "" > $IMA_POLICY really disables policy in v4.4,
likely due one of these from v4.5-rc1:
* 38d859f991f3 ("IMA: policy can now be updated multiple times")
* 0112721df4ed ("IMA: policy can be updated zero times")
@Mimi WDYT?

> On those kernels one loader gets -EBUSY at open, the other succeeds and
> the policy file is then removed on release. That hits

> 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
> 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"

> so the test reports that the policy can be loaded multiple times while
> only the concurrency half of the assertion was exercised, and loading
> twice is not possible before 4.5.
That sounds correct and should be fixed.

> Should test2 report TCONF (or split the two assertions) when
> CONFIG_IMA_WRITE_POLICY is not available?
With requiring test2 to be run on kernel >= v4.5 (I'll add it to v2) everything
should work even with this patch (unmodified behavior on >= v4.5, avoid write
policy on < 4.5 when doing the check for ima_policy.sh test1 and for other IMA
tests).

> Verdict - Needs revision

> Pre-existing issues, not introduced by this patch:

> - "log" is created in the test working directory by
>   check_policy_writable() and load_ima_policy() and is never removed.
False positive - file is removed during cleanup of the temporary directory
because all tests use TST_NEEDS_TMPDIR=1.

> - $IMA_POLICY is expanded unquoted throughout ima_setup.sh.
False positive - /sys/kernel/security/ima/policy does not need to be quoted.

Kind regards,
Petr

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer
