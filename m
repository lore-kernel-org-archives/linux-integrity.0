Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B81BA3D
	for <linux-integrity@vger.kernel.org>; Thu, 20 Aug 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217532; cv=none; b=Zuf/VM44549oVcUkSd02/rw05jI4beHDLj/p2+lcYMRslfmFmPT0wbhjA3q9UEWAwavc3RSMPT0GEwtJnPpFrfCdtgq8cuf8Aw80yX6XTTA64xNsMUX6JEBXLoh+t7Jq+c5PM+jSMg5QdjqyJo+tXOTaPYAK7Oxmo23ThgwGQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217532; c=relaxed/simple;
	bh=FEd40VCMk2TWuToVLvmpIITYeeckjE7+pl8v1xhTVe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlz21MsHbq1PGE20RjyZ/exfDkoRL1n741ed5dsT6K42d7v2jcOLm98Kn3xMdnkzgeheGXU2zEYIjP/zPgaFcVptMWcz+qveXh047nXWdWcyv9tN0MlNk5GB+ohtDUU68dnFdRKRIV7I6/YFa4afBcX7xGwgjaSTp3F3rucxFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F00blb+d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=76JRtykI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F00blb+d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=76JRtykI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F00blb+d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="76JRtykI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F00blb+d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="76JRtykI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CF4A3EE9;
	Thu, 20 Aug 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787217528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEd40VCMk2TWuToVLvmpIITYeeckjE7+pl8v1xhTVe0=;
	b=F00blb+dmWa9YJAPo3kThwzfK7rB2EdodCr8CYTeogQjwX5lulNapmB5S5AzFDryO866Dx
	fv89g4e6Sn2bGeMtNfRq486Nn1qhqcFPzuzKqfXQNX5RjS2uWPstTjhGkxZeDGOAkdlQ8S
	j4KGjwiQDa+7XYhmOSWKdhA5YcmXAXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787217528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEd40VCMk2TWuToVLvmpIITYeeckjE7+pl8v1xhTVe0=;
	b=76JRtykIxzmY5LDOpLjRHEdQFNSTUMsc88Gv/vLCH3Mw26XPRgS+80GUU6ldETrYnmbX0e
	zSdAKJbivM8/U4Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F00blb+d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=76JRtykI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787217528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEd40VCMk2TWuToVLvmpIITYeeckjE7+pl8v1xhTVe0=;
	b=F00blb+dmWa9YJAPo3kThwzfK7rB2EdodCr8CYTeogQjwX5lulNapmB5S5AzFDryO866Dx
	fv89g4e6Sn2bGeMtNfRq486Nn1qhqcFPzuzKqfXQNX5RjS2uWPstTjhGkxZeDGOAkdlQ8S
	j4KGjwiQDa+7XYhmOSWKdhA5YcmXAXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787217528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEd40VCMk2TWuToVLvmpIITYeeckjE7+pl8v1xhTVe0=;
	b=76JRtykIxzmY5LDOpLjRHEdQFNSTUMsc88Gv/vLCH3Mw26XPRgS+80GUU6ldETrYnmbX0e
	zSdAKJbivM8/U4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5130527A8;
	Thu, 20 Aug 2026 09:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id grxOEnjGhmqWPgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Aug 2026 09:18:48 +0000
Date: Thu, 20 Aug 2026 11:18:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_tpm.sh: update test2 to detect integrity violations
Message-ID: <20260820091846.GA3384773@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260814135704.1247403-1-zohar@linux.ibm.com>
 <20260817105556.GA1951950@pevik>
 <2fb152d374a14a0e30b20de73d74a90b195e0793.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb152d374a14a0e30b20de73d74a90b195e0793.camel@linux.ibm.com>
X-Spam-Score: -3.71
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7CF4A3EE9
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Mimi,

thanks for your fix, merged!

Kind regards,
Petr
