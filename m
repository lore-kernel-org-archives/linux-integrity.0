Return-Path: <SRS0=4Kou=YI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFEECE59E
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Oct 2019 22:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6B020873
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Oct 2019 22:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oGFvSmry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbfJOWF3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfJOWF3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2139B20B71C6;
        Tue, 15 Oct 2019 15:05:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2139B20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571177128;
        bh=4LKmqfOFNI45iExJsvp77DTwZ1f6bFrEwErCUVGHtcs=;
        h=From:To:Cc:Subject:Date:From;
        b=oGFvSmryVeV9jG1LJgb0IcGo9I3OsGgugTg65w35dVDvH3OnsYkTtzzGzF3nEk87c
         SFaZ/4GGpLN8K1+Zm8AbmbAlDbfd+iWrEGn7TBJNJ5/ysiheWkaXskQfwrSvjskRkt
         jVY7DludaXNajwk+WuT7VN4w49pO9ztg0VZVL0XI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, prsriva@linux.microsoft.com
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v0 0/1] ima: Refactor process_buffer_measurement() to make it generic
Date:   Tue, 15 Oct 2019 15:05:23 -0700
Message-Id: <20191015220524.20659-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch makes the function process_buffer_measurement() generic so that
it can be used to measure more than just the KEXEC_CMDLINE. This function
will also be used for measuring keys, blacklisted binaries, etc.

Lakshmi Ramasubramanian (1):
  ima: Refactor process_buffer_measurement() to make it generic

 security/integrity/ima/ima.h      |  3 +++
 security/integrity/ima/ima_main.c | 29 ++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.17.1
