Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdJTTTW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 15:19:22 -0400
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        james.l.morris@oracle.com, dmitry.kasatkin@gmail.com,
        zohar@linux.vnet.ibm.com, rusty@rustcorp.com.au, jeyu@kernel.org
Subject: [PATCH 0/2] ima: change how MODULE_SIG_FORCE is checked on modules checking policy
Date: Fri, 20 Oct 2017 17:19:14 -0200
Message-Id: <cover.1508524595.git.brdeoliv@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patchset ensure that IMA's modules checking policy:

    measure func=MODULE_CHECK uid=0

rely on the correct value of CONFIG_MODULE_SIG_FORCE, since the way it
is today the code completely ignores the module.sig_enforce cmdline
param, which behaves in a OR logic with the CONFIG value
(CONFIG_MODULE_SIG_FORCE || module.sig_enforce). That said, everytime a
module would load, in the current checking code, when the kernel was not
compiled with the CONFIG set the call to init_module syscall fails with
-EACCES:

# strace -f -v modprobe <any-module> | grep init_module
init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)

With this patchset the result would rely on the module.sig_enforce
cmdline as well. Once the CONFIG is not set, but the param is, the
result would be 'success', as it should be:

# strace -f -v modprobe <any-module> | grep init_module
init_module(0x7f9602d6e010, 386646, "") = 0

The patchset was tested in two different kernels: 4.13.6 (Fedora 27) and
4.14.0-rc4 (integrity-next tree)

Bruno E. O. Meneguele (2):
  module: export module signature enforcement status
  ima: check signature enforcement against cmdline param instead of
    CONFIG

 include/linux/module.h            | 2 ++
 kernel/module.c                   | 8 ++++++++
 security/integrity/ima/ima_main.c | 6 +++---
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.13.6
