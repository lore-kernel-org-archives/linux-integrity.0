Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A552FC00D;
	Fri, 16 Oct 2026 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125473; cv=none; b=jqZimb1oGb3QGVaikPAIHdoMp9P2rYLavoVgrgAmZfLgfPmrOJB1B8wgqJtSfDgfa5zpt/dvLyJfVOUjI0+MqPguWiWvrg820o+8SIG/BXLfYiEWmEEmjvjJmDDFmQn7M7nTaT57GdRIm1IApYH0FXGMTY8WE/8E1t5f3N5u0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125473; c=relaxed/simple;
	bh=INJ4wf4IsaRjCYXDG/NLUNJ67XJuPD17eqsCAcvsPrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HKq8/9dVm2Xum38Yfjr9yOLBggD7BSzWTUYm7ViPo7gy5DGKj5ZSNAnhBpRrDGjAFDbcA5YP07aBkZbXS5Ixktoc9ADZWDGlf/pHPKZMsUudVB73bqVUe/2lERObm+37rpOAU4QY2dUNhZonVQysAFGpaoz6axwcUa08dXSf5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a6SW0tdu; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a6SW0tdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792125472; x=1823661472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EbMriqCgdCDNOTylQtGXmimWeNIgMRcJBHuF6V05NNM=;
  b=a6SW0tdu7qEPDiUd1J3DAkV3TjEcgcvpK/KKaqP9SrrBuQvRo9r4i5Kt
   N+p6DQF+BQ94ii9xHbMk+t7PR7lFY8ngYw6TJECTO4d4ajfYe2jF2RPtm
   u8+v+N7UWwaJvD8jBsMPmF/4XXdo/Z0dzvAq1UorjI3ykT86KrJg3v18N
   WY4j1s4Dxirw3Yt1Qf2myPn5FGjheDiItEi/MCrE3DyKal+tZPIt7N2zM
   KCYobSvmOQqgo5KHgl40D8GKyXAoIufOvuqLSYJ3ufmA92SmSKlXje8Mb
   hnY+7MeQ41O6eWGt81uxV8LzIu7ucVdvHsE9V+CgG2xlBFTihLZXh9GYp
   A==;
X-CSE-ConnectionGUID: bxs8z7W5Q4mZkicg8/XaHQ==
X-CSE-MsgGUID: IcNWancFQmq6+aHw+Dfj9Q==
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="30914192"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 04:37:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:10375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id cb4d2b5b-66c4-48bf-a27a-41e8b64f8f6a; Fri, 16 Oct 2026 04:37:49 +0000 (UTC)
X-Farcaster-Flow-ID: cb4d2b5b-66c4-48bf-a27a-41e8b64f8f6a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 16 Oct 2026 04:37:49 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Fri, 16 Oct 2026 04:37:49 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [PATCH v2 0/2] tpm: Handle transient NitroTPM unavailability
Date: Fri, 16 Oct 2026 04:37:31 +0000
Message-ID: <20261016043733.30589-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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

Add support to override command durations and TPM2_RC_RETRY budget
based on chip->duration. tpm2_get_timeouts() fills the array with TPM2
defaults and lets the driver adjust the durations (patch 1) as TPM 1.x
does. Raise the TPM_SHORT, TPM_MEDIUM and TPM_LONG durations to 30s for
NitroTPM (patch 2).

V1 -> V2:
- Drop chip->busy_timeout_ms. TPM2 durations and the TPM2_RC_RETRY
  budget now come from chip->duration.
- Map TPM2_CC_SELF_TEST and TPM2_CC_VERIFY_SIGNATURE to TPM_LONG with
  floors of 3s and 30s since their durations do not fit SHORT, MEDIUM,
  LONG durations.
- Keep the TPM2 defaults for commands sent before tpm2_get_timeouts()
  has run such as the one in tpm2_probe() and keep the 2s retry
  budget for TPM 1.x chips.
- Keep the first TPM2_RC_RETRY wait at TPM2_DURATION_SHORT instead of
  chip->duration[TPM_SHORT]. No TPM2 command maps to TPM_SHORT today
  and a driver that raises TPM_SHORT for its commands should not also
  lengthen the first retry wait.
- Return early from tpm_tis_update_durations() for TPM2 chips, since
  its overrides are for TPM 1.x.
- Raise TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s for NitroTPM.
- Replace the vendor quirk table in tpm_crb with a plain vendor ID
  check.
- Use the TPM_CRB_ prefix for the new tpm_crb macros.
- Rename the patches from "tpm: Add per-chip timeout for transient
  unavailability" and "tpm_crb: Raise timeouts for Amazon NitroTPM".

Tested on an EC2 instance with NitroTPM by inducing unavailability
windows under HMAC session workloads and in QEMU with swtpm on
tpm_crb, tpm_tis, tpm_tis_i2c, tpm_ibmvtpm and tpm_vtpm_proxy.

v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-1-surenkj@amazon.com/

Surendran Kanagaraj (2):
  tpm: Add support for updating TPM2 durations
  tpm_crb: Raise durations for Amazon NitroTPM

 drivers/char/tpm/tpm-interface.c | 11 ++--
 drivers/char/tpm/tpm.h           |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 90 ++++++++++++++++++++++++--------
 drivers/char/tpm/tpm_crb.c       | 44 ++++++++++++++++
 drivers/char/tpm/tpm_tis_core.c  |  4 ++
 5 files changed, 125 insertions(+), 26 deletions(-)


base-commit: 9708d29f225bd326165bfec1962d13f0a00b91ba
-- 
2.47.3

