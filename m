Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:55078 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbdJSQMQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 12:12:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id a132so15735336oih.11
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 09:12:15 -0700 (PDT)
MIME-Version: 1.0
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 19 Oct 2017 19:12:14 +0300
Message-ID: <CACE9dm_EPadmV1iAqkQPYUsZXwp+G1zL5uYRLF+Etv7GTWmusA@mail.gmail.com>
Subject: RE: [PATCH 1/6] IMA: Allow EVM validation on appraisal even without a
 symmetric key
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

https://www.spinics.net/lists/linux-integrity/msg00036.html

Missed those because of ML switch..

Why is this needed?
This patch in upstream enables EVM when X509 is loaded


evm: enable EVM when X509 certificate is loaded

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=26ddabfe96bb7468763c9c92791404d991b16250



-- 
Thanks,
Dmitry
