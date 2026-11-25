Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647641;
	b=TaoehORYnmUW39IhiGLnNOZRWttU9MCfoOkLZ6YXQW7KFlcDku2uYgg+CQp/5si7oZCp
	 gxZoF15F9z7b2IKS6vNs6+16DvD3NPTS++elu9c1mkyJUaCJhHQ4R5nLc4CkBTz9iYlok
	 9TV2wnuJQQlHFQLdkhwo+mR7wPsJhYw7N/nWRcbHyyNrVgMJXRAUXp915UrUqVdB365QV
	 p5QaLuuIyivlyK8xGrelUQlUaBDKkqGkK5ZXBuHhvgLGPvBfVPHM8+nWW3cs2idChKICw
	 kA5xMzTBTEhX4jJKF/u8BduhGs+X7R39Zresx3Ta+5h27SRaEqFtlE3Hkj20akN1+9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647641;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TsY4BV/+ObWxXathrekPiFRx0vLYjHLDJuIBQPvLmmY=;
	b=RBHfvo1XMubw5X0hdMBL10gZz1hsLD3iNNBnsoZRL4uZnUEwcsvOjxiYB7nSAc5g4wPt
	 Cmili/Wz9/iLOFyl5lrE1X3X13GfKgHlZvVCjfq9pYMvxtbC6bd7omD9D9LG5TuTvMsPZ
	 JFdbqFE3KzJ4Nx6pTe08zB0YdCeOa5LHvcNzVU+oikaZRB6AT0PugpWykh3Rd43nDVLEy
	 fGWtCivU7dohW3i0w5lSPsPp705ORpE9dnV0tIrxjZmxHUUl3iNb1Uhztc6Y0QFWkQGpn
	 Qq6R6jgY+ysUQ/sKCEUDW0TdXzcBz34ygQWFVXWYOPVPL0rseYCnHK2OEpTLyKn0kPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lsegGIeU;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F1606A336;
	Wed, 25 Nov 2026 23:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288F1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=lsegGIeU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795647641; x=1827183641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsY4BV/+ObWxXathrekPiFRx0vLYjHLDJuIBQPvLmmY=;
  b=lsegGIeUDvUvnoyh1KLIY3AIF/Y0+OL3KonpEG2TuvlGrdd/swuravx+
   tffr5qnioEwpUZaxdzT5ZOlAIv/NzJLdf9NlAOC1Lmj9MXFBJZ3En4Nue
   LiU4hlhvMW3AHIAU5t1QTFsPY67BsQSk9K0iCNs04r2Mw1Pw8/Qg68XwG
   LYSvAbghZdQC9P2xfbss+/ZQTb6PuLPCT4hPH+WYPb/H52AZZKxIxh126
   nwS1E29svSv0GLCbKnV88qTmjGsAwLIOliTOzw0+1TfTXDlCGHX9BTOBU
   woDKq40O4HG9vPJ1UYbO0eew2us/zksMIV8PgHpWXSy5ulJc0mWXhI/BV
   Q==;
X-CSE-ConnectionGUID: GfgC2pvdTDC0N2f0C9zPuw==
X-CSE-MsgGUID: H1Q4FsJDRceDLibr+jRLtQ==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34980411"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 23:00:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:30233]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.48:2525] with esmtp (Farcaster)
 id 1f3f3ea1-ce68-4516-84dc-fc3b677d619c; Wed, 25 Nov 2026 23:00:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1f3f3ea1-ce68-4516-84dc-fc3b677d619c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 23:00:38 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 23:00:37 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <corbet@lwn.net>, <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <leitao@debian.org>, <linux-doc@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <noodles@earth.li>, <peterhuewe@gmx.de>,
	<rdunlap@infradead.org>, <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v4 1/8] tpm: Add a single table for all TPM wait limits
Date: Wed, 25 Nov 2026 23:00:34 +0000
Message-ID: <20261125230034.24726-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118073852.81107-2-surenkj@amazon.com>
References: <20261118073852.81107-2-surenkj@amazon.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Jarkko,

On Wed, Nov 18, 2026 at 07:38:45AM +0000, Surendran Kanagaraj wrote:
> +static const u32 tpm2_defaults[TPM_NR_LIMITS] = {
> +	[TPM_LIMIT_A]		= TPM2_TIMEOUT_A * USEC_PER_MSEC,
> +	[TPM_LIMIT_B]		= TPM2_TIMEOUT_B * USEC_PER_MSEC,
> +	[TPM_LIMIT_C]		= TPM2_TIMEOUT_C * USEC_PER_MSEC,
> +	[TPM_LIMIT_D]		= TPM2_TIMEOUT_D * USEC_PER_MSEC,
> +
> +	[TPM_LIMIT_SHORT]	= 750 * USEC_PER_MSEC,
> +	[TPM_LIMIT_MEDIUM]	= 2000 * USEC_PER_MSEC,
> +	[TPM_LIMIT_LONG]	= 3000 * USEC_PER_MSEC,
> +	[TPM_LIMIT_LONG_LONG]	= TPM2_DURATION_LONG_LONG * USEC_PER_MSEC,
> +	[TPM_LIMIT_DEFAULT]	= TPM2_DURATION_DEFAULT * USEC_PER_MSEC,
> +};

The TPM2_SelfTest duration bump [1] made me realize that mapping the
TPM 2.0 durations into these TPM 1.x style classes may not hold up long
term. A spec update to a single command turns into a change that
affects all commands under the class. I think it is better to keep the
existing maps as they are and let the driver modify the map if needed.
This is also what you suggested in commit 207696b17f38 ("tpm: use a
map for tpm2_calc_ordinal_duration()"): keep a per-chip copy of the
map and let the leaf driver patch it.

At a high level, the series would become:

1) Set default interface timeouts and duration at chip allocation.
2) Keep the chip durations in a union of TPM1.x and TPM2.0 durations.

     union tpm_durations {
             unsigned long tpm1[TPM1_NUM_DURATIONS];
             struct tpm2_ordinal_duration tpm2[TPM2_NUM_DURATIONS];
     };

   struct tpm_chip holds the union tpm_durations in place of
   chip->duration[]
3) update_durations() now gets the union which TPM1.x and TPM2
   drivers can adjust.
4) Show the durations sysfs file for TPM 2.0 chips.

With this, I would drop the limits table, poll APIs and tpm.limits=
parameter for now and keep the series focused on duration handling.

Does this sound reasonable to you?

[1] https://lore.kernel.org/linux-integrity/20261125182251.19360-1-surenkj@amazon.com/

Thanks,
Surendran
