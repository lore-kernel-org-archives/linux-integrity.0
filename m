Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630978;
	b=3JaAZjhUzkbJu2Z4RgFShjlT5hlKcYsRjfmcrt1aBvoZshRwIqCx+8NuCZcRVGLjPwxG
	 Cw0gJw5V7KD35yxoGNxToxPlpO0CGnEuPaDEbM64p01ZV3cSmk7we6DXeDiknV1ckMSm4
	 3FqQJH88FpsptuAWqAadGMJjH79lzVZW9pkRKBRPHSMErqIoFfn64+p5FCQbvXytnc9uB
	 5ul717NRYZrZJiFHDgj490SjHLztJbjnUarU+R6q+8JAO4ny7yI3wGK8+BCpcIfBiBt/B
	 xtSd5U26vRVTF9fiInbJpM9AXgQglfKGv3ocVE/R849KPQA/mCkeng750C4V9b/7duw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630978;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ZuEnzRlc456Mg7HAuiI3D4MtKg2Iy5JpiFQXs+lfEVE=;
	b=g4MMufo0B2LU39dJ28ys5LY3AxcFSuoKR17BKnFbvZCCioYSC1AEavqJG/h8dP/JOB2D
	 xT62Ev8AJZdFKaMNAbY7kEmZ0Wb1NeelgbfntrCg9UPwSdxnPa7D9r4rz60GeLu1+lSKP
	 tyNZh/m8XQWGsIoK+e7+DlnVg+NayTXooiw5fQmfvnIiod3hYr9yG0FwjshMbBSwkBoKx
	 09GxL6n23r0G8Xm3FTnpkhkI19GALN5qzAl91eanD3PhBdruurao3dmGjrqBeVryKZpDs
	 nYNQOH+RtOmSxbnmfiLC98I/lcb6h5XdE584volf7JExhnhShT3jWOxayRpOLXIISjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="Gk9aNRg/";
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F97606A323;
	Wed, 25 Nov 2026 18:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F97606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Gk9aNRg/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795630978; x=1827166978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZuEnzRlc456Mg7HAuiI3D4MtKg2Iy5JpiFQXs+lfEVE=;
  b=Gk9aNRg/jXs0VmWVxzFJNxt/nGigKHMrIyvQV1du2HkgLMVkTfK4LWuD
   40rXHwCK9VvcxTL/6pBFUDg3Xk0NMsufqT9R67xWMTosn8ciWLt94lezA
   SSwnN6NdF1ILiFZbIUAnQ2VpwLMkB1kM9Az37AA3+8rLW5DcyTx7O4yTa
   g/JiAJOWEargUTlCRgDs7d4mpnZQoXCrfIxmaMT9mA2odtnJNQ7QT4cth
   +6LMUchAVIQqoqAxUdtiXv6pYq+hdZJWeb2gyLe91wTDocMu6QfwMptsO
   cJ/hk4JlI+9NN7URzjdBR2LHGWhfiy4IjFr32LY7jnbcabFNcvNBIhacY
   A==;
X-CSE-ConnectionGUID: zNYup3sFQaidJMi2Gdu0Ew==
X-CSE-MsgGUID: 9Fb0GLfpTOuzFWUl2YP/yg==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34960368"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:22:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:10774]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.177:2525] with esmtp (Farcaster)
 id 53b94ead-0897-4c1a-9887-f1f9db642e8d; Wed, 25 Nov 2026 18:22:55 +0000 (UTC)
X-Farcaster-Flow-ID: 53b94ead-0897-4c1a-9887-f1f9db642e8d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 18:22:55 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 18:22:54 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] tpm: Raise the TPM2_SelfTest duration to 4000 ms
Date: Wed, 25 Nov 2026 18:22:51 +0000
Message-ID: <20261125182251.19360-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

TPM2_SelfTest duration is currently 3000 ms, following PTP version 1.06.
Version 1.07 [1] has since raised the full self-test timeout from
3000 ms to 4000 ms (Table 26, Command Timing). Raise the TPM2_SelfTest
duration to 4000 ms to match PTP version 1.07.

[1] https://medias.cdn.trustedcomputinggroup.org/production/PC_Client_Specific_Platform_TPM_Profile_for_TPM_2p0_v1p07_Pub_5643562943.pdf

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
Found while working on the RFC series "tpm: Rework timeout and
duration handling":
https://lore.kernel.org/linux-integrity/20261118073852.81107-1-surenkj@amazon.com/

 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 65928ae85b49..d58c306f7d93 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -59,7 +59,7 @@ static const struct {
 	unsigned long duration;
 } tpm2_ordinal_duration_map[] = {
 	{TPM2_CC_STARTUP, 750},
-	{TPM2_CC_SELF_TEST, 3000},
+	{TPM2_CC_SELF_TEST, 4000},
 	{TPM2_CC_GET_RANDOM, 2000},
 	{TPM2_CC_SEQUENCE_UPDATE, 750},
 	{TPM2_CC_SEQUENCE_COMPLETE, 750},

base-commit: 003906ddd61cac2b89aefaf001fc19a6cb5d541a
-- 
2.47.3

