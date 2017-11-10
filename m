Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:56688 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbdKJU2a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 15:28:30 -0500
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] security/keys/trusted: Fine-tuning for two function
 implementations
Message-ID: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
Date: Fri, 10 Nov 2017 21:28:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 10 Nov 2017 21:21:12 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code in trusted_update()
  Use common error handling code in tpm_unseal()

 security/keys/trusted.c | 61 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

-- 
2.15.0
