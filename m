Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4564EA380;
	Mon, 28 Sep 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625029; cv=none; b=i0V4jflo64qM1JWy1VIifM4DZqDwKkLAId1AeS+EMN+30RKxv2VCXzQGuxHaR1JR7GZ1w0ACIfrMNvbvpElNML4N1+Rvx3HRuG0NSboAQtqxXtHcdiLkwiBct0SJPu4PSRYoFW/qsQgiwHpSeXi9JueIzTc/r2mKEJs95efRpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625029; c=relaxed/simple;
	bh=86jdIDFQ+QyxVEU7WIh3FMSM54moiqjGYjLDbK+Tv5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZRw8sZL7PDco3L5U4+kIaIrRnzHdBpG/Nc9ImbcQ5A1xKTPY9w6yoMMAXvPC6AnelOIltHdo/RSdPbr4aDGMxvhqjv8V9s0q1aGa9QjON0Al6Y++nq3TsCY6L7upmIe3Xgdix9DOICLaOhvgRfqKpfqYBMbMOVlcnWC+meisoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=abxA2TW3; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="abxA2TW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790625028; x=1822161028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/js+Y6C3+7tK7JctJiS8btK+ChOEVnlMcOm7V3Zg9pY=;
  b=abxA2TW3DFeGCF/INjP5K6l5QpBuaPF7JbFt4W7xBv4AKMI0iyN3/nTW
   mQ+tQnB7UOr0GzVFKdBBn0VBeqPAxjI/tvTZ9phwZsqckSdu+GvV3pVmW
   ai9g4JH2SOHmJ/ugE5dIbiWiJLiSD6fN9cUwJMgKRnP3N3va5l3s8UOE5
   Tkmu1XmSp+79nqjoaC7Kmb42qx6tQu4hAXd8YqaKCbAjftQqeJNEFDgrs
   vIdOWHYHj+R9SFYW9OPQbemlb1m35x8lLt5rGq+5k6UEvvZPA6cwJApvd
   8/RU3s7EdTC5CUUcvdlijPaEuzyob+K4rN/fzES/RJNvOw8jV2aojXaDM
   Q==;
X-CSE-ConnectionGUID: 0VFHu4QXQCeR4Q9qQDL1nA==
X-CSE-MsgGUID: c+lwzzK+SHiFGlEdH6OcGw==
X-IronPort-AV: E=Sophos;i="6.27,129,1787011200"; 
   d="scan'208";a="29771012"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 19:50:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:16450]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.1:2525] with esmtp (Farcaster)
 id ff035a3e-cf72-476f-91f2-cb8d7186db91; Mon, 28 Sep 2026 19:50:25 +0000 (UTC)
X-Farcaster-Flow-ID: ff035a3e-cf72-476f-91f2-cb8d7186db91
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 19:50:24 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 19:50:24 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <leitao@debian.org>
CC: <graf@amazon.de>, <gunnarku@amazon.com>, <jarkko@kernel.org>,
	<jgg@ziepe.ca>, <joshlev@amazon.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<peterhuewe@gmx.de>, <surenkj@amazon.com>
Subject: Re: [PATCH 1/2] tpm: Add per-chip timeout for transient unavailability
Date: Mon, 28 Sep 2026 19:50:20 +0000
Message-ID: <20260928195020.27969-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arY2qHhjv97W7WvK@gmail.com>
References: <arY2qHhjv97W7WvK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, Sep 25, 2026, Breno Leitao wrote:
> On Wed, Sep 23, 2026 at 02:28:33PM +0000, Surendran Kanagaraj wrote:
> > Devices that have different timeout requirements than the TPM2 spec
>
> Can you help us understand why this device doesn't follow the spec,
> and why the quirk belongs in the kernel rather than being fixed in
> the TPM2 itself?
>
> Is NitroTPM a virtual TPM? If so, could the virtualization software
> be fixed instead to follow the spec?

Thanks for taking time to review my patches. Yes, its a vTPM. We are
also working on shortening the window on our side but its really hard
to keep it under the budget for all the cases. I also came across
a similar implementation in tpm_crb_ffa which retries a busy TPM based
on module param busy_timeout_ms. Should we adapt this param to crb in
general?

> > +	if (chip->busy_timeout_ms > max_delay_msec)
> > +		max_delay_msec = chip->busy_timeout_ms;
>
> nit: this could use max() instead:
>         max_delay_msec = max(chip->busy_timeout_ms, max_delay_msec).

Agreed, will change.

> Also, should there be an upper bound?

The value only comes from a constant in the driver So I didnt add one. I
can add a upper bound.

> What about something like this instead?
>
>       return msecs_to_jiffies(max_t(unsigned long, duration,
>                                     chip->busy_timeout_ms));

Yes that reads better.

Thanks,
Surendran
