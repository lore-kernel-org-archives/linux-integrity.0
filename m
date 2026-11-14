Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684879;
	b=F7fjIBnPB4AQ9hNOb2BR8+cGrCUeCw8VhdHEXZTSt5WnITuvMTq3ZEQ7SXsd9Ahs7N23
	 GowKEl1gHUHy+rlYtdKdOfAI4lrJTso+uUu+k0BK9Jy7+LZx4Wn0IDwawX+VvFB4vxqto
	 B4wFaTg5q/13tXmFupQsJTWOQFMAQ3jTxl77PDd7Vi98m1fF/pcplljCstgcCxDVfmT0o
	 k3WnxPj+57hpLiYxDtgJz0f9Dcbh2QSKxaRQdcnRkr1gXFVcllZFBqIBrvhBfOn/w1uuQ
	 44f56YFAT7eBOifAK4hq6EQqgx4xs72qGqtaeQPnuXKOyFin+JgxPdr+krxzxUKnLfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qn36dnXShc4fUhcrYLZ1Zx2GoiXFD/fDCBgNyF4SH4c=;
	b=apVIyfotyoHZOZwPhd6tzOczXXOgwfR29Vz+eDgZ4UZvZF0FokkYIEAZjJeHSaL+/ItG
	 F+ZlqZ31jHrkuwTF7pOKcdW0u5FIbWQJCR6vfrW6qrtYaAu8JE7xUaYl5cZ/xkfKUn824
	 /aQVfLnvM/bjdSm9ZfrIpbnD8VIQKoDT55m6K5K7PzrMWVDhsElZSmMtkpelYibO61JYR
	 zI+RxkqmalfVb0SE+qkWronQCjs34AvPvVAmKQNFEoWVxNAHn/aTTvkOYdkgmCf4d5x3I
	 gcaEa/s0SBmgNB63tNUr1M0bFng6K6doqvAcV3goro0UWxKg+aK0jUTXmJ8/KJCh4uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRMlHQpd;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87242606A323
	for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 19:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87242606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRMlHQpd
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so3323273a91.3
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 11:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684879; x=1795289679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qn36dnXShc4fUhcrYLZ1Zx2GoiXFD/fDCBgNyF4SH4c=;
        b=rRMlHQpd3xcMxRzce5C2JT6+g3EWg4pQWv9Jm19FsHZVrZCAk91SHCJ5jWyt3RHY5k
         jTNPEv8N26/vNZ6oQU/+Bm1dl7Wa8AhikSd9DZC2FkP7B5FP7VuY/6pSCinX+YbkuimI
         SI1zOH7nfmfr776cMeRjixgQr6C80Q8okIEGQVdNXOS0vpNJfyDp2ep+lqTkjXtnB9EN
         xr3/XjhVwTRmPyrsZH4B1e1P54fMOKgSziC7w0msS4i4P812CxFJAwSn4Pha2bt4/Byl
         /PljtDcYv59+LPtzQjZVBLI7Q4UO7EluQwPXLsuqMB+wUneTrvsnlw2iK0LAU+h5X2g0
         kb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684879; x=1795289679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qn36dnXShc4fUhcrYLZ1Zx2GoiXFD/fDCBgNyF4SH4c=;
        b=DxBwKO3loUjh4PdPrPAcVNQrC7Tsptigdzn5KXFYfmKdnQ9eslpv0T0QQ1eiqWA4QP
         GQH0AlyFow1ylbIk/zOC3HMI+lzgnNv/+Rjkc+LL6fYZtkPs1qnTlRq4yZolGeGMgF80
         gDpLTN9ffvgwSyGcU5mDQ/ZZNQk0STYeW8T5GCyQtRCPFKzuwTZefrKuH/5NPmX+vk+t
         CiSRJz4a4slgaBs6N2F9W3cFWiHMJCiXHl4WfOell2QMMypRojCvXvCPIlNQL4CZ99Fs
         Jwr7KoFClS9OcPT40GOdohb4GcgJ1mt0naHwF3x5PBWzKmJWvCoPOIOaL/sR6u4Emvrr
         bwVw==
X-Forwarded-Encrypted: i=1; AL+hErHf0X/XKdbzENnOmxnjiDHDEJ//adA9szo/3vUOSniB4HWlu95RquKAaty6Z2D/WkM8s8BmtTTJ6NuOryU5MIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hHQW7oqPAtccxjblILXaR40BE5Z/U7payy5eCg2GeHqEJ1XZr
	SPtz0nFtrkLB/ncOlTIvaDfpHrNlSKl/l/mdOM7rO2v0D1WOcIeJgeAI7b2J9w==
X-Gm-Gg: AYBFou21WYiOMIc+DUpk8sb9Nr0SsdGXsTZp7qL39ttw69gyBA5UiT/yp7Ca8oFbArz
	8cr5bYCEBMFX1vOasYCGHx1uHcmM9Vb7WPdYXrEZia1ZZTWtG9rBXnupyAAKXTvNlYim2X6RZRN
	fclprp8/5YwT+4wzPzPYoA4TFNWZgPQr9tNfPXfVRoN0QRYZjSZxkvPkk74b3biI1ZRkEx3V44Y
	jscadh8clkgMhPThhkg+tolKrefqDKa+/AXUb5lceo1m4xFQOEI+8SN9W3LEe7XrGBRC8UQ1vsU
	aMh+rzp+ycF97TZXOrLDc/IC1e59csdWgT5sj2zQU8Cm33MdX/IKzr5I71nMMCCpMxphaCfIEQa
	mUJccXdZHG8u1yu/oIwW6x6HJPS1aZ3/eV8yQKrhbbJuptWtchbvR30DjrukYP0FaN6/IZwBmzj
	9ksTMO39SRWTMRrPyC9tPYRXygAQYMGD4uzO3YsNyoAljiy2ynJ/kdXwc0eiyh83lA6V7VzjEX5
	uZViyI2MvT8vXlk7RwkBHiCwSqOe8V5kQbpv64PN5+L5sdkRYa/tTbVbjRJbF3/75gDX9aaBbAX
	MVmh4SRYV0q1jeZqCQ4bSA/T8uCmf7Zu4cGu8cSrRVCoUj695YzLut4SkgPkwThbDHqR6pKEUqM
	80UMScddRopqXtbLbZw58ky0MHhvsAt4rHIUtIKl1alVkZCaEmJviKTGOAkvdqIQRbEv2Cd6XSZ
	ugw3JZ/tWnTS26YCx6EVuZbu2s8rJGXy8CqfrGqTaGU2MX1LervPdnKYaaXTGXlg==
X-Received: by 2002:a17:90b:548e:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3b1b0b8c31emr6819520a91.24.1794684878851;
        Sat, 14 Nov 2026 11:34:38 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5093969a91.1.2026.11.14.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:34:38 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v2 0/4] tpm: Cache ACPI TPM2 start method and gate tpm_crb_ffa probe
Date: Sat, 14 Nov 2026 19:34:30 +0000
Message-ID: <20261114193434.117714-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series caches the ACPI TPM2 start method in tpm_init() and uses
the cached tpm2_acpi_start_method value across tpm_crb_ffa, tpm_tis,
and tpm_crb.

Patch 1 caches the ACPI TPM2 start method once in tpm_init() into
tpm2_acpi_start_method (defaulting to ACPI_TPM2_NOT_ALLOWED when
absent or invalid).
Patch 2 checks tpm2_acpi_start_method in tpm_crb_ffa_probe() and
returns -ENODEV unless ACPI advertises ACPI_TPM2_CRB_WITH_ARM_FFA,
skipping FF-A probing on non-FF-A platforms while keeping modular
tpm_crb/tpm_crb_ffa loading intact.
Patches 3 and 4 update tpm_tis and tpm_crb to use the cached
tpm2_acpi_start_method value during probe.

Changes in v2:
- Expand into a 4-patch series caching tpm2_acpi_start_method in
  tpm_init() and converting tpm_crb_ffa, tpm_tis, and tpm_crb to use
  it (Jarkko Sakkinen).
- Move the tpm_crb_ffa start_method check from module_init into
  tpm_crb_ffa_probe() so tpm_crb.ko and tpm_crb_ffa.ko still load
  cleanly on non-FF-A systems when built as modules.

v1: https://lore.kernel.org/linux-integrity/20261112233807.70664-1-sidchintamaneni@gmail.com/

Jarkko Sakkinen (1):
  tpm: Cache TPM2 start method

Siddharth Chintamaneni (3):
  tpm: tpm_crb_ffa: Only probe when ACPI TPM2 uses FF-A
  tpm: tpm_tis: Use cached tpm2_acpi_start_method
  tpm: tpm_crb: Use cached tpm2_acpi_start_method

 drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm_crb.c       | 19 ++++++++++++-------
 drivers/char/tpm/tpm_crb_ffa.c   |  5 +++++
 drivers/char/tpm/tpm_tis.c       | 18 +++++++-----------
 5 files changed, 46 insertions(+), 18 deletions(-)


base-commit: 912c3bad2eb993eb3e83c2689cd4e17361ef087f
-- 
2.45.4

