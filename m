Return-Path: <SRS0=r8GU=DF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF72C2D0A8
	for <linux-integrity@archiver.kernel.org>; Mon, 28 Sep 2020 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168BA20789
	for <linux-integrity@archiver.kernel.org>; Mon, 28 Sep 2020 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DVtyyviQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1Tre (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:47:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45020 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1Tre (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 15:47:34 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF09120B7178;
        Mon, 28 Sep 2020 12:47:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF09120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601322454;
        bh=mp/cwU/D1jFQ2uxW67x5UACNptiiB8HeXLS+UpRGtuA=;
        h=From:To:Cc:Subject:Date:From;
        b=DVtyyviQ/DcGrJim5lBcPFk6thGBshSZJL2YXwKo+iqaJZrz+EsLLUfZSmkhQNi11
         h35D+BWZ8mmLQOdJ939TI0nuy1sSVmCYPF1v90zE9ETjBeMq+myIIRoxZ0XgB2cxVy
         SjWwuV5VI8KgA+1xmVyqK3bt+qKesx5/8HjjCW3Y=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com,
        stephen.smalley.work@gmail.com, paul@paul-moore.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 0/1] ima: Add test for selinux measurement
Date:   Mon, 28 Sep 2020 12:47:29 -0700
Message-Id: <20200928194730.20862-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by Linux Security Modules (LSM). Currently one
such LSM namely selinux is being updated to use this functionality.
This new functionality needs test automation in LTP.

This patch set adds tests which verify that the IMA subsystem correctly
measures the data provided by selinux.

This patch is based on 
commit 286401a1c1f3 ("thp04: Add linux tag")
in "master" branch in https://github.com/linux-test-project/ltp

This patch is dependent on the following patch series in LTP
https://patchwork.kernel.org/patch/11802771/

This series needs a kernel built on the following repo/branch/patches:
repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
branch: next
commit 8861d0af642c ("selinux: Add helper functions to get and set checkreqprot")

And the following patch series should be applied in the following order:
  1, https://patchwork.kernel.org/patch/11709527/
  2, https://patchwork.kernel.org/patch/11795559/
  3, https://patchwork.kernel.org/patch/11801525/
  4, https://patchwork.kernel.org/patch/11801585/

Lakshmi Ramasubramanian (1):
  ima: Add test for selinux measurement

 runtest/ima                                   |   2 +
 .../kernel/security/integrity/ima/README.md   |  19 +++
 .../integrity/ima/tests/ima_selinux_policy.sh |  72 ++++++++++
 .../integrity/ima/tests/ima_selinux_state.sh  | 136 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  28 ++++
 5 files changed, 257 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh

-- 
2.28.0

