Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FB1A682F
	for <linux-integrity@vger.kernel.org>; Tue, 22 Sep 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097754; cv=none; b=bVJFHoxFYMX2vUGYcqOQ/9nT+LpipdK3wwlLBw7D2e3wXNur+5IeMzy7PXfXyCilWA+qcleeBKJP1u2Mp7Trp3XRTqtV84QrI5TJr66UCOtOVcVG2/Mm+Rb4wTEkPZsz/taeihd9sZjerENyMVILuHdEcG7MUzfwOibOLr49NgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097754; c=relaxed/simple;
	bh=g7SuTP3fubW3jzbw1+Tft2IbFV6PeGO8apkfVO0N0r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuiA555q45ICqGUjuboUl2xVwZSEM78PprHtAfgUfFahc8yYuGbW1iChsvzOxj4nWpD3xWz7WY6pYzwBv7+x/a38U/ga6ckMecvZDv6Nbe6TI6ggy3jBeDucvuWaQSFwHez4eOc5oH0AnU//wnr7WUh6n7KZ8ywDtKZm4bB8Szs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tlpB+QgG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8kwtYom; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckEWcOKq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dLyu+gEE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tlpB+QgG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8kwtYom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckEWcOKq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dLyu+gEE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4B971F769;
	Tue, 22 Sep 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790097747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOOz84Wxtq3lvai+00OLRzaumKaZUFaGN6yqK6agtLc=;
	b=tlpB+QgGsf6XCl+MnTIcEXwRJzisqqCMv77fUXH4LOvDtXXKBR4BWpjoFRAV+/8oLKif2+
	uZbXSTpt9+7vZ2a3Z10LpQ1NKS4PiqekzicR4rw0hyStoA0LXecNuarpVnTJV1wyDsqKD2
	t8DiH+KqMEMe+QKGNWUKwDsMnjTLFqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790097747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOOz84Wxtq3lvai+00OLRzaumKaZUFaGN6yqK6agtLc=;
	b=C8kwtYom2NdmzGWDFNSlNJrjfMFlZCY/KkcbhWdrFp+oW+26lDvY0siGM2rINg3SZp1jo5
	N2R597P6HHKywvAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ckEWcOKq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dLyu+gEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790097742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOOz84Wxtq3lvai+00OLRzaumKaZUFaGN6yqK6agtLc=;
	b=ckEWcOKqJCXg+CC+jZLbgmPHDlYxcRSy9G6hXgj/nN8KSc+mKljBW16zm6LfqBil7kDSP6
	YzGpZ1amKQxMqXldKvwm9cvtUDYeulUITr6F8SeDbzA3afr2jwQiaw4dNx8pf6T+9r7068
	EtPDnu2OEqVXizPeI7eoHtnjtm4W+oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790097742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOOz84Wxtq3lvai+00OLRzaumKaZUFaGN6yqK6agtLc=;
	b=dLyu+gEE/A/1ojPlreh3y1buihfJbFZxGYc7jMpxa5+DcmDeBdesX0KYsGZXgkofkQiujE
	8EJrs8fxoqxY5iBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B2E132D3;
	Tue, 22 Sep 2026 17:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7sa2EE65smqucwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 17:22:22 +0000
Date: Tue, 22 Sep 2026 19:22:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	ltp@lists.linux.it
Cc: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Use tst_umount()
Message-ID: <20260922172213.GB2287170@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260813112524.1849695-1-pvorel@suse.cz>
 <b901f8d94a9d6e3faf26a5e359ad8ec7e306c931.camel@linux.ibm.com>
 <20260814060102.GC261864@pevik>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814060102.GC261864@pevik>
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: E4B971F769
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Hi Mimi,

FYI I dared to merge following old proposal as
https://github.com/linux-test-project/ltp/commit/fc4c633f627121564e61c7cb3412976946c71562

to follow the approach used in other LTP tests (FYI we use the same approach
also for C based tests, see lib/tst_device.c). We can further improve the
function if needed (reduce number of loops or suggest another daemon).
Or finally remove it if it's really not needed.

Kind regards,
Petr

> > > ---
> > >  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > index 19f00532b1..054ab28611 100644
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -313,7 +313,7 @@ ima_cleanup()
> > >  	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER

> > >  	for dir in $UMOUNT; do
> > > -		umount $dir
> > > +		tst_umount $dir
> > >  	done

> > >  	if [ "$IMA_POLICY_LOADED" = 1 ]; then
