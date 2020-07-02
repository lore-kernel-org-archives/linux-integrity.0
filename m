Return-Path: <SRS0=cpU6=AN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45963C433E0
	for <linux-integrity@archiver.kernel.org>; Thu,  2 Jul 2020 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1588220737
	for <linux-integrity@archiver.kernel.org>; Thu,  2 Jul 2020 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QJJ4Wkvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGBPf7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:35:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45206 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgGBPf7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 11:35:59 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD50720B717A;
        Thu,  2 Jul 2020 08:35:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD50720B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593704158;
        bh=JAZ9uFnGTR0/IdqAvUfcp9GdIzwUCl2MIfw/1Nrtl9k=;
        h=From:To:Cc:Subject:Date:From;
        b=QJJ4WkvwkeoDnR3rFs8FlXcL4g4tyjxTDTLL5+9qfM7iXGGlTAFBdadRSXKwDd0+b
         zJ8gY/vGBCd/XFfexA3spOnorLZFCBtWZwAosFOtme1b6jk9G6kGEQxFRmKb43Ugvy
         EOA+6Z2IviuZhWlXWZgn1RoJO2pPo27wkYgXkPSE=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH 0/2] Test cmdline measurement and IMA buffer passing through kexec
Date:   Thu,  2 Jul 2020 11:35:43 -0400
Message-Id: <20200702153545.3126-1-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset adds two tests that verify that data is passed correctly
through a kexec. Since the machine reboots several times when running these
tests, they must be run standalone and cannot be run with `runltp`.

The first test verifies that the kernel command line is measured correctly
when using kexec. The second test verifies that the IMA buffer is being
passed through kexec correctly.

Support for passing the IMA buffer through kexec has only been upstreamed
on powerpc so far, with a patchset in the process of being upstreamed for
support on arm64. Therefore, the only architectures that the tests
allow you to run them on (via `uname -m`) are ppc, ppc64, ppcle, ppc64le,
and aarch64.

The tests have been verified on ARM64. Would appreciate if
someone can execute the tests on a PowerPC machine and validate.

Lachlan Sneff (2):
  IMA: Verify that the kernel cmdline is passed and measured correctly
    through the kexec barrier.
  IMA: Verify IMA buffer passing through the kexec barrier

 testcases/kexec/README.md     | 30 ++++++++++++++
 testcases/kexec/cmdline.sh    | 78 +++++++++++++++++++++++++++++++++++
 testcases/kexec/ima_buffer.sh | 42 +++++++++++++++++++
 testcases/kexec/utils.sh      | 47 +++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 testcases/kexec/README.md
 create mode 100755 testcases/kexec/cmdline.sh
 create mode 100755 testcases/kexec/ima_buffer.sh
 create mode 100755 testcases/kexec/utils.sh

-- 
2.25.1

