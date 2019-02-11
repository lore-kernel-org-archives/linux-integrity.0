Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7663C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9117721B69
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBKQyz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:54:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfBKQyz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 11:54:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5C2EAC8D;
        Mon, 11 Feb 2019 16:54:53 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Cc:     Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>
Subject: [RFC PATCH 0/5] Fix overlayfs on EVM
Date:   Mon, 11 Feb 2019 17:53:18 +0100
Message-Id: <20190211165323.9369-1-iforster@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ignaz Forster <iforster@suse.de>

This patch series tries to solve several problems found when using
EVM on an overlay file system.

Especially patch 4 and 5 will need further discussion; patch 4 will
introduce follow up problems, patch 5 can be considered a workaround
at best.

Ignaz Forster (4):
  Rename ima_post_create_tmpfile
  Execute IMA post create hook in vfs_create
  Ignore IMA / EVM xattrs during copy_up
  Use __vfs_getxattr to get overlayfs xattrs

Mimi Zohar (1):
  evm: instead of using the overlayfs i_ino, use the real i_ino

 fs/namei.c                          |  6 ++++--
 fs/overlayfs/inode.c                |  3 ++-
 include/linux/ima.h                 |  4 ++--
 security/integrity/evm/evm_crypto.c |  3 +++
 security/integrity/evm/evm_main.c   | 23 +++++++++++++++++++++++
 security/integrity/ima/ima_main.c   | 10 +++++-----
 6 files changed, 39 insertions(+), 10 deletions(-)

-- 
2.20.1

