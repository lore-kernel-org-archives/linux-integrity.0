Return-Path: <SRS0=Ujs8=BB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE3C433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB8520729
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 11:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgGVLrh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:47:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730585AbgGVLrh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 07:47:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D79B7AED2;
        Wed, 22 Jul 2020 11:47:43 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] Drop empty NEWS file
Date:   Wed, 22 Jul 2020 13:47:29 +0200
Message-Id: <20200722114729.4210-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 NEWS | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 NEWS

diff --git a/NEWS b/NEWS
deleted file mode 100644
index e69de29..0000000
-- 
2.27.0

