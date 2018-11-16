Return-Path: <SRS0=flqU=N3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8EC43441
	for <linux-integrity@archiver.kernel.org>; Fri, 16 Nov 2018 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23E62087A
	for <linux-integrity@archiver.kernel.org>; Fri, 16 Nov 2018 11:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23E62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeKPV4R (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:56:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:39654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeKPV4Q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Nov 2018 16:56:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 03:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="86974997"
Received: from unknown (HELO localhost) ([10.249.254.90])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2018 03:44:14 -0800
Date:   Fri, 16 Nov 2018 13:44:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: TPM2 smoke tests
Message-ID: <20181116114412.GA7316@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

Now that I got into adding selftests [1] I started to think if I should
also move my TPM2 smoke tests as part of them.

The project resides here:

https://github.com/jsakkine-intel/tpm2-scripts

I wonder if selftests can be done with Python in the first place or do
they have to be implemented in C?

[1] https://lkml.org/lkml/2018/11/16/274

/Jarkko
