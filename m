Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B2406805
	for <linux-integrity@vger.kernel.org>; Mon,  3 Aug 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763204; cv=none; b=SneNSiO6LHlPBhItjiNjb+U1eV0ouuG79GIVKk/kT1LQA5HG5goe3/EFwxHCjF9NsksRtpZ23NbJ1Qsm3/gO34A95bNMI0DYOelrFgR+jVU8KHjgKBtwDQm5cIEl6IJhsFRxoC4KiHDSeYm/O8FrXyduA3OMVgZn7t4a+MJ+224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763204; c=relaxed/simple;
	bh=7Vdg1HwGf1Qa8hm4i/CpjqVG74TmMzwcAJndg8uhMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J95Am5ZFrGX38lDyiUUYKgPyi9aFa/UdF+nPQpPECy3SIvpnKeQ9AeB4T5b48XKhqAjfzUz8hmNUwjGZM8t+LvH0TY/snawK/RVrU6CQIZbwPt/IUGWqjn4mtsmlVyTAag5MP8uzJ7y3V3ITMUOScH0zOzifWIRessbaVJYkF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOBvDtia; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9379y60P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vjnc2EEE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tueBKFxR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOBvDtia";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9379y60P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vjnc2EEE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tueBKFxR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 292AE3EAE;
	Mon,  3 Aug 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785763188;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xex4gDmUrkMtCu2K3xhfG39PROTmk4ZI/me32sTYV10=;
	b=qOBvDtiaui3Khs8VHwyMVto1+rmCVYHCmqa0nLVt7j6T61cAPxKn9kWativZsHAPE/aozI
	+yAPmqyMjZznXxy6VCRjXCh+Y/gLaXf2I8Mu4h13vee3IHrr3VmB/eEOdCfskt+V6j3AyU
	eErUMhcri2H8XbSttNQp1Fz5CNpvpbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785763188;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xex4gDmUrkMtCu2K3xhfG39PROTmk4ZI/me32sTYV10=;
	b=9379y60P5sBptabx3q9aA5uq71VIkirN+Zkau9isCM9ZPzp6kx50gwvrFD1si9Mr02ZHzh
	ae6zu/0X7unfArCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785763184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xex4gDmUrkMtCu2K3xhfG39PROTmk4ZI/me32sTYV10=;
	b=Vjnc2EEEiQhI73t/FcPCtt5BtphNbneO4HfqCL834GE29Kf62Cib1aTvt/aekU8FNg8x09
	Quqy612YQQdXyGRwz8swfPhOkb81yTaWDxl+MjYFzXJhfA0cKfItkXln4IeFy8fUTf5+JV
	XjwJhHAQYrhSOwhsRNDlR5OpYfmjxAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785763184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xex4gDmUrkMtCu2K3xhfG39PROTmk4ZI/me32sTYV10=;
	b=tueBKFxRHc4thLLEpmNvhazq+iUiRZvRrNIkcrgBlbgFAmQRVR6gJIYCfvE0S1TnL7Z4IX
	Fp/hPpNB0OQm5BCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC6E3779A1;
	Mon,  3 Aug 2026 13:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tstoOG+VcGp1fgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 13:19:43 +0000
Date: Mon, 3 Aug 2026 15:19:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
	linux-integrity@vger.kernel.org
Subject: Re: ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
Message-ID: <20260803131942.GB246496@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260728114224.1055009-1-pvorel@suse.cz>
 <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
 <20260728133556.GA1128467@pevik>
 <7279643f66b2ea6d6888716f7923363c2f59b6eb.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7279643f66b2ea6d6888716f7923363c2f59b6eb.camel@linux.ibm.com>
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
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[tst_test.sh:url,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]

Hi Mimi,

first, thanks for your feedback!

> On Tue, 2026-07-28 at 15:35 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > once you have time, I'd appreciate your comments. Thanks!

> > > Hi Petr,

> > > On Tue, Jul 28, 2026 at 01:42:24PM +0200, Petr Vorel wrote:
> > > > ima_setup.sh: Fix check_policy_writable() for kernel < 4.5

> > > > -	# workaround for kernels < v4.18 without fix
> > > > +
> > > > +	# Workaround for kernels < v4.18 without fix
> > > >  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > > > -	echo "" 2> log > $IMA_POLICY
> > > > -	grep -q "Device or resource busy" log && return 1
> > > > +	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
> > > > +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")

> > > Is CONFIG_IMA_WRITE_POLICY really the reason for the 4.5 boundary here?

> Yes


> > > On >= 4.5 ima_release_policy() runs ima_check_policy(), which returns
> > > -EINVAL when ima_temp_rules is empty. The empty write therefore sets
> > > valid_policy = 0, ima_delete_rules() is called and IMA_FS_BUSY is
> > > cleared, so the probe stays non-destructive even when
> > > CONFIG_IMA_WRITE_POLICY=n.

> > Well, CONFIG_IMA_WRITE_POLICY did not exist in kernel < 4.5 (not sure if that's
> > obvious from the comment I added).

> Perhaps prefix the commit message with something like:

> IMA allows the builtin policy to be replaced with a custom policy just once. 
> Support for appending additional policy rules to the custom policy
> (CONFIG_IMA_WRITE_POLICY) was subsequently added in linux 4.5. Refer to commit 
> 38d859f991f3 ("IMA: policy can now be updated multiple times").

+1

> > > What makes < 4.5 different is the absence of ima_check_policy(): there
> > Yes, that's true that ima_check_policy() was added in v4.5.

> Agreed.

> > > the empty write is committed and securityfs_remove() drops the policy
> > > file. Would it be clearer to state that, and to keep the v4.18
> > > permission workaround in a separate paragraph, since the two comments
> > > describe unrelated things?

> > > > +	if tst_kvcmp -ge 4.5; then
> > > > +		echo "" 2> log > $IMA_POLICY
> > > > +		grep -q "Device or resource busy" log && return 1
> > > > +	fi
> > > >  	return 0

> > > With this, require_policy_writable() no longer TCONFs on < 4.5, so
> > > ima_policy.sh test2 ("verify that policy file is not opened concurrently
> > > and able to loaded multiple times") now runs there.

> > Hm, maybe test2() does not really makes sense to run on < v4.5. But test1()
> > certainly does. And echo "" > $IMA_POLICY really disables policy in v4.4,
> > likely due one of these from v4.5-rc1:
> > * 38d859f991f3 ("IMA: policy can now be updated multiple times")
> > * 0112721df4ed ("IMA: policy can be updated zero times")
> > @Mimi WDYT?

> Writing an invalid policy resulted in never being able to transition from a
> builtin policy to a custom policy, similar to writing an empty policy. Commit
> 0112721df4ed ("IMA: policy can be updated zero times") addressed the invalid
> policy case.

Thanks for the explanation.

> > > On those kernels one loader gets -EBUSY at open, the other succeeds and
> > > the policy file is then removed on release. That hits

> > > 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
> > > 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"

> > > so the test reports that the policy can be loaded multiple times while
> > > only the concurrency half of the assertion was exercised, and loading
> > > twice is not possible before 4.5.
> > That sounds correct and should be fixed.

> Correct, IMA originally permitted transitioning from a builtin policy to a
> custom policy.  Support for extending the custom IMA policy was added in 4.5.

Do you agree that test2 in ima_policy.sh should be skipped on kernel < 4.5? If
you consider useful running the test also on these old kernels I could just
correct the commit message for older kernel or simply ignore that fact (just add
a comment to the test that it's irrelevant for < 4.5. (I know 4.4 is not
supported any more, in fact it's just for SLES and possibly other LTS distros
still supporting this old kernel, but I still appreciate your opinion.)

> Mimi


> > > Should test2 report TCONF (or split the two assertions) when
> > > CONFIG_IMA_WRITE_POLICY is not available?

FYI we could sooner or later start using kernel config (e.g. look into
CONFIG_IMA_WRITE_POLICY and CONFIG_IMA_READ_POLICY as many LTP tests and now
even LTP library require kernel config (we resisted long time add kernel config
as a hard dependency, but finally Cyril added support in 2018).

But more important for me would be to migrate LTP IMA tests to shell loader [1]
or even rewrite to C API. We have deprecated tst_test.sh API some time ago.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html

> > With requiring test2 to be run on kernel >= v4.5 (I'll add it to v2) everything
> > should work even with this patch (unmodified behavior on >= v4.5, avoid write
> > policy on < 4.5 when doing the check for ima_policy.sh test1 and for other IMA
> > tests).

> > > Verdict - Needs revision
