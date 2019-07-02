Return-Path: <SRS0=5qpg=U7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9EC06510
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Jul 2019 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885F221721
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Jul 2019 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBSh4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:37:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:39715 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBSh4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 14:37:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 11:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,444,1557212400"; 
   d="scan'208";a="186968792"
Received: from bholthau-mobl.ger.corp.intel.com ([10.252.35.32])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2019 11:37:51 -0700
Message-ID: <a8fc7162019168ab3b9b662fb629855205a6b1ca.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Fix null pointer dereference on chip register
 error path
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Milan Broz <gmazyland@gmail.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>
Date:   Tue, 02 Jul 2019 21:37:51 +0300
In-Reply-To: <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
References: <20190612084210.13562-1-gmazyland@gmail.com>
         <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-28 at 09:56 +0200, Milan Broz wrote:
> Hi,
> 
> is there any problem in this with the trivial patch below?
> 
> I just get the same crash again with stable 5.1 kernel...
> 
> Milan

I'm sorry but I'm seeing this patch for the first time.

/Jarkko

