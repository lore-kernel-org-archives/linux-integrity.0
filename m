Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883524BBEB;
	Mon, 28 Sep 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629802; cv=none; b=iRqA+40R3Ml0yar0g0JmKAoZAlRk0bwKzt5rewEw/rgRCtxydtFrTVCRyQe/u1BJ/w9NYN4mH0LS8YuBMPnwZ5FsJqM8tNxqMjOFHUrvb5mXR5RKejeqtupHZsOdZqQTIXlrV2chIkqNG/WWXK3SL5JWvq+pTrbM1TkX/Ybubfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629802; c=relaxed/simple;
	bh=fv4AndyObxeCV94OuxSd3evVY0mfDp6Ey1X+q/ykv4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0ZG5dzZTC3HMlDajGZwcdX3oj6RYszgBsB9XEdXeHmeqtqLHzH6c6b/I0jDT93Z294MlES7rZ9y7mwqDSFKRog5jBcedCViqLspxBO/sWwPUbsmAm+ZIFqbQBE+firhKYod39iqVAiHZsQguVQTF7RT9c/s31/njnJhWtfZYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sA/TVTKJ; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sA/TVTKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790629800; x=1822165800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8DotsXPN374HFQ8qa8EzNzUFmop24e6Vw7r0e/NuIs=;
  b=sA/TVTKJiH3oQw2D2B9I1BkVv4HvIsPWiiixBpGZ3RXKvj8piqjTU0cg
   K+w846dl2MtlHIUsOQpNa8QZjqdZ1epG0XmUPV3ZWS7yHlJ007yAVz/DO
   L372/b6OjnCkspNWr2K6frt/iYn+DK5MUa0Nr94arr5FeUWM6rYfZ8tcO
   Fp5aWKmGWiHA+40DE2p0qRqUAHL8aceTpWPSG5D2i7jFed6xK3Q4LEFoA
   L/Q+rW5AjUX5ByHYE/ivf5wobdxnO+SYJeWQf2rCTHMlr3iJmaWSgToLS
   c0XwyO8sUbA1D1Qa6NgwaXsx431hwMNB70qm2e7VyQ37MHR4gdFpANcZq
   w==;
X-CSE-ConnectionGUID: YiK4e9/uRWekaHHLoyVJ4Q==
X-CSE-MsgGUID: PaU3CVDDTUqL8U6RB+6wLg==
X-IronPort-AV: E=Sophos;i="6.27,129,1787011200"; 
   d="scan'208";a="29638367"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 21:09:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:12359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.34:2525] with esmtp (Farcaster)
 id ca07bd3d-573d-4268-a86f-f322f91166ed; Mon, 28 Sep 2026 21:09:57 +0000 (UTC)
X-Farcaster-Flow-ID: ca07bd3d-573d-4268-a86f-f322f91166ed
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:09:57 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:09:56 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<peterhuewe@gmx.de>, <surenkj@amazon.com>
Subject: Re: [PATCH 2/2] tpm_crb: Raise timeouts for Amazon NitroTPM
Date: Mon, 28 Sep 2026 21:09:53 +0000
Message-ID: <20260928210953.29183-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <araZZzKDqzrPdY9f@kernel.org>
References: <araZZzKDqzrPdY9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, Sep 25, 2026, Jarkko Sakkinen wrote:
> On Wed, Sep 23, 2026 at 02:28:34PM +0000, Surendran Kanagaraj wrote:
> > +/* Longest unavailability seen from NitroTPM */
> > +#define CRB_AMZN_BUSY_TIMEOUT_MS     30000
>
> Use TPM_CRB prefix.

Thanks for taking time to review my patches. Will update this in v2.

> > +	crb_apply_vendor_quirks(priv, chip);
>
> I.e., all this complexity equals to:
>
>         if (crb_vendor_id(priv) == CRB_INTF_VID_AMZN)
>                 chip->busy_timeout_ms = CRB_AMZN_BUSY_TIMEOUT_MS;
>
> ?

Yes. I added the table to keep vendor specific quirks out of the probe
and could be extended without touching the probe. tpm_tis_core does
something similar with vendor_dur_overrides. what do you think? I am
happy to switch to the plain check if you prefer.

Thanks,
Surendran
