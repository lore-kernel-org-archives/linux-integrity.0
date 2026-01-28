Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC21DE2AD
	for <linux-integrity@vger.kernel.org>; Wed, 28 Jan 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604723; cv=none; b=nok8z9bST3OjdOTLAYWWMP7ZMXNs3Bbob/G1mJOO7fMzliUS8LDDPXBWoo3F6vTiGXPGntcWXIrC3/cwzFVL5ya6uOb7fo2gkzyOUwWzQIXRrAXwVVhhN0kll341v2yjQ2ZNBQyK9pkxcM31uEmQPCM0So2udacZTDDSGF2FvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604723; c=relaxed/simple;
	bh=d9w1dBCTZLPhjKfsmJFdpLeLjpyy4giCFfnyiQqr4Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cizgjwXqVfaoGXhHSSGS8Si0/kMnmwFzyZ7yF9TBpy4emxCYS/K8FqIOYoXZmwUHmvQRc2LT1iNC7XCx6IggxR/+PZDtBMsHsEJsCECdWRHVG51xRAAVqNOPIO4W07sN13xonn6uNgCmkCrLW8jHNAOdpuwLcNmlSmuvejmNyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOsdeEPl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jKJZT3f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOsdeEPl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jKJZT3f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOsdeEPl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jKJZT3f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOsdeEPl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jKJZT3f"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE00333C28;
	Wed, 28 Jan 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769604719;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNinW1eTZdSGTcg2ulm+U7vrlwRCjYgowggCsg2pWkw=;
	b=EOsdeEPlhUWTsuuFjE4cCKY9Tph9U3v2ikrIpGee2E8odroNjqQuAQF0t9obeev28KuZ4j
	BvUQ2fNra9kGOvJlUQuJVtrtuQ6Sw0SoBd/Q/VCQaNyNahskOX5I6cvRquAF8rE0Y/Yrv7
	aDTc0y6gA0ot4DRPyeXrG79Zo6D0E3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769604719;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNinW1eTZdSGTcg2ulm+U7vrlwRCjYgowggCsg2pWkw=;
	b=7jKJZT3f+H2iQvdauGeIX/1f4x5yO70/NUk1qfAtQcpiq5cMQjEYX4JNghOA/n6kYm5xih
	07I8es518UqNq7Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EOsdeEPl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7jKJZT3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769604719;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNinW1eTZdSGTcg2ulm+U7vrlwRCjYgowggCsg2pWkw=;
	b=EOsdeEPlhUWTsuuFjE4cCKY9Tph9U3v2ikrIpGee2E8odroNjqQuAQF0t9obeev28KuZ4j
	BvUQ2fNra9kGOvJlUQuJVtrtuQ6Sw0SoBd/Q/VCQaNyNahskOX5I6cvRquAF8rE0Y/Yrv7
	aDTc0y6gA0ot4DRPyeXrG79Zo6D0E3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769604719;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNinW1eTZdSGTcg2ulm+U7vrlwRCjYgowggCsg2pWkw=;
	b=7jKJZT3f+H2iQvdauGeIX/1f4x5yO70/NUk1qfAtQcpiq5cMQjEYX4JNghOA/n6kYm5xih
	07I8es518UqNq7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C1363EA61;
	Wed, 28 Jan 2026 12:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cboBF28GemlcHgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 12:51:59 +0000
Date: Wed, 28 Jan 2026 13:51:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_setup.sh: Fix check of signed policy requirement
Message-ID: <20260128125157.GA35959@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260121083343.127613-1-pvorel@suse.cz>
 <20260127131755.GA146899@pevik>
 <447d5d46a8ac3ed8a8283d87bd555459a2679495.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447d5d46a8ac3ed8a8283d87bd555459a2679495.camel@linux.ibm.com>
X-Spam-Score: -3.71
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE00333C28
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Mimi,

> Hi Petr,

> On Tue, 2026-01-27 at 14:17 +0100, Petr Vorel wrote:
> > Hi Mimi, all,

> > > Kernel code in arch_get_ima_policy() depends also on
> > > CONFIG_IMA_ARCH_POLICY added in v5.0:
> > > d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")

> > > Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi Mimi, all,

> > > FYI I'd like to merge it this week to get it into LTP release.

> > > Kind regards,
> > > Petr

> > I dared to merge this to get it into upcoming LTP release (this/next week).

> I'm so sorry for the delay.

> Only if CONFIG_IMA_ARCH_POLICY IS configured, should check_need_signed_policy be
> set to true and the test skipped.  However, I'm seeing:

> tst_kconfig.c:531: TINFO: Constraint 'CONFIG_IMA_ARCH_POLICY' not satisfied!
> tst_kconfig.c:477: TINFO: Variables:
> tst_kconfig.c:495: TINFO:  CONFIG_IMA_ARCH_POLICY=n
> ima_conditionals 1 TCONF: Aborting due to unsuitable kernel config, see above!

> Instead it's requiring CONFIG_IMA_ARCH_POLICY to be enabled.

Thanks for the report. I'm sorry, I should have used tst_check_kconfigs binary
directly, I'll send a fix shortly.

Kind regards,
Petr

> Mimi


> > >  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > index 1bce78d425..df0b8d1532 100644
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -466,10 +466,11 @@ require_evmctl()
> > >  }

> > >  # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
> > > +# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
> > >  check_need_signed_policy()
> > >  {
> > >  	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
> > > -		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
> > > +		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
> > >  }

> > >  # loop device is needed to use only for tmpfs
