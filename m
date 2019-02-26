Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A646FC10F0B
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2152173C
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMzhOoY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBZRJf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:09:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBZRJe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 12:09:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so2974212wmg.4
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLvP6xPvgt3zZ6L60RkM8gk0sE5u2f5QaUdGGopfzUo=;
        b=qMzhOoY2JHBYU27GAMqtR1nR18rPflsCFInTUZgFD6H3VfyBZjH+oESj40n+QHmZtZ
         wiWzI5AWyd93an1b1Og/ZvgVKKavlz2CS/Is7Ox6gvrPgicCLD9+QNsEXfrCibabWw1g
         nPaCe32KdTE7588I8mlHybkTm7Hlc2zB1Z3wAMh6mstCg/oCL+OND4RS7fyaNwl6JziD
         RITNjMcZUuIRbpsQ/ei8gRdvdmKMbZFvP3IICnIErxHtczgIqak4JVWMhm0et1bBvvXf
         6lqApTUrkMr1YUVIT8VKobz5EabjCiGgA7ElnbUgcNVXW6AQ4Z/xKp3lEaOY6K9UCFAI
         kq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLvP6xPvgt3zZ6L60RkM8gk0sE5u2f5QaUdGGopfzUo=;
        b=WBWulFzng5d8I1A6akt/cecZAGIjP+Nd6+vNmEKfgxvrtDNd6xkhjh1Enjwjece4fg
         NNyZC6Y3GbTrAqiP5rcD6RD4kmVhJNUHRPswLeJnf9zGjtoJIKSvYpathFflSi0/53fN
         eVBN+jQbhpL0HjBJT2pQwdWMbh3aMSUVz4LXlwV5tL9G0N0WpWU9NWc7K+DpfpYOByKV
         DP003tiXF5CvhQrjUWjw4TcRfCgwjjXGNYyfkouKPtk4Mum629jGfB4n1Y/PexInKNEd
         1pwW+NZ/An4XM9wRqG+t93aqvs1TIVimRGLT0WxBhdTciw/6nYqFPcVkhkz8fECWiUWA
         nD4g==
X-Gm-Message-State: AHQUAuYhM7PZoj8dIpUVJNwruqa5SrnQumgQw3GYQHqdOjO5EznmNV3q
        H4fiS8hHLiF6RyUuRxJCVNxtRucDS0c=
X-Google-Smtp-Source: AHgI3IbNf9NKqQBz06YmZMWc0SbXiQrEUJe/riKBWPdKpo1DM2fNash+Xhjx9Um7HDRZ98MeuTgPkg==
X-Received: by 2002:a1c:80c4:: with SMTP id b187mr3137222wmd.23.1551200972483;
        Tue, 26 Feb 2019 09:09:32 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:b00c:66c8:99df:336])
        by smtp.gmail.com with ESMTPSA id y8sm7603406wrm.8.2019.02.26.09.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 09:09:31 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH ima-evm-utils] Include sys/types.h in header to fix build with musl
Date:   Tue, 26 Feb 2019 17:09:10 +0000
Message-Id: <20190226170910.23479-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Luca Boccassi <luca.boccassi@microsoft.com>

Building a third program that depends on libimaevm with musl fails, as
the imaevm.h uses uid_t and gid_t without including sys/types.h:

<..>/sysroot/usr/include/imaevm.h:90:2: error: unknown type name 'uid_t'
  uid_t uid;

Including sys/types.h fixes building with musl and does not affect
building with glibc.

Signed-off-by: Luca Boccassi <luca.boccassi@microsoft.com>
---
 src/imaevm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index 795966a..d85db0d 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -44,6 +44,7 @@
 #include <linux/fs.h>
 #include <stdint.h>
 #include <syslog.h>
+#include <sys/types.h>
 #include <stdbool.h>
 #include <errno.h>
 
-- 
2.20.1

