Return-Path: <SRS0=Sidp=EF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCABC4741F
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Oct 2020 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED70520728
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Oct 2020 08:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJ3Iww (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 30 Oct 2020 04:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Iww (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 04:52:52 -0400
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BBF20704;
        Fri, 30 Oct 2020 08:51:59 +0000 (UTC)
Date:   Fri, 30 Oct 2020 10:51:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 0/3,RESEND] KEYS, trusted: a bunch of bug fixes
Message-ID: <20201030085155.GA52376@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.25.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set contains a bunch of disjoint bug fixes.

v4:
* Do not create stubs for tpm_transmit_cmd(), tpm_try_get_ops() and
  tpm_put_ops().
  https://lore.kernel.org/linux-integrity/20201013023927.GA71954@linux.intel.com/

v3:
* Reordered patches a bit, i.e. trivial fixes in the head and the least
  trivial in the tail.
  <no xref>
* Added the missing "return -ENODEV;" to tpm_transmit_cmd(), when the
  kernel is compiled without TPM support.
  https://lore.kernel.org/linux-integrity/202010110927.zsxMpek2-lkp@intel.com/

v2:
* Fix a kernel test bot warning.
  https://lore.kernel.org/linux-integrity/202010051152.9kxy43LO-lkp@intel.com/

Jarkko Sakkinen (3):
  KEYS: trusted: Fix incorrect handling of tpm_get_random()
  KEYS: trusted: Fix migratable=1 failing
  KEYS: trusted: Reserve TPM for seal and unseal operations

 drivers/char/tpm/tpm.h                    |  4 -
 include/linux/tpm.h                       |  5 +-
 security/keys/trusted-keys/trusted_tpm1.c | 94 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm2.c |  6 +-
 4 files changed, 75 insertions(+), 34 deletions(-)

-- 
2.25.1

