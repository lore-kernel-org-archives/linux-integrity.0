Return-Path: <SRS0=5Xo2=4V=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93DC3F2CE
	for <linux-integrity@archiver.kernel.org>; Wed,  4 Mar 2020 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E686020842
	for <linux-integrity@archiver.kernel.org>; Wed,  4 Mar 2020 21:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhaZOm6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgCDVNJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:13:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33366 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDVNI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 16:13:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id c62so4042696edf.0;
        Wed, 04 Mar 2020 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dCW1rcJ9YTWBdWzukHsXIprcdho8wqp30teVzoaXut8=;
        b=hhaZOm6Es2C55CAvBU+VYbagW2+NeHvOsx/3IIP2rRB+gbhRF98csxzI4b8Kf/imnN
         nbNQYRgyqg19wKk6Djpd1Sr1gHKz093YwwYsfUKZl4TNHgfapKvszqKKtJ9IbSqmzSV9
         M6EDOL3PO4dm+2Qi5uo6c7qhvu9bQLPQ5NI/N8ZvERWU61nxOLrtN4dlXuXt825WyqJh
         +BHzU/SLm1PfSH8RYqmudG78JksBElE316aVzGBm+uBT4UaEb6CIVtbChFUmRs2J+aMs
         m3H+UV4rnJdNdtrlaN6BRDWmeGBeBf7vQ3rEcKKZDS21xu3gK5BAvoDvtKDVsze15BwE
         K9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dCW1rcJ9YTWBdWzukHsXIprcdho8wqp30teVzoaXut8=;
        b=jHo+WLd6FR41v8h4FSYXvfr5tjYos+8Rz0e7UNOfti/1vYMmaVs5rk2DFbZ1HvqzYJ
         06XkvGSo/qr2xDRnMmB39lWH2ESWvvOuINO90mTVv5XEgHaampkWIdFwma80fCRjdevD
         GPElCdN82VOvHi5aUBObvwOHxpuusurgqMH6ELYtKC794QmScjXEwpzqEtK4CRhOB4wq
         OD4rE+ueqzsELcS+QkhiNXgDmdnOP1mx46qcBRDdEPhX7w3FmObFIzc7IjmyaBmNCP8U
         1sl4owj1kLirHK4lANuVlaqEZWLYrU+6/gpDnvnHtzS/mK3hEI+EjFMXp+P5HZx218Y9
         IWUg==
X-Gm-Message-State: ANhLgQ2tw1W1JJ0MhsJtatnmsER4dLFOfeLQNYf50L9rqgigv76bfbEi
        nDHf5zhiIrSr0RWKpkyRyJo=
X-Google-Smtp-Source: ADFU+vtmldY3b7mOyJ02OLZ/ej4YOW/EaU4qKPRgCjxwGYhH2vdgob5TcGv3OcYMps2GuAzzT9Ambw==
X-Received: by 2002:aa7:df94:: with SMTP id b20mr1744181edy.84.1583356386605;
        Wed, 04 Mar 2020 13:13:06 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id j21sm1005332edt.32.2020.03.04.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:13:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: adjust to trusted keys subsystem creation
Date:   Wed,  4 Mar 2020 22:12:54 +0100
Message-Id: <20200304211254.5127-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
to trusted-keys/trusted_tpm1.c in security/keys/.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: security/keys/trusted.c
  warning: no file matches F: include/keys/trusted.h

Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
files in security/keys/ are identified as part of KEYS-TRUSTED.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Changes to v1:
- use a global pattern for matching the whole security/keys/ directory.
Sumit, please ack.
James or Jarkko, please pick this patch v2.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c755e03ddee..7f11ac752b91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9276,8 +9276,8 @@ L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
-F:	security/keys/trusted.c
-F:	include/keys/trusted.h
+F:	include/keys/trusted_tpm.h
+F:	security/keys/trusted-keys/
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-- 
2.17.1

