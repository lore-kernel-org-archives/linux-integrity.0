Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933891AbeFLAUO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jun 2018 20:20:14 -0400
Subject: [PATCH v2 0/2] tpm: add support for nonblocking operation
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 11 Jun 2018 17:20:14 -0700
Message-ID: <152876281395.19591.3681365717212126222.stgit@tstruk-mobl1.jf.intel.com>
In-Reply-To: <20180601171731.GF1408@ziepe.ca>
References: <20180601171731.GF1408@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The TCG SAPI specification [1] defines a set of functions, which allows
applications to use the TPM device in either blocking or non-blocking fashion.
Each command defined by the specification has a corresponding
Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
mode of operation. Currently the TPM driver supports only blocking calls,
which doesn't allow asynchronous IO operations.
This patch changes it and adds support for nonblocking write and a new poll
function to enable applications, which want to take advantage of this feature.
The new functionality can be tested using standard TPM tools implemented
in [2], together with modified TCTI from [3].

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
[2] https://github.com/tpm2-software/tpm2-tools
[3] https://github.com/tstruk/tpm2-tss/tree/async

---
Changes in v2:
- Split the change into two separate patches. First patch adds a pointer
  to the space to the struct file_priv to have access to it from the async job.
  This is to avoid memory allocations on every write call. Now everything
  what's needed is in the file_priv struct.
- Renamed the 'work' member of the timer to avoid confusion.
  Now there are 'timeout_work' and 'async_work'.
- Removed the global wait queue and moved it to file_priv.
- Only creating the work queue when the first file is opened.

Tadeusz Struk (2):
      tpm: add ptr to the tpm_space struct to file_priv
      tpm: add support for nonblocking operation

 drivers/char/tpm/tpm-dev-common.c |  152 ++++++++++++++++++++++++++++---------
 drivers/char/tpm/tpm-dev.c        |   22 +++--
 drivers/char/tpm/tpm-dev.h        |   19 +++--
 drivers/char/tpm/tpmrm-dev.c      |   31 ++++----
 4 files changed, 152 insertions(+), 72 deletions(-)

--
TS
