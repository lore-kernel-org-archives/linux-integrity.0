Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9B48EC6C;
	Wed, 23 Sep 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173728; cv=none; b=sFlh3EafnJlPUZuzeUhi5MtQVd1rE10eK+ioR9GAQrvep8L4xmwuPY1xibNyVODW06FAg88at/PdZmtyR9O+VIULYXe8L6rmM+PCiucTsUuKKvJsmoWj60av2sNv/jfKB1Xjzz2P07ATg7AuskhVJoMSZfxaxg03MdW+ykUQUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173728; c=relaxed/simple;
	bh=eci8dyvvlwBca8yQA89QiLvNcNEuLtl1TVtHyeLoY30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uo87lJjrthyXVuChbGNFRuH8RzN6fr9p3/O7WUE+yum45qNXhLxjra2FI78dLPRviUK3OTqoMx9jJrLxt89R0K6nPSVsTOuoBiHD3rJX0c6HO7LUXIhI4ISZpXfKLZAY08B3DxqlLC1/xfrnyWTg1TN0SRupNsVobaulwflvPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=es5+tkq0; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="es5+tkq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790173727; x=1821709727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4W8U9nBIjABZ5uxHFzuxiVmKfyl0eOs4QLcZj8RuIZg=;
  b=es5+tkq0dAf5raCvrgD/SOXOCcS5yQ08rQKWoHd5Y6NNfNygdfZ52cGE
   YPrligd1rE+WunS2pW5MkIpyoDWB54aRfKliETa9Fe/Zic3xiPFdiCPje
   Lf38hF1yUGxpET/1Z3Y/uiE1AFAT8jk+2TYZHzPc9FLVfD5IU/uSQxPDB
   SmQItvHBImTATLVCapenOdWGoiZsjsUISeLgSPMNhZ+Efq1mpclANr8ZV
   oI+KsfPE4+cdPCR3C1UjJ4SKXqZMAlLzNol4A3Hd4apdgvNtqTInXPLM0
   LN16Q3xl5JnFwcSQ3sdXzDB26d4CM3ustrt/H5vbg9tiSnvLNRK0yA+zv
   A==;
X-CSE-ConnectionGUID: YR1Hay4gSrmnCPkQPGtn8Q==
X-CSE-MsgGUID: 2FX6rAbEQhquPyYok8Mbzw==
X-IronPort-AV: E=Sophos;i="6.27,118,1787011200"; 
   d="scan'208";a="29481539"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 14:28:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:17018]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.186:2525] with esmtp (Farcaster)
 id f3e6d472-e10f-420b-93fb-de4796cce8f4; Wed, 23 Sep 2026 14:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: f3e6d472-e10f-420b-93fb-de4796cce8f4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:43 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 14:28:43 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, Alexander Graf <graf@amazon.de>, "Gunnar
 Kudrjavets" <gunnarku@amazon.com>, Josh Levinson <joshlev@amazon.com>
Subject: [PATCH 0/2] tpm: Handle transient NitroTPM unavailability
Date: Wed, 23 Sep 2026 14:28:32 +0000
Message-ID: <20260923142834.16786-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

TPM commands need to complete within the duration defined in the
TPM2 spec or keep answering TPM2_RC_RETRY for at most TPM2_DURATION_LONG
(2s).

Devices that have different timeout requirements than the TPM2 spec
can either exhaust the retry budget or delay the command completion.
NitroTPM can very rarely enter a mode where it either sends
TPM2_RC_RETRY for more than 2s or completes the command late.

When this happens in tpm2_load_null() during auth session start, the
driver sets TPM_CHIP_FLAG_DISABLE and fails all subsequent TPM requests.

    tpm tpm0: in retry loop
    tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922

Add chip->busy_timeout_ms to support devices that have this
unavailability window (patch 1). It raises the TPM2_RC_RETRY budget and
the per command duration to at least that value. The CRB driver reads
the vendor ID from the interface ID register and sets 30s for
NitroTPM (patch 2)

Tested on an EC2 instance with NitroTPM by inducing unavailability
windows under HMAC session workloads, and in QEMU with swtpm by holding
the TPM in TPM2_RC_RETRY and stalling command completion past 2s.

Surendran Kanagaraj (2):
  tpm: Add per-chip timeout for transient unavailability
  tpm_crb: Raise timeouts for Amazon NitroTPM

 drivers/char/tpm/tpm-interface.c | 11 +++++--
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 17 +++++++---
 drivers/char/tpm/tpm_crb.c       | 54 ++++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  7 +++++
 5 files changed, 82 insertions(+), 9 deletions(-)


base-commit: ab411db3c3b1fd0c70a36fb32c96b2c60175210b
-- 
2.47.3

