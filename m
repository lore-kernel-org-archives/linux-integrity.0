Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A03AB285
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069320; cv=none; b=qneFamxM7oCyiA58MHL4uMpKiufSVhiHsJpHJZskdXAYv/bzzi8LKeE6/NtRyyUHspWsZCoRz2v5EawKfjUaoup9KNu4QchjzMOQTEMHEZuos0ZF6aNhMwVbXKX4sX5x1AlC5Z6PnpzynKnyifQPcTDfU9kNaWp3JtMoyxONmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069320; c=relaxed/simple;
	bh=lJ1SGUYjvv7Q+4vKjzQTm53BmSckzM+Pj6cLFT/LgXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzG3AjqLJk3WiYmLrbLjPfvhvM7OlLMxtSKi+ud/QW4JxAdVdBVew14MX//qUiKE/hB0fW5wTsf/FfNAxqKJYcvwBOKVjy5UrYioC2lkLS2+nD9B+jtVnjzccjLIafOWU8MnHisx5pqN9NcGML9XpJ9iay4IWE6CQQzCaY3963Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F4LV8oni; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ApwJoQWV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGiDMR9J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oruXwbBx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F4LV8oni";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ApwJoQWV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGiDMR9J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oruXwbBx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F9031FEDC;
	Thu, 10 Sep 2026 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789069311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ1SGUYjvv7Q+4vKjzQTm53BmSckzM+Pj6cLFT/LgXo=;
	b=F4LV8oniNvfk5sJQirmsQNv60LDPQFZMcsZBIsIDrPOMUXhkD3oErnfQ7mreRhxDIAK2ok
	CT6EJmOZm0QSnqVgyDKaVOCq9P50ZYiC3zgFlt5eP8SM2PwyJYzyxlgpESO7/xo625naKT
	M+8lWYIRBGETZdqoe0Lmp1OkCw7x22I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789069311;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ1SGUYjvv7Q+4vKjzQTm53BmSckzM+Pj6cLFT/LgXo=;
	b=ApwJoQWVqaZt1SVtXNwrAF3Y1NWqJIha9Pq+6joUcWqspIFQhCv9OA+PeRFb29d0m2Ze8x
	Y9RerjSqiBWHH6CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789069307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ1SGUYjvv7Q+4vKjzQTm53BmSckzM+Pj6cLFT/LgXo=;
	b=VGiDMR9JnT5dvqPnMf4ba9h/dgKa2+U0A5aNkb6iLFOahveP/sBxDBcNsC/kxCf75sFJUP
	q8zfN6QUhTdoY/zApvyvqUi6dK3QAxat0MFbq8JPdIphoo5bro61x47X0FnCM5JEVpYP4w
	9O6CBpOIZ1z6JA7A9zt/EtE4NmdgjdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789069307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ1SGUYjvv7Q+4vKjzQTm53BmSckzM+Pj6cLFT/LgXo=;
	b=oruXwbBxFbzPZmasEgTVQt2KbD9dudgKkez4Iv6wVh1MHT0QZAWPO7uaXeo957Hr4nD3GL
	yf7tzs0Cdz5yd9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C4B1326D;
	Thu, 10 Sep 2026 19:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NSD2EvkHo2r0EgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 10 Sep 2026 19:41:45 +0000
Date: Thu, 10 Sep 2026 21:41:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH v2] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
Message-ID: <20260910194138.GA270563@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260826222913.802598-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826222913.802598-1-zohar@linux.ibm.com>
X-Spam-Level: 
X-Spam-Score: -3.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]

Hi Mimi,

> test2 attempts to compare the aggregate PCR-10 value with the current
> TPM PCR value based on the current measurement list, but does not take
> into account that the measurement list might have grown.

> evmctl returns success/failure when verifying the IMA measurement list
> and displays the measurement list line number that matched.

> Update test2 to check the return code, before failing the test.
> Include the matched line number and total number of measurement
> list records.

I was not able to reproduce the failure on VM BIOS (legacy) running on UEFI QEMU
host which I reported previously, therefore I merged it.

Thank you!

Kind regards,
Petr
