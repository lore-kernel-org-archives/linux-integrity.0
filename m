Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbeCVOnu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 10:43:50 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v2 0/2] ima: Fallback to the builtin hash algorithm
Date: Thu, 22 Mar 2018 15:43:11 +0100
Message-Id: <20180322144313.28748-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Mimi,

Changes v1->v2:
* Move loading buildin hash algorithm to ima_init_crypto() (as requested)
* Add crypto_alloc_shash() (DRY)

[1]:
> The first call to ima_init() emits an error, but we continue without
> any further messages.  If the change was in ima_init_crypto(), the
> error message could indicate the resolution.
I cannot say I like v2 as change in ima_init_crypto() requires more
changes due updating ima_hash_algo. IMHO v1 with added simple error
message would be better.  I probably didn't understand what exactly you
wanted to log in ima_init_crypto(). Am I missing something?

If you like this version, you may want to squash it into single commit.

Kind regards,
Petr

[1]: https://marc.info/?l=linux-integrity&m=152155002608419&w=2

Petr Vorel (2):
  ima: Introduce ima_alloc_alg() to reduce duplicity
  ima: Fallback to the builtin hash algorithm

 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 58 +++++++++++++++++++++++++++----------
 security/integrity/ima/ima_main.c   | 26 ++---------------
 3 files changed, 47 insertions(+), 38 deletions(-)

-- 
2.12.3
