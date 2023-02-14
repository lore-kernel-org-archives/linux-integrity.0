Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA47C61DA4
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Feb 2023 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjBNVAn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjBNVAm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:00:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38C2823C
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:00:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DC061FD81;
        Tue, 14 Feb 2023 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676408440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y0cxKkRt/yiljE5Uf3kLT3p5Edq03/NUSsYWjvWzJLU=;
        b=Xdw/n1zXDaMn7stFLjcZVeYPj+6VncSdSpiq9P+fi+1OfPwTc2q0PGTPqFWeaHUgFuKCdN
        WAL6JDIIupV2vLXtPSnJ9aYx2zIxVOzTrUa7sQHDQhfznza+AEIM+pZ05ie7sig4vGi4e2
        Z3lw8mTJ7FvnOp7Sm3oB1qf4DQrQrr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676408440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y0cxKkRt/yiljE5Uf3kLT3p5Edq03/NUSsYWjvWzJLU=;
        b=6FNjqeXk4SxLh8bfKTFT72mRPC7l59T5rDsBUKNUPd5QOveOTO2Jp0y8ZpPMGdRgNvOLb1
        6wXL2qknkNbIjdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B60F013A21;
        Tue, 14 Feb 2023 21:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2P3cKnf262OqeAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 14 Feb 2023 21:00:39 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
Date:   Tue, 14 Feb 2023 22:00:32 +0100
Message-Id: <20230214210035.585395-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tested:
https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413

Petr Vorel (3):
  tests/install-swtpm.sh: Update ibmswtpm2 to 1682
  github: travis: Remove COMPILE_SSL from tumbleweed
  github: Put openSSL build into own section

 .github/workflows/ci.yml | 8 ++++++--
 .travis.yml              | 2 +-
 tests/install-swtpm.sh   | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.39.1

