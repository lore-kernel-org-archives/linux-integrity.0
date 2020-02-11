Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F6C35242
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 23:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812AB20714
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 23:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CW/HVQc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBKXO1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36372 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgBKXO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5BC0B20B9C02;
        Tue, 11 Feb 2020 15:14:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BC0B20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581462866;
        bh=Iha9xp4sRSgk0eY4Hmp0EjPqYaPdWlXsj0OYg2m5bOI=;
        h=From:To:Cc:Subject:Date:From;
        b=CW/HVQc25t6bcrdOMDmXjdRf7BcVLhE6wLL5iPoJUtJGRiIYniReZOlVnNXd42eyD
         GEdLIkA9Z7fI3SjbBWsySrEsVut4c6M4VyFPOyFBidW3a+Q2pdraK/ZOJvOzUI+0WU
         uGSt9i8ulhlHscXZb8O5sH7/JPFng3P/d4NoUAb8=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] IMA: improve log messages in IMA
Date:   Tue, 11 Feb 2020 15:14:11 -0800
Message-Id: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some files under IMA prefix the log statement with the respective file
names and not with the string "ima". This is not consistent with the rest
of the IMA files.

The function process_buffer_measurement() does not have log messages for
failure conditions.

The #define for formatting log messages, pr_fmt, is duplicated in the
files under security/integrity.

This patchset addresses the above issues.

Tushar Sugandhi (3):
  add log prefix to ima_mok.c, ima_asymmetric_keys.c, ima_queue_keys.c
  add log message to process_buffer_measurement failure conditions
  add module name and base name prefix to log statements

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

