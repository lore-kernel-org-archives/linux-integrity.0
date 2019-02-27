Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8510BC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575652184A
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfB0P4P (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:56:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:21671 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0P4P (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 10:56:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 07:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="142101533"
Received: from hansenmi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.190])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2019 07:56:13 -0800
Date:   Wed, 27 Feb 2019 17:56:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Subject: About PureBoot and TPM based DRM's
Message-ID: <20190227155611.GA7434@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Just read this:

https://puri.sm/posts/pureboot-the-high-security-boot-process/

Makes me ask: where are these TPM based DRM's? Never seen one but I
assume they exist. Anyway cool work otherwise.

/Jarkko
