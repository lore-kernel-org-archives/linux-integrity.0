Return-Path: <SRS0=baCK=4D=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806DDC3F68F
	for <linux-integrity@archiver.kernel.org>; Sat, 15 Feb 2020 01:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502712083B
	for <linux-integrity@archiver.kernel.org>; Sat, 15 Feb 2020 01:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o8d6BzII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBOBsN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:48:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57470 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgBOBrt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:49 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id F287820B9C02;
        Fri, 14 Feb 2020 17:47:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F287820B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581731269;
        bh=Hde/bKh9d001mm0uPgjU5M8y2bAWp3+eaOklA6nBSbE=;
        h=From:To:Cc:Subject:Date:From;
        b=o8d6BzII36wuqVnhoJJVRNtK3RvovHbWuvJ/9UEsdlrzABOCASxnvXJdm0+GjkyuP
         nKg9FMuqOIYt539U99ropVPaiJSkGFwsozvWcYpe/zZnhMarTP7nsaTrdQgymH+Grx
         L0ToBmo/hm+nD1At8UPaa7NcHis+fGR1/0T6rwlk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] IMA: improve log messages
Date:   Fri, 14 Feb 2020 17:47:06 -0800
Message-Id: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The log messages from IMA subsystem should be consistent for better
diagnosability and discoverability.

This patch set improves the logging by removing duplicate log formatting
macros, adding a consistent prefix to the log messages, and adding new 
log messages where necessary.

Tushar Sugandhi (3):
  add log prefix
  add log message to process_buffer_measurement failure conditions
  add module name prefix to log statements

 security/integrity/digsig.c                  | 2 --
 security/integrity/digsig_asymmetric.c       | 2 --
 security/integrity/evm/evm_crypto.c          | 2 --
 security/integrity/evm/evm_main.c            | 2 --
 security/integrity/evm/evm_secfs.c           | 2 --
 security/integrity/ima/Makefile              | 6 +++---
 security/integrity/ima/ima_asymmetric_keys.c | 2 --
 security/integrity/ima/ima_crypto.c          | 2 --
 security/integrity/ima/ima_fs.c              | 2 --
 security/integrity/ima/ima_init.c            | 2 --
 security/integrity/ima/ima_kexec.c           | 1 -
 security/integrity/ima/ima_main.c            | 5 +++--
 security/integrity/ima/ima_policy.c          | 2 --
 security/integrity/ima/ima_queue.c           | 2 --
 security/integrity/ima/ima_queue_keys.c      | 2 --
 security/integrity/ima/ima_template.c        | 2 --
 security/integrity/ima/ima_template_lib.c    | 2 --
 security/integrity/integrity.h               | 6 ++++++
 18 files changed, 12 insertions(+), 34 deletions(-)

-- 
2.17.1

