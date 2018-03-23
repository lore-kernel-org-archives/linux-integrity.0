Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbeCWJdQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Mar 2018 05:33:16 -0400
Date: Fri, 23 Mar 2018 11:33:12 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: jmorris@namei.org
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for Linux 4.17
Message-ID: <20180323093312.GA21411@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James

This release contains only bug fixes. There are no new major features
added.

/Jarkko

The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180323

for you to fetch changes up to 2be8ffed093b91536d52b5cd2c99b52f605c9ba6:

  tpm: fix intermittent failure with self tests (2018-03-23 10:25:09 +0200)

----------------------------------------------------------------
tpmdd updates for Linux 4.17

----------------------------------------------------------------
Chris Chiu (1):
      tpm: self test failure should not cause suspend to fail

James Bottomley (2):
      tpm: add retry logic
      tpm: fix intermittent failure with self tests

Tomas Winkler (3):
      tpm: cmd_ready command can be issued only after granting locality
      tpm_crb: use __le64 annotated variable for response buffer address
      tpm2: add longer timeouts for creation commands.

Winkler, Tomas (2):
      tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
      tpm: fix buffer type in tpm_transmit_cmd

 drivers/char/tpm/tpm-interface.c | 158 +++++++++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  32 +++++---
 drivers/char/tpm/tpm2-cmd.c      |  62 ++++++---------
 drivers/char/tpm/tpm_crb.c       | 113 +++++++++++++++++++---------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 6 files changed, 250 insertions(+), 121 deletions(-)
