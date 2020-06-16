Return-Path: <SRS0=e4Xp=75=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EAC433E0
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Jun 2020 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C22207DD
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Jun 2020 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgFPVBA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:01:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:17730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFPVBA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 17:01:00 -0400
IronPort-SDR: zkJ0qJLzRmr9QQ0hOH4P2EuZQgAMMkklrU80qBWaYqhFiIKyvSKzbuCNXj7AQ46aF6BNDXiwTW
 wE3qTYkxBMzw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 14:00:46 -0700
IronPort-SDR: ZNtT++dSMEor+er3gRpqWxM5x/MdJaM1ex1g8yn/j6E/tI2fAp3OfcQQl7BfQlCI/IYAfXtZQq
 GBA6IQFPzOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="309251190"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2020 14:00:44 -0700
Date:   Wed, 17 Jun 2020 00:00:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Binbin Zhou <zhoubinbin@uniontech.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        christophe.ricard@gmail.com, zhoubb.aaron@gmail.com
Subject: Re: [PATCH] tpm/st33zp24: fix spelling mistake "drescription" ->
 "description"
Message-ID: <20200616210042.GH20943@linux.intel.com>
References: <20200605033415.8586-1-zhoubinbin@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605033415.8586-1-zhoubinbin@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 05, 2020 at 11:34:15AM +0800, Binbin Zhou wrote:
> Trivial fix, the spelling of "drescription" is incorrect in function comment.
> Fix this.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
