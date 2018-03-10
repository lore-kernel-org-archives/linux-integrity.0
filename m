Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59140 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751043AbeCJWNs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Mar 2018 17:13:48 -0500
Message-ID: <1520720026.4495.11.camel@HansenPartnership.com>
Subject: [PATCH v3 0/6] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 10 Mar 2018 14:13:46 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

By now, everybody knows we have a problem with the TPM2_RS_PW easy
button on TPM2 in that transactions on the TPM bus can be intercepted
and altered.  The way to fix this is to use real sessions for HMAC
capabilities to ensure integrity and to use parameter and response
encryption to ensure confidentiality of the data flowing over the TPM
bus.

This patch series is about adding a simple API which can ensure the
above properties as a layered addition to the existing TPM handling
code.  This series now includes protections for PCR extend, getting
random numbers from the TPM and data sealing and unsealing.  It
therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
encryption protection to sensitive data flowing into and out of the
TPM.

This series is also dependent on additions to the crypto subsystem to
fix problems in the elliptic curve key handling and add the Cipher
FeedBack encryption scheme:

https://marc.info/?l=linux-crypto-vger&m=151994371015475

In the third version I've added data sealing and unsealing protection,
apart from one API based problem which means that the way trusted keys
were protected it's not currently possible to HMAC protect an authority
that comes with a policy, so the API will have to be extended to fix
that case

I've verified this using the test suite in the last patch on a VM
connected to a tpm2 emulator.  I also instrumented the emulator to make
sure the sensitive data was properly encrypted.

James

---

James Bottomley (6):
  tpm-buf: create new functions for handling TPM buffers
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm2: add hmac checks to tpm2_pcr_extend()
  tpm2: add session encryption protection to tpm2_get_random()
  trusted keys: Add session encryption protection to the seal/unseal path
  tpm2-sessions: NOT FOR COMMITTING add sessions testing

 drivers/char/tpm/Kconfig              |    3 +
 drivers/char/tpm/Makefile             |    3 +-
 drivers/char/tpm/tpm-buf.c            |  191 ++++++
 drivers/char/tpm/tpm-chip.c           |    1 +
 drivers/char/tpm/tpm.h                |  123 ++--
 drivers/char/tpm/tpm2-cmd.c           |  298 +++++----
 drivers/char/tpm/tpm2-sessions-test.c |  359 ++++++++++
 drivers/char/tpm/tpm2-sessions.c      | 1166 +++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h      |   57 ++
 9 files changed, 1993 insertions(+), 208 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

-- 
2.12.3
