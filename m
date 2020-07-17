Return-Path: <SRS0=k5Jw=A4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA2FC433E5
	for <linux-integrity@archiver.kernel.org>; Fri, 17 Jul 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511762071A
	for <linux-integrity@archiver.kernel.org>; Fri, 17 Jul 2020 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRtQzivE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQIuX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQIuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 04:50:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DAC061755
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so6368684pgc.8
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=lRtQzivEf2cCiMyei1lVXETGj3wO+frDXypbkG9dastQNt9ukpIkiW1uHKa96n7L1m
         9aQxIP3dbyq33eF2GJ+iNrBMDKd5HwIdJ8W1/lzafOBHQXzpqxN0CQrglNxsrkk9IaMT
         CpB9WBuu7qJGza5D5lxMmfdhxPmqrvFJlMqBZsZe1aFDJ9uTCgV04YaedAyLcrZ3viUy
         tT91uJD7nyMJ+AY6we1LzwkroN1cK43LBwYex/fypAfMErA0yOrmETET80xy0LT72Hlw
         7v536I49sOzpqQJwr+7hOl7JM4xeQ4NMbm1BN5YrJY+vfoN+VZlClYgN5nM7I8T6DQjQ
         vJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=KpAr/yrBGV8PViwkRuC8JOeRmVyPW1vAd7dy3XZV82M3wAjANm6hr5LmLQjiWtDBFu
         oXL6SrSkREee6O28bdagWtCgX0//6LMuxmFfhC1TmiKbYGJFLKr1sfltaYrXjmO+Q88i
         uWY5Lt4h7cz6eKVduaURbUWhMjE7Z9Qn/iuhQq5bqQU74fI41ixIL+o4JP4erWKEDwes
         61WSVfPQEmtrByHXSCS27AieK8Z4kcW6e4cHoeJ8tsUIus8EXrJ8j4R30NFFYximpEf8
         Bc9uz1oz87ZjAI9+KhL/yPVQG8zuA+GBYWlZLw69KRlGZ98GP8lty5xpwMH8jr8J0NW0
         1P5Q==
X-Gm-Message-State: AOAM5324v2r4h92F/D0zGPC7P4qqBCHV4yMyva0+4S2zPal79+3RVRrJ
        V8WLxnsR6s801utrn27ml/l9qA==
X-Google-Smtp-Source: ABdhPJxwbnGcCA+Ao1mGz9LcqCtufhcCqaj6FVUTjWwdjDgxuXUXyF61QXObtW678H1QzTjA0jJ+GA==
X-Received: by 2002:a63:125a:: with SMTP id 26mr8055436pgs.340.1594975822468;
        Fri, 17 Jul 2020 01:50:22 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id f207sm7309364pfa.107.2020.07.17.01.50.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:50:21 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
Date:   Fri, 17 Jul 2020 17:49:32 +0900
Message-Id: <20200717084932.3449-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717084932.3449-1-masahisa.kojima@linaro.org>
References: <20200717084932.3449-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a compatible string for the SynQuacer TPM to the binding for a
TPM exposed via a memory mapped TIS frame. The MMIO window behaves
slightly differently on this hardware, so it requires its own
identifier.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4165352a590a..814148939e5a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -328,6 +328,8 @@ properties:
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
+            # Socionext SynQuacer TPM MMIO module
+          - socionext,synquacer-tpm-mmio
             # i2c serial eeprom  (24cxx)
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-- 
2.20.1

