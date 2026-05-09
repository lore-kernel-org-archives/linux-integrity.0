Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB422339;
	Sat,  9 May 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366112; cv=none; b=MlEXBI5k9EYaJDEL4UpaxVf+ZM14wDOylTgFlKEJI6zh+7Ojh9okxpW7VmRrhtIzCDCdQSDE+wYrIny+d8Rn6C2lIXA28sYTY+ErN+4wSvlNd1yOjLIFaFI9QpmBbjhLWGFtVuv/9Jfc7HXnxiGxn/SbioWzPXuvZsGc0bCk/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366112; c=relaxed/simple;
	bh=3ggDWOYg1zueNiEz54OLLrQA9RIFaDCTBAys/Sw7XKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1tXyHQoKelENQkZC4olufIMDOZ5R9EqxUYKA9v9xNRaJZ9P7zahzj4KoACX28TwcUPx+z17yQm2hSR+f4p0bbGHtHr//6oHgsXa9YEP/3RhIXRPo11vG62HchpB2fWNuVqQ5/21qg5fNzhkxYQrKLsbW8tBZRyHNitSjbvIZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FT/bvBaE; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FT/bvBaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778366110; x=1809902110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ggDWOYg1zueNiEz54OLLrQA9RIFaDCTBAys/Sw7XKs=;
  b=FT/bvBaEAejZ+GrlPy6cEj3YLE+xlQRunRA6RRcJOUtOKN1lmN+EVdQM
   jnITZZ0wFYTxWcDhsxAjthT0sFGXav5D8lCDVIUHbIG8US19Fxr5hEqxv
   ZfHbDbm7z/y20OSWQevWRp/E9dNVAf7+8ht9aAGtAL1ebqTlL1rnqtJSw
   /VnLtTB7Y5iryhVIAGv+WdbfKMT8NnXvPwD9cY72KlWBpdot1YD4p5OuG
   GRI1L0erbUGsM0Rt3NoQwep+9DUGfIjY1458SQezSqHdUPcfRcL6Pv048
   mjMDHh4LDawU3bTWhFcRuFyQbCMuM6Lydmv7JSPwIbG1nCFUpegjl4hN9
   Q==;
X-CSE-ConnectionGUID: Txrya74mTU+wp+B+kAc4lw==
X-CSE-MsgGUID: 4TLloRnvTrKQLZJ9NnZZVg==
X-IronPort-AV: E=Sophos;i="6.23,225,1770595200"; 
   d="scan'208";a="19281900"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 22:35:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:1730]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.133:2525] with esmtp (Farcaster)
 id 3060a3aa-f80e-44c3-ba63-12551ac94a92; Sat, 9 May 2026 22:35:09 +0000 (UTC)
X-Farcaster-Flow-ID: 3060a3aa-f80e-44c3-ba63-12551ac94a92
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 9 May 2026 22:35:09 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sat, 9 May 2026
 22:35:09 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <jarkko@kernel.org>
CC: <gunnarku@amazon.com>, <jbouron@amazon.com>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mhijaz@amazon.com>, <noodles@meta.com>, <peterhuewe@gmx.de>
Subject: Re: [PATCH v2] tpm: Fix uninitialized name_size_alg in tpm_buf_append_name()
Date: Sat, 9 May 2026 22:34:29 +0000
Message-ID: <20260509223500.4390-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <af-MeEbJFmab4YQ8@kernel.org>
References: <af-MeEbJFmab4YQ8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, May 09, 2026 at 07:35 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> This is great observation but it is not a regression technically.
>
> Thus, this really should just state the issue and don't make it look
> like a bug report based on transcript that does not happen in the wild.

Thank you for the feedback, Jarkko. That's a fair point. Since no
in-tree caller exercises this path today, framing it as a regression
is misleading. I'm happy to rework the commit description to present
it as a proactive hardening fix rather than a bug report, and drop the
Fixes tag accordingly.

> I guess this is better than parameter removal since name caching would
> make sense [1] in future.

Agreed. Keeeping the name parameter functional makes the API ready
for name caching without further changes.

Would you prefer I resend with the adjusted description, or would you
like to suggest specific wording? Happy to go either way.

Gunnar
