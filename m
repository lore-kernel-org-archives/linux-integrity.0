Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFB3793D3
	for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976428; cv=none; b=BxUUQrx9Goolg0E2CL5/bhKctua4Ehf2rAN1FdzcZK2/ypKiR37M9Ey+e5IXDPQInyTKP7SsxZZp9K7Gd44lh/7t4N8Td+sNvOg+5zGt0WkFA6cNT8dhuLX0KAAIrC4Osr7bA6AX2RiwGSwQj18i40kwmuYsA3PGgzigNkkSx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976428; c=relaxed/simple;
	bh=c/i490OXbFpkfgBsFCReQhspvRl0PoEXDMLnbXAz9Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN8FXi9I67WZdHmuZKWieVyGrqkWfvpcpMa1ejWtlkT8VPG9pR3cDJX6Wn9DDIb6PAHMu1JyWaALYzBFKaBxP2m36l8L1yz9CTgK0Vw6rZik9hOjVPEpOeQ++DBw137n45WX4+p/SOS0YhkUexjnxmnZ5sX+gDGYZmhdQjP6GvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HvF1LeAh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HvF1LeAh"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8706dfdcd4fso80699237b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Sep 2026 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788976426; x=1789581226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRIgg3iSuevNT11a9+TD/UWqT0ngKKbrlCWnrPVS/0g=;
        b=HvF1LeAh4DQVg5v4KsaPg4Dv0qbFIjmuxl8+CejoQrKaLsp/LIhchtp+CvOxmi7Jrm
         u54UL5BCIGdt87ycq/Bo5mTs31Xrdqwss7RZ8k3lEfme8f+nxz+W1vgCI+F18yUOTP7s
         d3/NmQIofc6J6VDTxijc4hOm2mdCwLNH3buKLKNOo/Hw2gRgad2YJWVSTjorDxUK5Qf+
         BMieBQpNYNX1Tks7+dM3FFjlCZ1p1ehsrj7h/6CZmuXHvhckKdh8xAloLfdHFHFW2Hk6
         c83wKGXRISJG5o6+yywDC+x0dKrcxxveARgomkrzIQJcIIVIvPUTSZj8qQxFh6EHKQdE
         qUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976426; x=1789581226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRIgg3iSuevNT11a9+TD/UWqT0ngKKbrlCWnrPVS/0g=;
        b=NBXtOEiZ4SYOZuGMujHe0Avs8yzgbcdoWyugi43Wwx70BIQ4ZpR5lICCC1HQBoQaP7
         5c4YuPrVxXt3q69EV4nqf60bFDDG/LJCQBRkRr24uh+8eaXWjHvjXLbu6+E0C6KP5fpB
         FHfqBpANxC8qfmm7fXVSZIcesbt94fh74njDCLQXSepPkH1TTgVqtFH8DJXBUnnPL48O
         E38E/vg9oiyeuZb7Gx/neuLmqj48sQOuCvBFa27cDX014rEA9wmUHKjQSBJZUJNzCab4
         6piI5HFLhl66CA+IRx8QUWt7lB0upIz61bdyTUN4+aTZZ5bPJyzYqrzup6S501FYBicL
         Lpag==
X-Gm-Message-State: AFuF++mVYNXPhMBcmU3pnvjfFrzewBsfQk2PinSuUW5x+neNHgiwNCgw
	lxdOJ30NmbMDM3RYBlMSndquQDoHiCcOdW1ZeM2xI1gxv7h32BFj5pVK6r/7RJ4ZRMg=
X-Gm-Gg: AYBFou1RjG54TvV1/DiCXd0L/ZhDEvGm0vMf+uOophlGFDIZO2i2miAVUiaalwZD5pK
	5RHw4qUxfOhxvcm+wtrssc876Yt3lzt8gqyzSMQ35JJn+/nXJ+abFrJ3SIwGLLHaZ7F4jnm9+8s
	4UIjhiIVV/KvC75NQStmZGyUe4nLQ8vRU33Y12DUCJJm9gySv5fiPy6A6Jepj9qEF4m8jC/azGy
	KO8fr1ys7CRdZUXN6LlP2B7xN8y08xUx2ZF4r28M9qiNK7QU/a1DDJ7AeR59ybAz8NWBrpb9glW
	umD0jmAlJC3M3IALBEvP825pMja2ECz8MKYMHD9iJHdY8TxaP4e9CsexbSmammvR4JmQ/MTi8jX
	RlJY1+E9h8QSWMqOJf8pDKZKZAaU0LiSjSic4WkIL1IZVt/1+szqEHeZeE+rhzYac2GoaiduJ4T
	GPacsgunKYUKNHWUHCBYPDPjRvx7lp4Y9Y7jz+hI/Y6fsOn67RKQ==
X-Received: by 2002:a05:690e:1244:b0:66c:707b:60eb with SMTP id 956f58d0204a3-66fb5a149f7mr11250899d50.23.1788976425617;
        Wed, 09 Sep 2026 10:53:45 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:7d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb7c7e8d7sm11902088d50.14.2026.09.09.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:53:45 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:53:42 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 0/3] integrity: Return error codes in audit messages
Message-ID: <weadqcqqw3e4snwysfnx2fszrxctppkqqgdjrkfyn7uh5poczp@dpnp6tl3mk6u>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>

Hi Mimi and Roberto,

On Mon, Jul 27, 2026 at 05:21:46PM -0500, Frederick Lawler wrote:
> Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
> introduced an audit log function that can take an error code. It is
> wrapped by integrity_audit_msg() that implicitly sets the error code
> argument to zero. The problem is that there are uses of integrity_audit_msg()
> such as ima_collect_measurement() that hide the failure cause for
> the message.
> 
> This series aims to convert integrity_audit_msg() call sites to
> integrity_audit_message(), and then expose error codes based on the
> following criteria:
> 
>     1. The log depends on a result from earlier callee, and/or
>     2. The caller function itself returns with that result
> 
> ima_release_policy() is the only caller I thought made sense to keep as
> is. The message doesn't correlate with a return code, nor does it
> depend on a result from an earlier callee in the function.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> This is probably a bit more than what was asked from v1, but as I was
> making changes and looking at other call sites, I didn't think it made
> sense to keep integrity_audit_msg() around anymore.
> 
> Changes in v2:
> - Changes from v1 are now reflected in patch 3.
> - Replace all instances of integrity_audit_msg().
> - Convert to patch series.
> - Link to v1: https://lore.kernel.org/r/20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com
> 

I think this series may have fallen through the cracks between the merge
windows. Shall I respin + rebase?

Best,
Fred
