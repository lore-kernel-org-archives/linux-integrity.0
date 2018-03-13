Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27928 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbeCMRmo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 13:42:44 -0400
Date: Wed, 14 Mar 2018 01:42:24 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: kbuild-all@01.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] evm: evm_hmac can be static
Message-ID: <20180313174224.GA28779@intel17>
References: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Fixes: c49fc264be98 ("evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 evm_crypto.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index fdde9cb..a46fba3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -37,8 +37,8 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
-char * const evm_hmac = "hmac(sha1)";
-char * const evm_hash = "sha1";
+static char * const evm_hmac = "hmac(sha1)";
+static char * const evm_hash = "sha1";
 
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
