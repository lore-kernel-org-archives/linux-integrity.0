Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB664275B04;
	Wed, 25 Jun 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879203; cv=none; b=sDK0wyZZZS5C/uN24+HFr232hUWoc0apOkcKMtDl92tbUFS4KdWe5dJSGn5owaAct+OVKRpBVyyGY+kqMFOIWyxGMBk/DSUczv6f4tid0/cp6GN3x8Xvu/4Al5N3YIvr7sBu6Jqxyg4qZt/E1jy+Jbz1Drpi6ILyuKoQVRVxeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879203; c=relaxed/simple;
	bh=q61iirmjI3RzzKZK8M+lsr+ig5IRizqQYOb9ZLsVqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWuVzko+ew9UhA7v7xhTHvmpl30kUMxsoRYPpBdbFXs2f4upGJL0F4JJ5C0vQo0aNO3RqosLZ9/xyRl2rwMB/RN/2NFGbuoWs4QavNkYMHMKH18IZMZJSrnLdylF1Uh4BezLgX3IhctOx4yb/Ldwjn9i3YCmMMHFtih+taHIo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F532106F;
	Wed, 25 Jun 2025 12:19:42 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09DF73F58B;
	Wed, 25 Jun 2025 12:20:00 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v7 0/2] tpm_crb_ffa: handle tpm busy return code
Date: Wed, 25 Jun 2025 14:19:41 -0500
Message-ID: <20250625191943.1009830-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms that support FF-A direct message request v2 can implement
Secure Partitions (SPs) that host multiple services. When the TPM
service shares its SP with other services, message requests from the
driver may fail with a BUSY response if another service is currently
active.

To improve robustness in such scenarios, we need to introduce retry
logic in the driver. When a BUSY error is received, the driver will
re-attempt the TPM request until it succeeds or a run-time configurable 
timeout(default: 2000 ms) is reached. This ensures reliable TPM access 
under shared-SP conditions.

Add a module parameter, `busy_timeout_ms`, which specifies the
maximum amount of time (in milliseconds) to retry on BUSY before giving
up.

This change builds on top of commit a85b55ee64a5, which introduced
support for TPM service communication using the FF-A direct message v2
path, in accordance with section 3.3 of the TPM Service Command
Response Buffer Interface specification.
https://developer.arm.com/documentation/den0138/latest/

This was tested with an FF-A based fTPM currently not publicly available. 
There are plans to open source the fTPM.

Changes in v7:
- Updated Documentation/admin-guide/kernel-parameters with busy_timeout_ms.
- Used a less convoluted break condition to exit the retry loop.

Prachotan Bathi (2):
  tpm_crb_ffa: Fix typos in function name
  tpm_crb_ffa: handle tpm busy return code

 .../admin-guide/kernel-parameters.txt         |  8 +++
 drivers/char/tpm/tpm_crb_ffa.c                | 69 +++++++++++++++----
 2 files changed, 62 insertions(+), 15 deletions(-)

-- 
2.43.0

