Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FDC63797
	for <linux-integrity@archiver.kernel.org>; Thu, 22 Jul 2021 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94D4611C1
	for <linux-integrity@archiver.kernel.org>; Thu, 22 Jul 2021 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGVQyO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3454 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhGVQyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:54:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzj64H8nz6D8Zq;
        Fri, 23 Jul 2021 01:19:54 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:34:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 3/7] Add additional options to the container engine
Date:   Thu, 22 Jul 2021 19:34:10 +0200
Message-ID: <20210722173414.1738041-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds additional options to the command line of the container
engine, necessary to run the UML kernel.

The additional options are: --cap-add=SYS_PTRACE -v /dev/shm:/dev/shm

The first adds the PTRACE capability to the container, and the second adds
a bind mount for /dev/shm.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .github/workflows/ci.yml | 1 +
 .travis.yml              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 4cfffbbd85f7..c3964a01cf3a 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -100,6 +100,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
+      options: --cap-add=SYS_PTRACE -v /dev/shm:/dev/shm
 
     environment:
       name: test
diff --git a/.travis.yml b/.travis.yml
index f3e3d93e1907..b26b57637914 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -114,4 +114,4 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
+    - $CONTAINER run $CONTAINER_ARGS --cap-add=SYS_PTRACE -v /dev/shm:/dev/shm -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
-- 
2.25.1

