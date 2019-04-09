Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD7C10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9556C217F4
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554835814;
	bh=9MrHQIijW73YISreYdB1PQIpmzdT8BcWHEhjf7B25rk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=omny9ydo0nLRTuNBsjOQLPkJpnB+iYaJGNyXkSiqqCodcdbWyIpvxmRVwJBPhpbJC
	 qoQ8QjNyikQfDnq6Tz9lcNkIPUD+8WeliOLiUAaUN+AGXORfVidP9VuOvlo/LI/zoJ
	 VOJB3yZKJR83Q+KYBRz7LVQjld9DIB7ChYks9RhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDISuO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDISuO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 14:50:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D084B20833;
        Tue,  9 Apr 2019 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554835813;
        bh=9MrHQIijW73YISreYdB1PQIpmzdT8BcWHEhjf7B25rk=;
        h=From:To:Cc:Subject:Date:From;
        b=mhKBNPSnjoTOYun4ZO1znbSBAmVjvTxZBzYNsUU5F+TKvajMHAl0zRbgyiwKCS7W7
         8Kzty4jOPE9/OL+G8fFYVPF++FIF+PYJ2eAoD12yo7iXkwfulvPHkOnL4rKDuhy7WF
         90MWvJXpm9Sj9qv72ZFAqjN/KKYna2J0tHaL6Gvc=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     mark.rutland@arm.com, corbet@lwn.net, robh+dt@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 0/3] ftpm: a firmware based TPM driver
Date:   Tue,  9 Apr 2019 14:49:55 -0400
Message-Id: <20190409184958.7476-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes since v1:

 - Code nits (remove flags, debug statements, close up leaks, etc)
 - Add docs under Documentation/

Sasha Levin (3):
  ftpm: dt-binding: add dts documentation for fTPM driver
  ftpm: firmware TPM running in TEE
  ftpm: add documentation for ftpm driver

 .../bindings/security/tpm/tpm_ftpm_tee.txt    |  13 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 Documentation/security/tpm/index.rst          |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst   |  31 ++
 drivers/char/tpm/Kconfig                      |   5 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 346 ++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h               |  52 +++
 8 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.19.1

