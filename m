Return-Path: <SRS0=ax+g=64=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A1CC433E0
	for <linux-integrity@archiver.kernel.org>; Thu, 14 May 2020 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8BB206F1
	for <linux-integrity@archiver.kernel.org>; Thu, 14 May 2020 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgENQt5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 May 2020 12:49:57 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:48759 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgENQt5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 12:49:57 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 04EGnEpq006864;
        Thu, 14 May 2020 19:49:14 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id E5974639BE; Thu, 14 May 2020 19:49:13 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org,
        "benoit.houyere@st.com--to=mark.rutland"@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1] make implementation of read16, read32 and write32 optional fix
Date:   Thu, 14 May 2020 19:48:24 +0300
Message-Id: <20200514164825.35377-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

This patch fix compilation error for newly added CR50 SPI driver found in previous submission.

Amir Mizinski (1):
  tpm: tpm_tis: make implementation of read16, read32 and write32
    optional fix

 drivers/char/tpm/tpm_tis_spi.h      | 4 ----
 drivers/char/tpm/tpm_tis_spi_cr50.c | 3 ---
 2 files changed, 7 deletions(-)

-- 
2.7.4

