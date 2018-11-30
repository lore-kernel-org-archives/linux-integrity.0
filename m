Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E554FC04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 23:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7C20867
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 23:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C7C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAKp7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:45:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:35265 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAKp6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 05:45:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 15:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="294873275"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2018 15:35:01 -0800
Date:   Fri, 30 Nov 2018 15:35:01 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Subject: TPM legacy
Message-ID: <20181130233501.GA32256@linux.intel.com>
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

Some things that came up at LSS.

First, would it be time to drop 1.1b bits? What advantages this would
bring? AFAIK Peter is a strong supporter of this.

In the hall way discussions, I talked with Tomas Winkler that it would
make sense to add CONFIG_TCG_TPM1 flag to completely leave out all TPM
1.x bits from the kernel.

TPM 1.x stuff is not exactly legacy but especially on IoT does not make
sense to carry that code with.

/Jarkko
