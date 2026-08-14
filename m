Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8720D4E9
	for <linux-integrity@vger.kernel.org>; Fri, 14 Aug 2026 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686644; cv=none; b=UHwQxH8tZXTFtdQrixBEY2cklAL7xyHVbhOuHi54Zyqkgh/lHRx7c0chuhcS4HqSjwjmZMKFv7ySpwMrMkEHf4nAktuP3C+0a72cUsY/zsY8+ndsA1z/pI4lgVmtfpE8yVaFITy3wJM2gGqJhT5H03VEYL/8oJZL7OqDe1u6E4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686644; c=relaxed/simple;
	bh=P6rtGvtAUZmYaZe9sYxPp/ePQELJY6rh7vOMRpMZcM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwF4fwDHdYnQazUmYmwZp31/gknKuDAaMKhWet4pSUj4yPFPk6dg5yoT29qWxfW+ysC9necaUdyuCI/N3d7WnCy0sQvgR6pp5Oek291EW9+BDBy1iyXU580Oz5Ue3fCICviGUPxSDDfQR5/4+tOIdWoYTgJpbALxYaB2/VzknCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jh0Tyn9u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=46kPZjSE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pd5Sd+15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w9vqxEZ1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jh0Tyn9u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="46kPZjSE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pd5Sd+15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w9vqxEZ1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 298123E9E;
	Fri, 14 Aug 2026 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786686641;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6rtGvtAUZmYaZe9sYxPp/ePQELJY6rh7vOMRpMZcM4=;
	b=Jh0Tyn9ugDPA2nDJqAOfsguNRm8mYp0FvgI2PI28CdkuTrMCePM3C5BuxW6vLFM+0rwP4z
	F22sDnXBndJeDmqI5Ecx3aVHSqCmSKh+TQ5D9tb+Az3srXqCYXWnv7vdOxCtvTSM/TTOJm
	sxft0RmRUov5ynhw8SINucz80yW8M1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786686641;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6rtGvtAUZmYaZe9sYxPp/ePQELJY6rh7vOMRpMZcM4=;
	b=46kPZjSEDRZCyQhaboP/jpKveoFPeqwuKrGntjDkEiF09zvP2jTtKf6HaCUyPpUugqU8PZ
	ecbI+Kkt07+h8aAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786686640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6rtGvtAUZmYaZe9sYxPp/ePQELJY6rh7vOMRpMZcM4=;
	b=pd5Sd+155DGyl5T2IYa/1Lzf4VVd2CbDUJ1FwA52vHVYEeQCopuv96XsKwGsLMSbcSTGFa
	LSIcVmTqWQBSMk5nEL+d8WqP+J+/dImFZC/GZmlcPflutICIOkJ3wU6KxqrAQLDxjGEDwn
	2DjOx9V0aEkprrR0OOYn+gYUNPZGJus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786686640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6rtGvtAUZmYaZe9sYxPp/ePQELJY6rh7vOMRpMZcM4=;
	b=w9vqxEZ1MBe3fPdNxElDzRHMpSpwq8qw2LapQC5sv2qP3L1by74MdeBAz0SkxYTPKyKuVN
	bHpX7q1wjr5SkDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0402178209;
	Fri, 14 Aug 2026 05:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1DyOq+sfmqvHAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 14 Aug 2026 05:50:39 +0000
Date: Fri, 14 Aug 2026 07:50:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ima_policy.sh: Require kernel 4.5+ for test02
Message-ID: <20260814055030.GA261864@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260810143344.1029588-1-pvorel@suse.cz>
 <20260810143344.1029588-2-pvorel@suse.cz>
 <2651c2c94ced4a363a5206a983cf7fd86c46def7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2651c2c94ced4a363a5206a983cf7fd86c46def7.camel@linux.ibm.com>
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

Hi Mimi,

thanks for your review, pushed!

Kind regards,
Petr
