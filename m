Return-Path: <SRS0=E2Qz=6P=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C28C4724C
	for <linux-integrity@archiver.kernel.org>; Fri,  1 May 2020 18:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BAA208DB
	for <linux-integrity@archiver.kernel.org>; Fri,  1 May 2020 18:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I6WH2P/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgEASQF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 1 May 2020 14:16:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44936 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgEASQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 May 2020 14:16:05 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69B0E20B717B;
        Fri,  1 May 2020 11:16:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69B0E20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588356964;
        bh=6P2paN9NO0FWx6B7UbSmB/LcZk3eOjU9tLNhjVjgu2E=;
        h=From:To:Cc:Subject:Date:From;
        b=I6WH2P/pdHyLi0Ms0NIftrxrXe+LggJ7hhRdRSjWQPWtUqGQ8sApqO1Yf7/gxwjfg
         jBqK2KkRxnCcN27BqziSFWkTve5Jm5Q/+7D6JhxzDCv21tke7HbHnUVOrygX8vNyQI
         /1gcdaR3+NpGBfJMe+P1m0qXBpt+Z+roB+ziaAsk=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     nramas@linux.microsoft.com, prsriva@linux.microsoft.com,
        tusharsu@linux.microsoft.com, balajib@linux.microsoft.com
Subject: [RFC][PATCH 0/2] Add support for using reserved memory for ima buffer pass
Date:   Fri,  1 May 2020 11:15:50 -0700
Message-Id: <20200501181552.1184827-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA during kexec(kexec file load) verifies the kernel signature and measures
the signature of the kernel. The signature in the logs can be used to verfiy the 
authenticity of the kernel. The logs don not get carried over kexec and thus
remote attesation cannot verify the signature of the running kernel.

Introduce an ABI to carry forward the ima logs over kexec.
Memory reserved via device tree reservation can be used to store and read
via the of_* functions.

Reserved memory stores the size(sizeof(size_t)) of the buffer in the starting
address, followed by the IMA log contents.

Tested on:
  arm64 with Uboot

Prakhar Srivastava (2):
  Add a layer of abstraction to use the memory reserved by device tree
    for ima buffer pass.
  Add support for ima buffer pass using reserved memory for arm64 kexec.
    Update the arch sepcific code path in kexec file load to store the
    ima buffer in the reserved memory. The same reserved memory is read
    on kexec or cold boot.

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  22 ++++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          |  64 ++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 arch/powerpc/include/asm/ima.h         |   3 +-
 arch/powerpc/kexec/ima.c               |  14 ++-
 drivers/of/Kconfig                     |   6 +
 drivers/of/Makefile                    |   1 +
 drivers/of/of_ima.c                    | 165 +++++++++++++++++++++++++
 include/linux/of.h                     |  34 +++++
 security/integrity/ima/ima_kexec.c     |  15 ++-
 13 files changed, 325 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c
 create mode 100644 drivers/of/of_ima.c

-- 
2.25.1

