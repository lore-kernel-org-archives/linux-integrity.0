Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239707;
	b=QGvLDvpLxjMm24WBmdJpn9Z6LEYeyKhE00VjD1BwJ8pkwMwZRlS91/ITTjISozfVmR90
	 aW4d6Tsj7sCbjc1H03GBvgyrEhW6P3ATrgwiydAZBw9G2Dt32cyZGpFclZjFzYYl6y2LD
	 QMIzx9xcSQK4DjKvh9y4l8q75t8KTQ3lgrHhf9geKEjV0V8EwKeEjle7Kn3ORwRDHbeYW
	 82ttTrqOqzJ00CzmaJZ1AbgGfdOwC4JuB5PTQTFBqidr6wM9PMtdEd3RygbYWf9fvjeGA
	 9sOjIBjiZrS4XoF1vLp0lKBaR/iLdk3dh1IzNv1TCVYbJG1fnmofoqBw24BfEJxk0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239707;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Q0X+iS3Yev6GJQ7IG+vLyH9URNbzXi7MgDFOd5gJdEo=;
	b=geFcEtZYHep1bpqk6fxQdpMtlFOAzv1szoQDfW7vp5jcAlsmf4EKQxDf5vbO4lxUIHz0
	 FrhhgfExYiB5XdxDpRkfX/Z7QNNhwGajhMp2fMO95xW1xNMiZTX8+Mjy7fWeNRJdUkpB1
	 OIZHmF36MMIj0kbxdO3ofHiPVDFItmmteEQJefSGd96yeh/ZbgWPPnCnAacx1Yu2FUfCO
	 DfmrP0rg9irWIMB2jpZJ65MnaiGct1j3808SUcUubVZD6L9Qn47Xuu85kZSQg9v16txPj
	 B1OMj2RhwS3pte7OeA44eIRvAyDbuyS+O8KKmUN5MElodVPBJxqZ8sZwPpMzqADbQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pOD2KVdw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vQHZJnfR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pOD2KVdw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vQHZJnfR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44654606EE91;
	Mon,  9 Nov 2026 15:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44654606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pOD2KVdw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vQHZJnfR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pOD2KVdw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vQHZJnfR
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E14E1FB06;
	Mon,  9 Nov 2026 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794239704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0X+iS3Yev6GJQ7IG+vLyH9URNbzXi7MgDFOd5gJdEo=;
	b=pOD2KVdwtMpgJK2i4gXXynpyfeSL2/wHQ7ILt/gRflE7Szrj4IUXmGk4tUWW7z0FjL89c8
	VwmyrXpHYbmMbEsmkfMLUpPirAe5UqGqoxO6dOSaYknz0tLSrP6nijIg0URHlns6lfpwz+
	6BvW5gpidUrhGcHTtaqSTKkwtXlUwtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794239704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0X+iS3Yev6GJQ7IG+vLyH9URNbzXi7MgDFOd5gJdEo=;
	b=vQHZJnfRHvNzMnHVnh3EAbONDaDKmKWpenGtmYnTdCY3Cie503EEcCoTh7P6+7i0L90ydp
	PEw0gtoijB+5h4BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pOD2KVdw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vQHZJnfR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794239704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0X+iS3Yev6GJQ7IG+vLyH9URNbzXi7MgDFOd5gJdEo=;
	b=pOD2KVdwtMpgJK2i4gXXynpyfeSL2/wHQ7ILt/gRflE7Szrj4IUXmGk4tUWW7z0FjL89c8
	VwmyrXpHYbmMbEsmkfMLUpPirAe5UqGqoxO6dOSaYknz0tLSrP6nijIg0URHlns6lfpwz+
	6BvW5gpidUrhGcHTtaqSTKkwtXlUwtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794239704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0X+iS3Yev6GJQ7IG+vLyH9URNbzXi7MgDFOd5gJdEo=;
	b=vQHZJnfRHvNzMnHVnh3EAbONDaDKmKWpenGtmYnTdCY3Cie503EEcCoTh7P6+7i0L90ydp
	PEw0gtoijB+5h4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EEA513319;
	Mon,  9 Nov 2026 15:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+7uN9fs8WqZRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Nov 2026 15:55:04 +0000
Date: Mon, 09 Nov 2026 16:55:03 +0100
Message-ID: <87mrriuhig.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error path
In-Reply-To: <avHl-WoBP73QjInD@kernel.org>
References: <20261109082527.541901-1-tiwai@suse.de>
	<avHl-WoBP73QjInD@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,ziepe.ca,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 5E14E1FB06

On Mon, 09 Nov 2026 16:25:45 +0100,
Jarkko Sakkinen wrote:
> 
> On Mon, Nov 09, 2026 at 09:25:24AM +0100, Takashi Iwai wrote:
> > When devm_add_action() returns an error, we do NULL-clear
> > log->bios_event_log unnecessarily before calling tpm_bios_log_free(),
> > and it would lead to a memory leak of the allocated log buffer.
> 
> I don't understand this. "NULL-clear" is gibberish when the actual
> bug is just spurious clear of log->bios_event_log.

It's not "spurious", but rather ill-behaving.
Because it sets NULL before calling tpm_bios_log_free(), the actually
allocated buffer won't be freed at all.


Takashi
