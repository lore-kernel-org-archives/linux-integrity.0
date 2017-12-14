Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:53745 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdLNQXa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 11:23:30 -0500
From: <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>
CC: <shuahkh@osg.samsung.com>, <linux-integrity@vger.kernel.org>
Subject: TPM tests within kselftest?
Date: Thu, 14 Dec 2017 16:23:29 +0000
Message-ID: <0d71b9ee00a14b689896cac1dcbb6a12@infineon.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Jarkko,

during the Kernel Summit in Prague I talked with Shuah Khan about kselftest and the possibility to integrate TPM tests into that framework. What would you think about your tests (https://github.com/jsakkine-intel/tpm2-scripts) living there?

This way, those tests would get more visibility/popularity with other developers, and thus hopefully more contributors that can use that framework as a starting point. It also allows us to have a common test set, that all TPM developers can easily use for their work. And the tests being integrated into the kernel repository would avoid issues like I had just now, where your new test for invalid command codes failed when I tried to run it on an older kernel that did not have that functionality implemented.

Currently, most tests within kselftest are not implemented in Python, but Shuah did not sound strictly opposed to that idea. In fact, some Python-based tests already have made it into the tree (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/tc-testing), though they do not seem to be called by kselftest by default.

Alexander
