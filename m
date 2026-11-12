Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524283;
	b=Ux8Rr3ZloDhTHNryHzu+O/IvpMxUepmVtP338PehcICYKrvKtRalLJKRzxVbGhhDzCMY
	 3lDjKc4FXEtH4c0N6NeaIOz7V4SNvB8il7v/Vqthzq/jdlVRL1Qkd0LCHy8+pHGZbtsUF
	 uPYVxvt4zFb7RjtUEpLLSkpZXV8xwv1t7WyrpaF3CPvdgyUrxUsbnRx/csMOj/LJ1w9H7
	 yxaJ3RvcBRoNE7G+Pe9z74AfepXsD3TN86vN8IH2lEDtR5m1Qh/NW+2pr9fZkzKfUYdB1
	 YbL/ILzYDsjxlbwxywgy9kucqQVYaTil0tktFGQK1CgWE8iIptwDUCuQs8beyY52RJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JU2KdlNCWChtwOGEK4t+3b5U2FFf6L0dWazuccFpC00=;
	b=POdLGuomPqtbNnuZSM78Sf4EnpSZdIyAYNgmNiN3Kk2cbShcEUnyFXt7y8KiCFXlhZ9q
	 MIE+BmElwO8DA3xKUmFzoEPGf4irkoqgVaXHRS5/BaRe2daXmjO3T67dIgmeT7EDlCs+P
	 StmjnTum3fklIJyPf6ydOu9ntft/bJF8bwS2gkq2ERjsVMJgQvzWTakAA9fFVzibkDiBQ
	 W0MBaUzKH24glDZvin3tmXj1lCB4BEtg1ATLuTcqEswbyHvglV47ZGuHUSIkYs+VRBIxD
	 /R729GMXkj5Qzc+vmuk5CFs06cWwvQHOf3vITcH24qgpmUE3RpnfPYrkfUqCCTfah/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLzKbq0S;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19D606A32E
	for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 22:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E19D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLzKbq0S
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49412eb1474so133514f8f.3
        for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524281; x=1795129081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JU2KdlNCWChtwOGEK4t+3b5U2FFf6L0dWazuccFpC00=;
        b=dLzKbq0S9jffvXmHMq6+KAu1wJiPnl6u+w60yb7r5b9HWZblYVLqfAvYuYzo4ubX5o
         yJ0U48SXMhYAfvV5F0J/XJBqSfTmDENY8FJ+bFyiBgp7tKwahFq9RSmeRh4QhzF93OZP
         +0CHO0X6won5A3/Mly4fNV0++g4NAKTTVF2XNjwajQyNQv+YMPMbdp94Tbh5g5rzg4j4
         J2KTGtx8P/jPq8X+fvW1h+WRjVI2/kT6fT6EolOyGG1XAjTX+rWBMCuspx/bKLO4iD9j
         IMWZBCmP/5YtCx3ISxaGrR+NngPSUqb/r14cqDltV4gOoGPvmJDXQ1qcqpdipltnzpaV
         XSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524281; x=1795129081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JU2KdlNCWChtwOGEK4t+3b5U2FFf6L0dWazuccFpC00=;
        b=QizE0UOca4zTmFByVu9fUbsbFXHAJ7c9B+e0lJuwy/Lyix6vKGxBRHOeK9P2+KDMFW
         ZERnVFgzsC4IFTumBP9OROUZvxajJiHUNnMzyLSs8VhrutrJPqe6qImIlcYutUc0dJU9
         31h1EtP+ESgCxiD9LkqYxM/kCfo75OWsPZZpXQE3kLShHITiO48yWqySAw8sl6ufc5VB
         cyhiIf+eytCx00ai8Y9C5FmHRMNdUn+vI37tCaMcbQaqAwpeXm/vdOZB1gojYAQU9BEM
         yR/hzWKm+z//MOlhawqW60HpePp2j9yMJC7avBb/PPNRhoa54QMCITr8Sh5faYYzlBMb
         1KLw==
X-Forwarded-Encrypted: i=1; AL+hErF7NjSHwqSPnJpn+48XgMM3nNBRs9fOdudvfpggsN/YHcDj9f/Nt3cGwtgugfgyya+Rz1SWN+oh59XicEEQgOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XOtkakWl+sp93cmd5fIiaS3vXplbqzaG/fy10vvpdSB+2Rb4j
	Y2mexf335G8B63f0ptRr7yLhfVmkBHV6hPBNFagx8PsIlHcC5lzH3YiA
X-Gm-Gg: AYBFou3+FYqQ9BPIXNmU71RcDKvmktoEDqBZ1Za6INa+O8fzBpMV73bzVG9ontWCnQt
	HSYNM13ipus43KysHs+t0xk6ZcyMRkN4j2jbChjAgwkqovDovQZWyM64PMuvjTWqn2xs+XPgrda
	wT2t/WnuVA0N1pGZ6OCGUhz+9re4Hx947rid4snTlZJXmas4CDDrpmvzZu9FWNI29NRbAD7N12a
	dXMVZmC3jNuw6dEKLx4z6HUUVpvWuNj/i/FUYSitXK/RK3cS0MN3Vabztxe4Q/0/N3BrPaUbpNi
	2O+pR4QFUXhlkctnqfmU7gQ1d62pOauGHc234NcO/6Ppb1MQkJ30QEaB/hQUNmhiJNV1US0hmy2
	qEL8ZFARaZT0QAx3UQ5xHe598/d5cf8TDRMhm73QzFWtqqkw6jtfYqHIbdgd1LsbFGjlKtOrhLU
	92siZTBLhRG4sL6jgV3bQ99az3V06vH8KbYJyQNzHWXD5PqU6+AMO930g9V9nb4B4fkDwMHEUZp
	rQjG0HLe9DGjHwYd2QL+9eHwkdVF7u1rxjDc4zrkJmyWFchkZNjTGG2JwGvKzAjSy7MU075TPr+
	xQjKi22h9il59RwNVgUHWQVrrqU7nrOEa8rrs8ipRRq1sDnly0TIjraud80keyrGaQ==
X-Received: by 2002:a05:6000:2587:b0:490:2bd4:5c42 with SMTP id ffacd0b85a97d-49c7353bd0fmr1523749f8f.44.1794524281035;
        Thu, 12 Nov 2026 14:58:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223b21sm2000159f8f.2.2026.11.12.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:58:00 -0800 (PST)
Date: Thu, 12 Nov 2026 22:57:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, surenkj@amazon.com, noodles@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
Message-ID: <20261112225759.67730166@pumpkin>
In-Reply-To: <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
	<20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 04:30:18 -0800
Breno Leitao <leitao@debian.org> wrote:

> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> If the TPM has been spuriously disabled, the game is over. Let's reflect
> this truth with TPM_CHIP_FLAG_DISABLE.

Shouldn't it be completely 'game over'?
(aka panic time...)

David
