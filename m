Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:38344 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdJTPme (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 11:42:34 -0400
From: Roberto Sassu <roberto.sassu@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/2] ima: preserve integrity of dynamic data
Date: Fri, 20 Oct 2017 17:41:36 +0200
Message-ID: <20171020154138.23635-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

One of the most challenging tasks for remote attestation is how to
handle the measurement of dynamic data (mutable files). When the default
policy is selected, IMA measures files accessed by root processes (TCB).

However, if a file was previously modified by another process, the digest
included in the new measurement list is unknown, and verifiers must assume,
during a remote attestation, that the system was compromised, because they
don't know if that file was written by a process in the TCB or not.

The goal of this patch set is to enforce an integrity policy on appraised
files, to avoid reporting measurements of dynamic data after they have been
modified. Only the initial state should be reported (e.g. the file
signature, or a digest list).

In order to properly enforce an integrity policy, it is necessary to
specify in the IMA policy process credentials rather than file attributes.

For example, the rule:

appraise fowner=0

could be replaced with:

appraise uid=0
appraise euid=0

This patch set has been developed on top of linux-integrity/next
(commit 9785a867) and https://patchwork.kernel.org/patch/10013185/
(ima: Store measurement after appraisal).

Roberto Sassu (2):
  ima: preserve the integrity of appraised files
  ima: don't measure files in the TCB if Biba strict policy is enforced

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 security/integrity/ima/ima.h                    | 23 ++++++++++
 security/integrity/ima/ima_appraise.c           | 61 +++++++++++++++++++++++++
 security/integrity/ima/ima_main.c               | 40 ++++++++++++----
 4 files changed, 118 insertions(+), 10 deletions(-)

-- 
2.11.0
