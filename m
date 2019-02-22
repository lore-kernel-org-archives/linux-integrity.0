Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81633C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A2320823
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBVKbO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:31:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:20636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfBVKbO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 05:31:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 02:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,399,1544515200"; 
   d="scan'208";a="128507243"
Received: from delmer-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2019 02:31:01 -0800
Date:   Fri, 22 Feb 2019 12:30:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Tolnay <dtolnay@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222103059.GC5613@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> +MODULE_AUTHOR("David Tolnay (dtolnay@gmail.com)");

Off-topic: but started to think is this field still required for
LKM's. GIT log is the only non-flakky way to describe authority.

Not related to this code review but feels just a misguiding thing
to have.

/Jarkko
