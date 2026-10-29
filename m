Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264329;
	b=ZwcukKNrBEuJ7dFpfipgOLa+Dw69wTvwl9tJtcG3doci6W+SrHt2XeWY7K8ChqNa+IS2
	 ZxPbdty7TVvtWm/nUUf9bxCib8EWOespHRYxv/jEgP9J3Cq/mVKL0y4lbg5B6ZTRbvD76
	 aGBlssaLhW67AJlBrBbgXEIOV9wLMlPmrTt99JSlIhXtbZNxW8tXtzWjOVHf+qA7aDZpk
	 vSb+k8hVrSng47GwOtu2TZt/aYWaz/uYd+n4bdHK2aZC11kNkGIpOmODhPvFQr0uIn3hF
	 T9Ly+lXONPIVos5aoEkoz3LaHytIhkGLZK+W+WR45vQHxZEgMeS9VGAQDoy0UDVrxyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
	b=pveA3rXgC1e5LLOxaU1cdvx/+r3I6b45KOMzZtiKR3jFMP+3prUFibveaC2v6NIWwP83
	 a8laezBeo9JwukZNwKQBqZhJd1fdO4DxM74GbyRwq0YMvD7IdoRFUdBtmQWaLSOVbaTO6
	 dTXqds5/CxbUhxFLcsKn3AgUmYV8+6pPluxKlVD1JfjdU/6ZR2sNVOdJpm4FE2/nOsZAb
	 7MtC6cQKHSrn/FVbo+02o3s73sFUMrEsj+SEz0L7wWFYkXCTdidBSbO5yCohhxgWGeNSi
	 pPHOj+mgqfXKfEpb6NMx0uHgkuW50pZ/XZIsjQ9TN0htIBlXKaziTragYNw+XJh9TWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M/LEHeJC";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45904606A329
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 08:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45904606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/LEHeJC
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so813247eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264327; x=1793869127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
        b=M/LEHeJCdSEFtQyLjoBSDXWtw18IcjVwvBNuis3vlkJcH6Cd+zyA5KLf/jRrUBxUKE
         Ji5UHAaA8Jfep+eLkBH3fpJ0DrQw9JanSZ+mhw1TrgPZYCcY60NUjnI9KQg40L4eI2Sn
         TlcEl0BfOUW9HAnyzfguKduUwN3FD/8412FJgjpz821bK6YdraNpfH+0aidphFW+r6Fp
         fbHiMaA/YPpMGQaUpcMMEZPKK/PjwGb0HzhdnZw/3ZeTpcGu5RkXXS1bWFjN8/QV/qAc
         eoRSQlhQMjXnLRijz6hFMAxt+aQBFw7RjgkK+5KsNgIXZEy2xC7RjulVs7ew1XO5CrV2
         USTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264327; x=1793869127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
        b=EK/fprZ1cK24mtAEDpOaHbh1RUldq32Dkkmim3cru+UCQze6/X0i2E7uD1OtoOYmIm
         9d2VJtf7GHdHe8tPN3DCD1axa8psK2VPgwkB/nkXKHqG/GvQLvqOsdXksno2mUP7/BqM
         DyRDAa0d6QvYAbzQsKoiCG9A9AkbbG0iBEU4h69fEr+LFbUnMqMbCc6IPMZ72Bz0gv5v
         Kjx4jAx1gFdHZpGesemR4Ssfgg5xui8X+OS46zNlhCjppJgtrHZVGjyI9r6Cid8aQshP
         KvyRIx/MGr9Hab0psvja0DTzD9z0fzfZ+2lUJ7hFUgfdF8hI1fIEFD0AontyGyL4DFrk
         sfPA==
X-Forwarded-Encrypted: i=1; AKwUvBzKOYJyIobA7/hAm678mMXX/6gTi9c1/SldnvXPi7ygnXQ5TFRwW4NpDcyShhn4t402uwvAwxtv+8S4OBRpTVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiqgyTXdhp8sfkDcTC5SvNHBaF7x6Pb9ZAlU7C6qsJlb2ondB0
	HtQKWRBWJ7E759n2paaUXVI1ogVHsMu2z7u/DrqNc7HwC+63tJQB3H4=
X-Gm-Gg: AYBFou2LqsQYdbuamm943SsQz6XOkVD/bGgtp3OeuG5+T2c6BSsqnFhGUw4ASx39zNk
	7nulLVp8jTnNyzmEhrBsn6kP2sOhucqJifxNOTRobr/kWOsfK/qJ31qzMefqIgtp0DV3MERxwDs
	hUtwslRi7YIcKDUUTnq8fIKkODZpPG3PCr61iocXlTv5A6GrrC54EhO9UMw0T2An/0ZFA9GJj0C
	5ADmwDUCCHvlKI/ITE9mxQ/QEsJWdSNW3xKdCjwOXIwDYQAVg69Apj3GPYy/mipZP13PrdeHl0L
	kJ5T+ywB5xeQ0d53QSHKKIPYlqjkz3pAlXnsbCY5gYVc9VM1Cq4vKK2UJe9PvDNcOqj5ZDWECkU
	cJQGktMWEDHCnYXHu3IcNDy32PCEPo0H1Ql7BcMzz5DAekp9jpH1ZoLMI2jpGbTbbFZ5b8lzlE/
	qCHwBNDVzUYamRUkJLZV6xTgg+rRL75sHNipDjIF8E97C1hMvuH4h81t8F5i1pWXSgRQuHoQF41
	ivG5825/gTnPOn2B7iAir+lWy8VQ7qjslb609zENxxTJL2l4Ysx1cI4raKBWhmmezsA/dbIDaMh
	yz3Ss+tEp8v2GJnH/tT7rR6Ak3l6bfYk6MAJp4R/9wgw1PXDQPMEvo8cQZD6AiKpAl7ZuqLB5up
	PA9VogAd3
X-Received: by 2002:a05:693c:2411:b0:359:9302:a526 with SMTP id 5a478bee46e88-36a203ad100mr6959524eec.7.1793264327087;
        Thu, 29 Oct 2026 01:58:47 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:58:46 -0700 (PDT)
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 06/14] leds: add support for macsmc kbl
Date: Thu, 29 Oct 2026 04:52:03 -0400
Message-ID: <20261029085504.3547-7-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
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

Add a LED class driver to control the keyboard backlight.

This replaces the keyboard backlight support in applesmc.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/leds/Kconfig       | 11 ++++++
 drivers/leds/Makefile      |  1 +
 drivers/leds/leds-macsmc.c | 69 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/macsmc-core.c  | 11 ++++++
 4 files changed, 92 insertions(+)
 create mode 100644 drivers/leds/leds-macsmc.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7ec2c8d78..30cd64d41 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -729,6 +729,17 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MACSMC
+	tristate "Keyboard Backlight support for Intel-Macs"
+	depends on LEDS_CLASS
+	depends on MACSMC_ACPI
+	help
+	  This option enables support for the Keyboard backlight in
+	  Intel-Macs using macsmc.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-macsmc.
+
 config LEDS_MAX5970
 	tristate "LED Support for Maxim 5970"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4d4b08915..7c38dbef4 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_LEDS_KUNIT_TEST)		+= led-test.o
 obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
 obj-$(CONFIG_LEDS_ACER_A500)		+= leds-acer-a500.o
 obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
+obj-$(CONFIG_LEDS_MACSMC)		+= leds-macsmc.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
diff --git a/drivers/leds/leds-macsmc.c b/drivers/leds/leds-macsmc.c
new file mode 100644
index 000000000..f38ef2113
--- /dev/null
+++ b/drivers/leds/leds-macsmc.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple SMC Keyboard backlight driver
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *
+ * Based on drivers/hwmon/applesmc.c
+ * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
+ * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
+ *
+ */
+
+#include <linux/leds.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/platform_device.h>
+
+struct macsmc_led {
+	struct led_classdev cdev;
+	struct apple_smc *smc;
+	u8 brightness;
+};
+
+static enum led_brightness macsmc_led_get_brightness(struct led_classdev *cdev)
+{
+	struct macsmc_led *drv = container_of(cdev, struct macsmc_led, cdev);
+
+	return drv->brightness;
+}
+
+static void macsmc_led_set_brightness(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct macsmc_led *drv = container_of(cdev, struct macsmc_led, cdev);
+
+	drv->brightness = (u8) value;
+
+	apple_smc_write_u16(drv->smc, SMC_KEY(LKSB), drv->brightness);
+}
+
+static int macsmc_led_probe(struct platform_device *pdev)
+{
+	struct macsmc_led *drv;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->smc = dev_get_drvdata(pdev->dev.parent);
+
+	drv->cdev.name = "macsmc-led";
+	drv->cdev.max_brightness = 255;
+	drv->cdev.brightness_get = macsmc_led_get_brightness;
+	drv->cdev.brightness_set = macsmc_led_set_brightness;
+	drv->cdev.dev = &pdev->dev;
+
+	return devm_led_classdev_register(&pdev->dev, &drv->cdev);
+}
+
+static struct platform_driver macsmc_led_driver = {
+	.probe = macsmc_led_probe,
+	.driver = {
+		.name = "macsmc-led",
+	},
+};
+module_platform_driver(macsmc_led_driver);
+
+MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
+MODULE_DESCRIPTION("LED keyboard backlight driver for Intel-macs using macsmc");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_ALIAS("platform:macsmc-led");
diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index 6567d2f1f..bc4200f57 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -33,6 +33,10 @@ static const struct mfd_cell apple_smc_acpi_common[] = {
 	MFD_CELL_NAME("macsmc-power"),
 };
 
+static const struct mfd_cell apple_smc_acpi_led[] = {
+	MFD_CELL_NAME("macsmc-led"),
+};
+
 static const struct mfd_cell apple_smc_acpi_light[] = {
 	MFD_CELL_NAME("macsmc-light"),
 };
@@ -179,6 +183,13 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 			if (ret < 0)
 				return ret;
 		}
+
+		if (apple_smc_key_exists(smc, SMC_KEY(LKSB))) {
+			ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_led,
+				ARRAY_SIZE(apple_smc_acpi_led), NULL, 0, NULL);
+			if (ret < 0)
+				return ret;
+		}
 	} else
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_rtkit_devs,
 			ARRAY_SIZE(apple_smc_rtkit_devs), NULL, 0, NULL);
-- 
2.55.0

