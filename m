Return-Path: <SRS0=4Kou=YI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCCECE58F
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Oct 2019 23:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AF120663
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Oct 2019 23:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qjKjRqNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJOXRy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:17:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJOXRy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 19:17:54 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B06220B71C6;
        Tue, 15 Oct 2019 16:17:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B06220B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571181473;
        bh=CclEh5Td/ZLrZKFXywNwaVVFQIwWJzZF/Y0wTbXiOg0=;
        h=From:To:Cc:Subject:Date:From;
        b=qjKjRqNx1O/KLkXjDfBxZa5ZGQO7RL1oxJf+W4AMKMRBZY97VI1uooYc8amKNiANn
         t2VUrVWQzeClRvpJCnJ9kX2Nx46FUx9yVy2fpAMBj7+vpAppW5AZCQf/sHtIJMK7HD
         tPh0VCwBYAENZOy8FceH3terW76sMzTFcZbodVnE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 0/1] KEYS: LSM Hook for key_create_or_update
Date:   Tue, 15 Oct 2019 16:17:49 -0700
Message-Id: <20191015231750.25992-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a LSM Hook for key_create_or_update function. The motive behind
this change is enable subsystems to receive notification when
a new key is created or updated. IMA will be one of the subsystems
that will use this hook to measure the newly created key.

Lakshmi Ramasubramanian (1):
  KEYS: LSM Hook for key_create_or_update

 certs/system_keyring.c            | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h     |  4 ++++
 include/linux/ima.h               |  8 ++++++++
 include/linux/lsm_hooks.h         | 14 ++++++++++++++
 include/linux/security.h          | 10 ++++++++++
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
 security/keys/key.c               |  8 ++++++++
 security/security.c               | 11 +++++++++++
 9 files changed, 98 insertions(+)

-- 
2.17.1
