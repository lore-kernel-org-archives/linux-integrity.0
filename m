Return-Path: <SRS0=ghDQ=BN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553FC433E0
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Aug 2020 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3F22B45
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Aug 2020 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IvwkEq1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgHCR7m (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:59:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57976 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgHCR7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 13:59:41 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id E49EB20B4908;
        Mon,  3 Aug 2020 10:59:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E49EB20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596477580;
        bh=c6g4N5GTfq2Sy3Ud3da7Wg3nyPStYNaPqXbluSJ6JCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=IvwkEq1yI66MJikOn5ZfDdQPFUCdl/4ryPFhv1OyY4X6TBM9vNOjev9Q40KgOUyVr
         obc7k8cQQ7q0qnHi4tqtV3eZVIWNY6F+Jr6Et9G8hRzWf/3xNBnIvrHmOrXZKjNdsc
         cA1Cb3KiE3KQBeJBhh10a6TRlzSc8zejHga+6/68=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tytyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: [PATCH v1 0/3] Verify measurement of certificate imported into a keyring
Date:   Mon,  3 Aug 2020 13:59:01 -0400
Message-Id: <20200803175904.40269-1-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA subsystem supports measuring certificates that have been loaded into
user-defined keyrings and system built-in keyrings. A test to verify that
those measurements are correct is required.

The first two patches in this patchset fix up left-over documentation and
move some datafiles around to prepare for more datafiles in the 3rd patch.

The third patch adds a new test to the `ima_keys.sh` file, which imports
a certificate into a user-defined keyring, and then verifies that the
certificate has been measured correctly by the IMA subsystem.

Lachlan Sneff (3):
  IMA: Update key test documentation
  IMA: Refactor datafiles directory
  IMA: Add a test to verify measurement of certificate imported into a
    keyring

 .../kernel/security/integrity/ima/README.md   |  32 +++++++------
 .../security/integrity/ima/datafiles/Makefile |   6 +--
 .../integrity/ima/datafiles/keys/Makefile     |  15 ++++++
 .../integrity/ima/datafiles/keys/x509_ima.der | Bin 0 -> 650 bytes
 .../integrity/ima/datafiles/policy/Makefile   |  15 ++++++
 .../ima/datafiles/{ => policy}/kexec.policy   |   0
 .../datafiles/{ => policy}/keycheck.policy    |   0
 .../ima/datafiles/{ => policy}/measure.policy |   0
 .../{ => policy}/measure.policy-invalid       |   0
 .../security/integrity/ima/tests/ima_keys.sh  |  44 +++++++++++++++++-
 10 files changed, 91 insertions(+), 21 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/x509_ima.der
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/kexec.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/keycheck.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy-invalid (100%)

-- 
2.25.1

