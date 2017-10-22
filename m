Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:62718 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbdJVL21 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Oct 2017 07:28:27 -0400
To: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Xen vTPM frontend: Fine-tuning for vtpm_send()
Message-ID: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Date: Sun, 22 Oct 2017 13:28:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Oct 2017 13:23:45 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Combine two condition checks into one statement

 drivers/char/tpm/xen-tpmfront.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.14.2
