Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDE269CE6
	for <linux-integrity@vger.kernel.org>; Tue, 21 Jul 2026 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612725; cv=none; b=WLJeiI6cssP3MCZUMGd+IG6GbsyxGGoXyueV/3NZrzWMdP2IR+RPQeya2qYi1nVY8yvKhXEi/Nc9zVimTfn3MvKZQA/nkQICIiiINzr+QASCXBncT/mTh/ZeQ+QKcI9Ks8Ju/76b3OA5JYZ4FpC9PKcF6YvBvVZ6HlG5BvwvOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612725; c=relaxed/simple;
	bh=5BhgpjbYv7n6lehcfJMF8RfisXcwZAfesEnS0AHA5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BulaBwUJS6wjgzl1RRhD0SNZUPOAnd2mUEKXnxeM5ubycAgd757bkZKBRNgopWEdGuyBgRuXZePRIwJrXQ+uJ/af63bdTrp2DsGwVGI1/Z03rBHqjHpUmeG90Ct0XkosTVhOahoMDhGCtzm4YZL9xeHwfrOzcVqogrbAEHGczRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niyH+W0o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niyH+W0o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84864086bfeso11586588b3a.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784612724; x=1785217524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DUyTzWLCTMDNRWqM9Nwj51oZX76siHgXFAZY7PVYJ6I=;
        b=niyH+W0oCs7obIekqZcREwbib3WeiSvwm9cdmy+o16MBvpn6i7gu+oCxZU7vYi6WZb
         dHhzU31UysT4c6zDiFGBa/7as/1c3sE/oTKayW3DMoBDDOa3pcMowTbuHEFTPagU8Ij9
         yuTZHQKi4krAV1V9eFk9xP/hohACObK+FFZIjmn10SgXKjvjyAMNAbQ38BlLV7BMnP3e
         VgoC2dSKME/17DebW2KKAqUz/KYSNnUPY/8kLGaelyIerLZ6j7YyBgzqlaRXoKsRMJQe
         9JhsieoxbtWpgZkmUZT7jQzGUxhHE2vo49yeHqE37Ex/BwvOP4RaU8yeu9eWWsgRZRd3
         WL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784612724; x=1785217524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUyTzWLCTMDNRWqM9Nwj51oZX76siHgXFAZY7PVYJ6I=;
        b=a9fOCqpGfyURtEViV6EmPyQv4U0VTSgKyEWoxSy/WBXeWOgTsCLq+Ts9rP1/dVxmAb
         soJD/5JTInIh/2o3MKZ2gZTl1uuOQ9g96PSGIPONCT1r1cAkVOk66saYW4lX7C0QTBs8
         +x3xd1uXcMQMhhhEOuW9/U787jFI0Idv9oZmKqzZLEyxCYs+2BhNP6CvD2/M0a7IOLnV
         jZOI7EKEXFRmIhxdngt2nf8j5qmNO4e4sNlCvaCWGuIW5V+lhQCQA1e9z17+J2264jah
         WjlYicAb8+lJWul0sBl3lRdghb8FQwuzyACcC9aGFJbsDHvCVWzP/Ag1AuzEW06DuSid
         U3Mg==
X-Forwarded-Encrypted: i=1; AHgh+RrdS0spZNaQ0IHN1YopoVG+GOgpiNce1qr08z80oooBpa1nGxyL6NlIQRUok/sRM5+gn+ttvWohECTM2tVmolE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVwEsyFDJULjNjJa0/rYd+1Mqusk/uZOK4VqyFdnscA7Vbhvm
	CMLSHOKRAg4TBbLp6Vfyh3HzferrAdy4N8GXYY3E9NRgV72vyY4en04=
X-Gm-Gg: AfdE7clvr1IZaHcn1+4hFLf7T31c8U0N72Y0X+loMoh/qO10pGQGgSc8EjCzIiBfYrA
	8jX8wAiSiNDiRslWjXY9QVLpK4mqbTR599FeqwkuKXNcfGub9cTUZg2TFZNN1e383EjMe2JcgXN
	+YCYwYMRM5ebGeHMQ06eVJN3YKGZObWrSSTJVwLZlqJSCJ57SSPzWs5bK2A7CUiS113uTFQcQK1
	U6DMDYfyO4V/y3D8UNbl8+amhAvGRa1+IB52/PpXo8P3PBXqRX+ZCNd+BYgUlo7LFgM3gmD+1cb
	eaXgC2nqhBPFjzTGFBM5HxZUhP1ggdr4zQSwdYxgmd4G/qebHBJyg/WwtP60DGDchula4aiFCjr
	99q7jpwt9dFOzeDECD23USY9+Zl6S4CXsPwMKRAmp6EsSEP3Qw5y5Eq1cqWlnuEQXgAQw+q2Us0
	jM7MzgH4uNheyv4ty954712ttQA3RmLPedRQHggA==
X-Received: by 2002:a05:6a21:3b89:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3c3ad64b57emr18830801637.22.1784612723689;
        Mon, 20 Jul 2026 22:45:23 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb770sm46620876eec.16.2026.07.20.22.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 22:45:21 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] Add Apple T2 NHI device links
Date: Tue, 21 Jul 2026 01:45:00 -0400
Message-ID: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a cached flag to detect Apple T2 systems, then uses it
to create device links for the Thunderbolt NHI.

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
 drivers/thunderbolt/tb.c                      |  51 ++++++++-
 include/linux/platform_data/x86/apple.h       |   5 +
 security/integrity/platform_certs/load_uefi.c |  38 ++-----
 4 files changed, 168 insertions(+), 31 deletions(-)

-- 
2.43.0

