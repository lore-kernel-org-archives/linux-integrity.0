Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988171;
	b=qB9ZpIqGrePk6aX33yuwCcqy00+OeuZM0ew6AkFEu5jIPhB2Uxfn3pfaIOxNuo1rbUXo
	 XF/HBpEshyLlob7Rjjw1LApG48Y2PM4MhzpGQRl/8xghDGxvEVkOu34vXV2sepruYILdb
	 QIu42kT17lZPKQBWSlXTB6+v5eCxcxSC0C0ak6TUgw6zKYjDya9h3NOm990v+j1BgWz3c
	 /bfihoNMZZ4FPnDf+NJ4EVKEHhK1ZHmcrCOHntAs2DBniO29aeKW+AdZT7TQJrWVYF630
	 zKnQIKEd0fNlKmxQ4unM+wXcNCapWAdYFJieDDbLNYOQ4Mt05kez2784TYebOSyqelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988171;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=1lt9+s8UbBEHQqO56fzaJBUqbeY66n0KBH9AAmit2Qs=;
	b=1O7DcIgQqzYC0TGvo0PZtrZsnsY1gBxamlcbKruUHJDOPmM1haB0irMN1j56k1AEYZHu
	 teO19adiTIliAUxlb2lpIYeKCwjAcs9sp9n0kbQjCruCSBZKhsUP8ucLkxAyIVZw1kqux
	 CBR+N6i1Uxf0rteRr8MU+RivOKgjXWVaL6vXWhEYCK1glHZaF7DJ8KWCmiHhcUbgNWBoP
	 7S8gylIbmddakbWJeCEa70WqXQ3GWN/a0U/cbDpnvPjX0EtOO8CJAGQ/cCxUxoQuIg8oO
	 tlcmYyP2UwiUwX5qDH+hro5oeHVBOowPMSceIwh+EIhxvEgnyv2TKMu3XpNGoeCXIgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=At++NS0i;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E7606A31C;
	Wed, 18 Nov 2026 07:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=At++NS0i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794988171; x=1826524171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1lt9+s8UbBEHQqO56fzaJBUqbeY66n0KBH9AAmit2Qs=;
  b=At++NS0i9eHyqMMtyUt0nkL/Zo1Cfv5BchVw/YqeLE0eem1/cuugKgWZ
   H407Lp7kvHhuUpF+UWIxVRVW8ZGuHNMZMjCE05Ww6DgOStxQOeAg05n2y
   iCjoe0Eo+9F7xhgIAsr0CeawfY/VCBHE0RUZEpRUJZ/NYxQJNZO4NIDP+
   6gM65viKaw/Y/i7iB26Co/j1i9fxhEyVV23Ed3jaqjnatULJYI218Eks3
   eRU0OFvXgB/CPY3K7UJ8B9oqUlRjOnpwGHNClPypXzjDRfeRwMq1vSC6e
   RiGGfUkxw/6jlQka7RO9ZnUtzEbUD+nuZ6uEApMGsZw3qcSeZ9Iq1nVv2
   w==;
X-CSE-ConnectionGUID: WbqHsPG0QXSCR0D5ab/wjQ==
X-CSE-MsgGUID: cUOYV0tXQjy69xMo2aoOGA==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="33957463"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:49:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29902]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id bc8ec1a4-c413-40e3-88b3-332085f380ca; Wed, 18 Nov 2026 07:49:28 +0000 (UTC)
X-Farcaster-Flow-ID: bc8ec1a4-c413-40e3-88b3-332085f380ca
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:28 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:49:27 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v4 7/8] tpm: Show timeouts and durations for TPM 2.0 chips
Date: Wed, 18 Nov 2026 07:49:03 +0000
Message-ID: <20261118074904.60624-3-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118073852.81107-1-surenkj@amazon.com>
References: <20261118073852.81107-1-surenkj@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The timeouts and durations files exist only for TPM 1.x chips, so a
TPM 2.0 chip exposes none of its wait limits, even when tpm.limits= or
a driver's ->adjust_limits() hook changes them.

Both files read the limits table, so add them to the TPM 2.0 attributes
too. A TPM 2.0 chip reports none of these values, so for it "[adjusted]"
means that tpm.limits= or a driver's ->adjust_limits() hook set one of
the shown values, or that validation changed one. TPM 2.0 chips get no
device/ links, so the files are /sys/class/tpm/tpmX/timeouts and
durations. Document both paths in sysfs-class-tpm.

Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
---
 Documentation/ABI/stable/sysfs-class-tpm | 26 ++++++++++++++++++++++++
 drivers/char/tpm/tpm-sysfs.c             |  2 ++
 drivers/char/tpm/tpm2-cmd.c              | 17 ++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index 73b69f63b298..ada59d147d14 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -184,6 +184,32 @@ Description:	The "timeouts" property shows the 4 vendor-specific values
 		"[adjusted]" if any value differs from what the chip
 		reported, and "[original]" otherwise.
 
+What:		/sys/class/tpm/tpmX/durations
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	linux-integrity@vger.kernel.org
+Description:	The "durations" property, in the same format as
+		/sys/class/tpm/tpmX/device/durations. On a TPM 1.x chip,
+		device/durations is a compatibility link to this file. A
+		TPM 2.0 chip has only this path. TPM 2.0 has no command
+		that returns these values, so for a TPM 2.0 chip
+		"[adjusted]" is displayed when the tpm.limits= parameter
+		or the driver set one of the values, or the bounds check
+		changed one.
+
+What:		/sys/class/tpm/tpmX/timeouts
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	linux-integrity@vger.kernel.org
+Description:	The "timeouts" property, in the same format as
+		/sys/class/tpm/tpmX/device/timeouts. On a TPM 1.x chip,
+		device/timeouts is a compatibility link to this file. A
+		TPM 2.0 chip has only this path. TPM 2.0 has no command
+		that returns these values, so for a TPM 2.0 chip
+		"[adjusted]" is displayed when the tpm.limits= parameter
+		or the driver set one of the values, or the bounds check
+		changed one.
+
 What:		/sys/class/tpm/tpmX/tpm_version_major
 Date:		October 2019
 KernelVersion:	5.5
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index b289a7f6f085..6bfc366fa120 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -340,6 +340,8 @@ static struct attribute *tpm1_dev_attrs[] = {
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_durations.attr,
+	&dev_attr_timeouts.attr,
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 629caaeffa17..8cc1a262d668 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -41,9 +41,26 @@ int tpm2_find_hash_alg(unsigned int crypto_id)
 }
 EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
 
+static bool tpm2_limits_adjusted(struct tpm_chip *chip, unsigned long mask)
+{
+	const struct tpm_limit_entry *e = chip->limits.entry;
+	int limit;
+
+	for_each_set_bit(limit, &mask, TPM_NR_LIMITS) {
+		if (e[limit].src != TPM_LSRC_DEFAULT ||
+		    e[limit].flags & TPM_LF_CLAMPED)
+			return true;
+	}
+
+	return false;
+}
+
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
 	tpm_limits_update(chip, NULL);
+	chip->timeout_adjusted = tpm2_limits_adjusted(chip, TPM_LIMIT_INTF_MASK);
+	chip->duration_adjusted =
+		tpm2_limits_adjusted(chip, TPM1_LIMIT_DURATION_MASK);
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
-- 
2.47.3

