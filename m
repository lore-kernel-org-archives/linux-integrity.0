Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51086 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750924AbeCCGE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Mar 2018 01:04:56 -0500
Message-ID: <1520057094.27452.16.camel@HansenPartnership.com>
Subject: [RFC 0/2] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Date: Fri, 02 Mar 2018 22:04:54 -0800
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

This RFC is about adding a simple API which can ensure the above
properties as a layered addition to the existing TPM handling code.
 Eventually we can add this to the random number generator, the PCR
extensions and the trusted key handling, but this all depends on the
conversion to tpm_buf which is not yet upstream, so I've constructed a
second patch which demonstrates the new API in a test module for those
who wish to play with it.

This series is also dependent on additions to the crypto subsystem to
fix problems in the elliptic curve key handling and add the Cipher
FeedBack encryption scheme:

https://marc.info/?l=linux-crypto-vger&m=151994371015475

---

James Bottomley (2):
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm2-sessions: NOT FOR COMMITTING add sessions testing

 drivers/char/tpm/Kconfig              |   3 +
 drivers/char/tpm/Makefile             |   3 +-
 drivers/char/tpm/tpm-chip.c           |   1 +
 drivers/char/tpm/tpm.h                |  22 +
 drivers/char/tpm/tpm2-cmd.c           |  22 +-
 drivers/char/tpm/tpm2-sessions-test.c | 178 +++++++
 drivers/char/tpm/tpm2-sessions.c      | 907 ++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h      |  55 +++
 drivers/char/tpm/tpm2b.h              |  82 +++
 9 files changed, 1260 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h
 create mode 100644 drivers/char/tpm/tpm2b.h

-- 
2.12.3
