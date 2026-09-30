Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3F377A94
	for <linux-integrity@vger.kernel.org>; Wed, 30 Sep 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739195; cv=none; b=jiMfAQzI3+LOxON4IGLrxbtYOsOUPNpoD6uulGbszpMj990MmGKdGCAJRVsn8zpuk3HQc2OJ+TT1oqF2thGc/ixCXtqTUdfYO+ImC6eLzMA4NgFr0ZEu3klt2TIClEOf5XYvYtVCJYJi0i/NpRP/gixoAXGVwwsWoYFvvvkOJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739195; c=relaxed/simple;
	bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe9vuuWobT6AiEpK/3xqKmYQk75NyCN8polq8lg9Oki1RGjbTYAelN2dO6rOU61HXLb4CANQNyna5HguUqBtFXDNwKIqw60ARPNix8e9f9SYoYudssulyZ5Q8wl4smBj2tqG8FTiied2vKn9KDgmIRlfCZGz0YvjT7pc81Iz4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzD1x6Ta; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzD1x6Ta"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so2199423a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 29 Sep 2026 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739188; x=1791343988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
        b=FzD1x6TaMXW/7kul3dD6K4OyYO79+c+9YKdNc6Yv2Opneo9SkZdZFxISW/0qc6LZwC
         y7rRouKLj6gb8ZJfSN+X1CjBDiAyTxonoNQKwwpBkL6ksFQkmkvFJTmlxQbBz47N+3DG
         ntb+jRgTSQMcftm2JDQhTfou/QcICpmteWIg5ykAB69BI1sPzoF2+jgORt+OCjsxV8sg
         79+iTBRUOip1N62gu3Qy4WjPjuRIjMaOoCpm/VhOQg+ABirm3CWHGpssSrUHoiRzohFy
         c2t7eQ+xwbDaEeilCBiCVC8btpkOGXyH6NzOcpk0KZjqFFU/IvWfw+ID9CdHWuOL7+aH
         C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739188; x=1791343988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
        b=mKsJiqeG7FQJ0tx5piuX9mO1pAski9C5GZP1+ldGLtrQklLzunSWpaSSTJEaMKiue/
         air8wbJoNI9gC8flkABtfly5D737mgHRZMe8YcZNqbWnnWfsh6l3KP6QEZ3OWoEOvS58
         yChgfGAB4eY6XCuwv2MQNaqpGklfPxl9yiOWY/NEEuHih2z/Rrj/pg0cMZ2D4vhqWd0e
         SlFVbY6QCK3VETAgX635hpMzBP0olTSm1jgZGxq+YMwBW3QaDqoWOJcgdlhmzBLAHXeq
         z6oWgoP/n3Dt97/t2nk/n5pLR30jXcmvlDST1IGUTSeljYbbAcJBItTnI0Qj+D9zz1SM
         zVoA==
X-Gm-Message-State: AFq9FYLZ1EVTSt7PoRLSJYTfIwllxn8t0f53kZOUEKrIiLKfWvu0Lmw8
	XlzzSa1d/CIiVzSP3m3olLFOZ+DEh1xdloN+0CeOaj50hGG4ibI+0c5W3kIjqA==
X-Gm-Gg: AYBFou3iGzzBLDoOU49D8Mo3QEKlIFucMjG5ru8O0n0oid7LoqM3qN575e8rpwl/SEd
	bklU7yb/IO7XefzNy3dSKXl47YEA1XfyICgtSwkCbDr8qsGdwXX27lBegZNaJ7IQtSGo3IB2FcK
	Y5XY3N7wg6zd79Lu7aPLJuOJqA8CeJzOFjVDbePeS3t/i07QR6QmdusIM1JMpRgx0fH4+7AUlsP
	pCC95Pr9Xaa4loK7BLA4x8+J1uPJZ+NAmVnXUJt42fpTa773GuULgwRgNym//zvY4x9suObc+82
	oHGFUSGaxypT+cBkmWXDYJXvcCl+Vt9NX6tGlxsCed52qKdu0Pt0wv/RmBjheza+69dEUZEO8Mv
	2jTe1dZimQFbUjaOOedAkfIzNN9rVnGQEf3qDxfJnL6pEmc1F6B903BHCyeON/JIPh4mUshp5B7
	06CBQxeNS7td6xqjz70S+PCTpRllTUwgFn+RLz3JoJ0nK/2Oo1wjJbSkPUme3TDric724DrLcNx
	6gLILA+KeseoqrU9JEwBdBYPd7KPrmSTzi8jlX/aJhdsU8JIOjJ1rMfr5/SlinLMfxGFyF043B3
X-Received: by 2002:a17:90a:d446:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-3a4d1b45841mr94775a91.44.1790739188069;
        Tue, 29 Sep 2026 20:33:08 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca7810d6sm1184417a91.6.2026.09.29.20.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:33:07 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Wed, 30 Sep 2026 11:33:00 +0800
Message-ID: <20260930033300.30295-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arw9CHc4mIOm5C6Q@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com> <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com> <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
> No need to resend a new version but I'd need a link to the *report* to
> retain reported-by tag here.

https://bugtracker.nebusec.ai/f/675

This is the report. The page requires a sign-in or registration
before it opens.

Thanks,
Yuqi Xu
