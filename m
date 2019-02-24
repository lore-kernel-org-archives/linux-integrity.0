Return-Path: <SRS0=2pHC=Q7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAE1C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 09:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779A20661
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 09:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBXJd2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:33:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:16446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfBXJd2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Feb 2019 04:33:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 01:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="128903179"
Received: from cyucel-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.140])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2019 01:33:23 -0800
Date:   Sun, 24 Feb 2019 11:33:21 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190224093321.GA5353@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
 <20190222193305.GB6475@linux.intel.com>
 <20190222161636-mutt-send-email-mst@kernel.org>
 <20190222215001.GA21427@linux.intel.com>
 <f16bd565-0a7e-d7bb-a5e8-eda48ac8de80@gmail.com>
 <20190222223634.GA27601@linux.intel.com>
 <20190222180341-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222180341-mutt-send-email-mst@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 06:05:01PM -0500, Michael S. Tsirkin wrote:
> On Sat, Feb 23, 2019 at 12:36:34AM +0200, Jarkko Sakkinen wrote:
> > I do not require spec quality documentation. Just a few paragraphs of
> > what is in crosvm, kernel etc. and something about inner workings to
> > get a rough idea. No need for TCG level spec for this :-)
> 
> OTOH for virtio if there's no implementation in a popular
> hypervisor/language, we do ask for a somewhat detailed
> spec.

I don't really sure what you mean by that at all but for me a
sufficient would be something that describes the stack in few paragraphs
for virtio-TPM.

Could potentially be a patch for Documentation/tpm/.

/Jarkko
