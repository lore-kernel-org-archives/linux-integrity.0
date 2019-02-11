Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3FC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8D21B1C
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="adXXiIkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfBKQBL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:01:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40148 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbfBKObX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25-v6so8914718ljk.7
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ID2+altBHwpRMSebDiExrpvSLmkUDj1M10qr+jHAcQI=;
        b=adXXiIkMkKJy8YnUOfH9rF3o+RkZ4jHw6UQEBlqLpbSmzVEs1G0cqN/d0lv4mgDEJz
         ZOcNm86TK17cNvPfiix9omZLZwmry7OiRuHGOrnhA1CD1+BQraTaDasRu/O+7nRzLsQ4
         rYF6e84YzqAPKXVq/Wk5Co6XPJwrp0fhzOYsBBA6JPs9XM4a6JKfc9ixNhAwGnwIkQbZ
         ohLmmAKGIZuuMxYKPS8wftf2UhUrgR7qTF3aWf9zpj6rheJlnLO3xW3ryrtERQH9WQUm
         rniY7ZGWY0QupIYmcVdmDvIaWwUkL8mPAxJA5X4UOEhAQrPPRBL877d/lbqTho5VkWHf
         l5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ID2+altBHwpRMSebDiExrpvSLmkUDj1M10qr+jHAcQI=;
        b=lZUEZVJGBaj5KaBxxzQv62sR72012miqQw3DGJOieWJ8hLyAshhZFZ/HLfhHGXD1XR
         HJUj1f1Yzt9KLKQqbZBhh5k7/YpV7yvT2GH1Qhd4U87NrXI4bxfyM4O//TJfqWRGRZsE
         FLmysOZecvB6OKlt0fM4/mpL7wwZPlTeaa6a+SFEWvU6isj+7zlpTpUSmVE92JGpAMIo
         hw8UyDbU9yKylz8b05ndBRqkq7Wh51SurCwJCcD3UbmP8JH5nY8yFEM1ggn0FAsYhSDB
         P285R5GocSKtpHIYHOv7y086hmIxhNeNjmgxpCp1zP0aTUGn3oBfoRH9TyA+siEYgmWn
         C5qA==
X-Gm-Message-State: AHQUAuYgG3NQ97PWdAj1WUExKH6tNxcdXXoAi16uu/Ewq7QBdimQbhJF
        OkPphjyYWo5EY8LmFCbu76vrzQ==
X-Google-Smtp-Source: AHgI3Ib2A5nciWC3NbQa6v59+B6hOogYnCNDmOw9Y+Is1R+bdqRYB3rR5r2UXl23e2Cwk8E6HGphgg==
X-Received: by 2002:a2e:8103:: with SMTP id d3-v6mr10052992ljg.98.1549895481145;
        Mon, 11 Feb 2019 06:31:21 -0800 (PST)
Received: from bsz-kubuntu.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z6sm2322373lfa.87.2019.02.11.06.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:31:20 -0800 (PST)
From:   bsz@semihalf.com
To:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, ard.biesheuvel@linaro.org
Cc:     tweek@google.com, mingo@kernel.org, hdegoede@redhat.com,
        leif.lindholm@linaro.org, mw@semihalf.com,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 0/5] Add support for TPM event log 2.0 on EFI/ARM
Date:   Mon, 11 Feb 2019 15:30:47 +0100
Message-Id: <20190211143052.3128-1-bsz@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Bartosz Szczepanek <bsz@semihalf.com>

These few patches introduce support for retrieving TPM event log in 2.0
format from EFI structures. Since 2.0 format involves dynamically-sized
records, some more computation is needed. Function responsible for this
has already been in kernel (calc_tpm2_event_size) - it was moved to
library, so it can be used from both EFI stub and device drivers.
Signature is slightly altered, as explained in one of the commits.

EFI stub was enhanced to call EFI GetEventLog function asking for 2.0
event log. If found, it's installed in configuration table similarily
to TPM 1.2 log. In case 2.0 log is not available, it falls back to 1.2
log.

Call to efi_retrieve_tpm2_eventlog() is added at ARM efi_entry to enable
TPM functionality on ARM / ARM64 platforms.

It was tested on two platforms - ARM64 and x86_64, both EFI-based and
equipped with TPM 2.0 module.

Bartosz Szczepanek (5):
  tpm: Copy calc_tpm2_event_size() to TPM library
  tpm: Change calc_tpm2_event_size signature
  tpm: Use library version of calc_tpm2_event_size in sysfs code
  efi/libstub/tpm: Retrieve TPM event log in 2.0 format
  efi/arm: Retrieve TPM event log at efi_entry

 drivers/char/tpm/eventlog/tpm2.c        |  89 +++++---------------------
 drivers/firmware/efi/libstub/Makefile   |   3 +-
 drivers/firmware/efi/libstub/arm-stub.c |   1 +
 drivers/firmware/efi/libstub/tpm.c      | 107 +++++++++++++++++++++++++++++++-
 include/linux/tpm_eventlog.h            |   3 +
 lib/Makefile                            |   2 +
 lib/tpm.c                               |  78 +++++++++++++++++++++++
 7 files changed, 208 insertions(+), 75 deletions(-)
 create mode 100644 lib/tpm.c

-- 
2.14.4

