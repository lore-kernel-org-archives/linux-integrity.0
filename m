Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7229FC43334
	for <linux-integrity@archiver.kernel.org>; Fri, 15 Jul 2022 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGOHbh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiGOHbd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jul 2022 03:31:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFAC7B379
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jul 2022 00:31:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51D0133FBC;
        Fri, 15 Jul 2022 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657870289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0Dwd4U5tz5PKLz0GsQkLydyf9BBZ02EbITM2RDzdWQU=;
        b=STmtz1biK7fW6DD3q2/tJvOPgGaio/Fc+MrPOX09tsHPRFIOp9I1g+l9rb3wMfamaX2IqY
        mkuu93TABqKzW9XFPXFWbJnJcFtsM+3hGMqE3pKKAj7l4NlBChp6eWIkRrBf4V8UkvR18R
        r8pSasN8GLGkHdaUFCnOLOpWZRKMGt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657870289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0Dwd4U5tz5PKLz0GsQkLydyf9BBZ02EbITM2RDzdWQU=;
        b=Z16N/Oe1tkXiSy2LOOVZr8LkxU43/d7GdCphCyXruIAjS6dOlHSUqbOtB4Ir53pI+3fry5
        dUY2dwo59JERtbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10F6113754;
        Fri, 15 Jul 2022 07:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DCmaAtEX0WLUDAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 15 Jul 2022 07:31:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/1] ci/alpine.sh: Install bash
Date:   Fri, 15 Jul 2022 09:31:21 +0200
Message-Id: <20220715073121.8979-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

bash is a dependency for tests, not being installed by default on
containers.

This fixes:
../test-driver: line 112: ./ima_hash.test: not found
../test-driver: line 112: ./sign_verify.test: not found
../test-driver: line 112: ./boot_aggregate.test: not found

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/alpine.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 63d7954..0e4ba0d 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -26,6 +26,7 @@ apk add \
 	attr-dev \
 	autoconf \
 	automake \
+	bash \
 	diffutils \
 	docbook-xml \
 	docbook-xsl \
-- 
2.37.0

