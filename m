Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B5C77B7E
	for <linux-integrity@archiver.kernel.org>; Wed, 24 May 2023 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjEXCDg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 May 2023 22:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjEXCDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 22:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79EB5;
        Tue, 23 May 2023 19:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAFB637DD;
        Wed, 24 May 2023 02:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A67C433EF;
        Wed, 24 May 2023 02:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684893814;
        bh=QEDtgEH5GRxwgGBoLUJjlUD8xo6JG0EtP/wupHSXd4U=;
        h=From:To:Cc:Subject:Date:From;
        b=cQTg5annpMFQQUdabvbqyH5t6NzbMXKU7a6b3mTblHy8TZFdJxoNPY7+5ACa4sLdd
         I9cFxT6jPpTOkiDWUz4S9OaLaGhyQU5Qqa6CCeurMrE4XVn/Wg/Tde6xOPOnsqOrDC
         /3hgOpOtG5l7uGqiolD7+C5/ncvYj9SBSB8pBU/+6W5oFlHXumdT/qRnzm5vIiHLgy
         h/m9crMGuTNdLUTP4vY+Wa2PC4e9HwCotCfbJj5n1AvQ6tIxUGQmJDCdzSwj2/w7LV
         cwd5XI2ovOG5eve3SdDfN9+WumRrw4XBNYojM9RBRuFkHEpnX/kFZNgqsB4gTNYQ9z
         fiVGPIPV72cmA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.4-rc4
Date:   Wed, 24 May 2023 05:03:22 +0300
Message-Id: <20230524020322.252360-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 27e462c8fad4bf04ec4f81f8539ce6fa947ead3a:

  Merge tag 'xtensa-20230523' of https://github.com/jcmvbkbc/linux-xtensa (2023-05-23 15:21:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc4

for you to fetch changes up to 95a9359ee22ff2efbad6b090fcfa3a97f5902f95:

  tpm: tpm_tis: Disable interrupts for AEON UPX-i11 (2023-05-24 02:50:23 +0300)

----------------------------------------------------------------
Hi,

Contains a fix to add a new entry to the deny for list for tpm_tis
interrupts.

BR, Jarkko

----------------------------------------------------------------
Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts for AEON UPX-i11

 drivers/char/tpm/tpm_tis.c | 7 +++++++
 1 file changed, 7 insertions(+)
