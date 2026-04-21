Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49D1C84BB;
	Tue, 21 Apr 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733141; cv=none; b=sKbhOCTOALurY+RiqN9UbI4ZuF99ljVGpzcewJKC88yl7PuRvkfaLA7aybymsgZ1BQWSWI8gMAEpeXEMEsSfoUUWd6tN5C8FrKsaCuyxOF4CMcqfcH6IaJPY6xBhIxLoo/rvV+7+znri0thdfj+eX+S29j0l6cD9b11qpxdQZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733141; c=relaxed/simple;
	bh=CbMbXUZSh7Wbh64kOD2rAH3fItsdaCEy8sLYTFVUI8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rr9Jf7gvFmp+AtRMm5OrirjTnph4ms4H5KljHM47yJcC3dZes23V6O1dkMM68tMsh2PEsj1aHRbIWM/QrupBmwkbczoNYcE3FEkna/6jmEEXEsXtLAxYDcP0RbxeMGyQiub6PrtDWq8h+q94iBFuhhvzNr4g4NPTB1J9KGxwPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvodOw7T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvodOw7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776733140; x=1808269140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CbMbXUZSh7Wbh64kOD2rAH3fItsdaCEy8sLYTFVUI8s=;
  b=KvodOw7TNb8vKaJ4mcCMvneyIn5c4NoXo0VSb8wAV7R5cu3JimwMGjE5
   uAZIqNQBMC8I/YZkxTeHCwIZ1O68MjaIqqI819d09SdZ+X2dgXfJpYIjf
   92cwxFT/oRvXW26mXFaC7EtVSIbz/qkSouGDAJzKKBuLCcOOFbO3j08dM
   KgIVUF9wu6B16CQohbqIgfw+O6V2TY6fTlUgSwu5YAL95QWQhfZ+GxtXQ
   hhNiwqWkLOMOiwCoXV3/rAFD8E3mhGsH/vCqNejUjkjPoh4tXVOiCw1cz
   Ar8eVgyvFgrlXXrjB1UwMKJIQ/aRuEtBwCO3ymUvakjL6OUTHnfv/OMMi
   g==;
X-CSE-ConnectionGUID: aOEVnVVcR5W5RvJHbG9W8A==
X-CSE-MsgGUID: yl/clTnwR1CNZ0abR3srSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80249664"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="80249664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:58:59 -0700
X-CSE-ConnectionGUID: PuSTAuUoQw6a+PeP2YGNzg==
X-CSE-MsgGUID: JTY83li/Q0y0pQuLGJoWjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235887487"
Received: from emr-371.sh.intel.com ([10.67.116.174])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:58:57 -0700
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>
Cc: "Baoli Zhang" <baoli.zhang@linux.intel.com>,
	Lili Li <lili.li@intel.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: restore timeout for key creation commands
Date: Tue, 21 Apr 2026 08:50:20 +0800
Message-ID: <20260421005021.13765-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Baoli Zhang" <baoli.zhang@linux.intel.com>

Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
inadvertently reduced the timeout for TPM2 key creation commands
(`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
seconds.

This causes intermittent timeout failures, with several failures observed
across hundreds of test runs on some Intel platforms using Infineon
SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
avoid spurious failures.

Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
Co-developed-by: Lili Li <lili.li@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
Changes in v2:
- Add description of intermittent nature of the timeout issue.
- Fix Co-developed-by and Signed-off-by tag ordering.

v1: https://patchwork.kernel.org/project/linux-integrity/patch/20260410014940.3557934-1-baoli.zhang@linux.intel.com/

 drivers/char/tpm/tpm2-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4aa..430022f695f24 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -71,9 +71,9 @@ static const struct {
 	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
 	{TPM2_CC_GET_CAPABILITY, 750},
 	{TPM2_CC_NV_READ, 2000},
-	{TPM2_CC_CREATE_PRIMARY, 30000},
-	{TPM2_CC_CREATE, 30000},
-	{TPM2_CC_CREATE_LOADED, 30000},
+	{TPM2_CC_CREATE_PRIMARY, 300000},
+	{TPM2_CC_CREATE, 300000},
+	{TPM2_CC_CREATE_LOADED, 300000},
 };
 
 /**
-- 
2.43.0

