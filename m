Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C9C433FE
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Nov 2022 14:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKCO4B (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiKCOzr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6C1900A
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 07:55:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b9so2534337ljr.5
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8aM3D6k3o3+OBBWq1cbwFbG7wHaFQeNS2TuG4KSzVM=;
        b=lDaWWFe8A1pfWWKxs1cCM+nHR5Foocrbw6yEKvTGimE8TMxqsS2AbJ9d041dXw+VJV
         tnrwULJ6GSzSSdiEiY9XRQqQWLnFY0pdxnqvHJmvnjOdYwe62UG3dGl5Kv5QsRzpfBOo
         RR0ewPd+xHYTOuyvlujgW9pxGA8V6xnxtGdxcGzS4BtZLCVpwLOpL49XX9xFxUvL7bmp
         yTFYwj2IOW9QQe+RpKqHNYcUxyOZuwovHWlT31N9LfwTwNRLa1aAFuEdOwWNlpWdZczI
         vSfsWu7IBiyPRHhgHLK4pDrySz7wxMoWtIbnEba+8hg1ECeA62Gol0o3CL2zzZ/cWcof
         ESkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8aM3D6k3o3+OBBWq1cbwFbG7wHaFQeNS2TuG4KSzVM=;
        b=MV8HA6om3WEjw5I+23u0Ga0MRkmoOr6nzjMUWEXNBZucnOkyb0lq5vGexNrwulXuRs
         D59Zistfz21/dHx/UE0B3isaFl3ormhXBz2RpHLiMWfJ36LMcez1o3SLU4WMwUJY3Mvq
         InrJ4MJjz9NXqXKfWLXaKc0yJuxJZHwOog6ihtyzw/Auy10x4rPG26Tx0/8ie1/OK1sn
         S64MKFtzeo6iQavYcluz7JZEGR13nUkuLHHy1/DFxta0YIutns+IOIKdI2T1rPaDoK4h
         /oKjpywJUbYSXVGiHd091aRKYW/WhqOPp9gLrqdUXPHQEyRnHz3vQTLZsDKWBDprLa3x
         hi3Q==
X-Gm-Message-State: ACrzQf3esPBFAzmulN+dcVnHTQGGTc/5GLPV/RLdEdWPMqlHzDsgu+av
        DwenpmCONYf+WYeE/zlfh2EovBwce0D0cfzh
X-Google-Smtp-Source: AMsMyM5jUlnZGWSY7ysiJ0iV9KssDIy2j82jq2x5EVqXssQiSiqNvoVB39S4S+yGkMQm7g1l/4TgIg==
X-Received: by 2002:a2e:bea9:0:b0:26f:df23:b04f with SMTP id a41-20020a2ebea9000000b0026fdf23b04fmr11850918ljr.395.1667487323933;
        Thu, 03 Nov 2022 07:55:23 -0700 (PDT)
Received: from dabros-l.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0049c29389b98sm154878lfr.151.2022.11.03.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:55:23 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH v2 0/3] char: tpm: Adjust cr50_i2c locking mechanism
Date:   Thu,  3 Nov 2022 15:54:47 +0100
Message-Id: <20221103145450.1409273-1-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset aims to add support for a platforms with cr50(tpm) i2c
chip shared across two CPUs. We need to provide a mechanism, which will
allow to synchronize accesses on a TPM-transaction boundaries.

First commit in a patchset is a generic fix for an issue encountered
during suspend stress test.

Next two patches are modifying cr50 to use generic callbacks for
locality management and then leverage this solution to apply i2c bus
locking on a TPM-operation level.

v1->v2:
* Get back with tpm_cr50_check_locality to return 0 instead of locality
* Return from functions which get (locality < 0)

Jan Dabros (3):
  char: tpm: Protect tpm_pm_suspend with locks
  char: tpm: cr50: Use generic request/relinquish locality ops
  char: tpm: cr50: Move i2c locking to request/relinquish locality ops

 drivers/char/tpm/tpm-interface.c    |   5 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 126 ++++++++++++++++++----------
 2 files changed, 85 insertions(+), 46 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

