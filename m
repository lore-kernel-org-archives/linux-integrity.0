Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD811C433EF
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Feb 2022 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiBOHuN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOHuN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Feb 2022 02:50:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E098A303
        for <linux-integrity@vger.kernel.org>; Mon, 14 Feb 2022 23:50:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33DDA210ED;
        Tue, 15 Feb 2022 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644911402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ri+jy6g99BCa2fDBfgGL3cz0lHKNPGMprQO3MplVNPI=;
        b=jyWeMgCA2RXidfcWKWoW+5pfZI+NeMl3j/DZuK+Iwdm6xSsmd8zW4Sup8ZX2WxWJxUXrIP
        MTzaoAydBj2PncVMVjcCksCPF+TCgMx2lc6KdE4QkgBbK68LRlcU94Vl0PUh8yYbraBxpO
        a2xE5CWlSJkZu2v0nsNNi2unfG3B/Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644911402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ri+jy6g99BCa2fDBfgGL3cz0lHKNPGMprQO3MplVNPI=;
        b=EaY83VPK0qOUyl06di0xyBVcFZYsV2PswO1TXFbgNSZouzpfjH/rJzWfkqKbCspk58kUCF
        sQ0IwVEwi7P2PvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5B6A13BD2;
        Tue, 15 Feb 2022 07:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p9/GMylbC2IbTAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 15 Feb 2022 07:50:01 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/1] ci: Remove CentOS 8
Date:   Tue, 15 Feb 2022 08:49:58 +0100
Message-Id: <20220215074958.6942-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It EOL in 12/2021 and CI is failing due removed repo:

CentOS Linux 8 - AppStream                      232  B/s |  38  B     00:00
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

the error:
https://github.com/pevik/ima-evm-utils/runs/5196409185?check_suite_focus=true

Mimi, could you please test Travis CI?
I tested only GitHub Actions:
https://github.com/pevik/ima-evm-utils/actions/runs/1845623174

Kind regards,
Petr

 .github/workflows/ci.yml | 5 -----
 .travis.yml              | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 4316ede..5e4498e 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -80,11 +80,6 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "centos:latest"
-            env:
-              CC: gcc
-              TSS: tpm2-tss
-
           - container: "debian:testing"
             env:
               CC: clang
diff --git a/.travis.yml b/.travis.yml
index bdf78a1..1429e77 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -55,10 +55,6 @@ matrix:
           env: DISTRO=centos:7 TSS=tpm2-tss
           compiler: gcc
 
-        - os: linux
-          env: DISTRO=centos:latest TSS=tpm2-tss
-          compiler: clang
-
         - os: linux
           env: DISTRO=debian:testing TSS=tpm2-tss
           compiler: clang
-- 
2.35.1

