Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA224C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD31206BB
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBVVa3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:30:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:32218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfBVVa3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:30:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 13:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,401,1544515200"; 
   d="scan'208";a="149237188"
Received: from delmer-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2019 13:30:22 -0800
Date:   Fri, 22 Feb 2019 23:30:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222213022.GA17945@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
 <20190222154838-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222154838-mutt-send-email-mst@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 03:55:33PM -0500, Michael S. Tsirkin wrote:
> Jarkko, I am not making any argument at all.
> 
> I am trying to suggest ways for this driver to get upstream.
> 
> And I am saying that while I agree availability of an implementation in
> crosvm isn't sufficient, availability of a software device
> implementation in QEMU is not an absolute prerequisite for including a
> virtio driver in Linux.  If there's a virtio spec explaining how to
> write one, that can be enough.

QEMU is definitely not absolute requirement for anything but I could not
find crosvm in easily distributed form for any major distribution.

The only reason for favoring QEMU is that I can actually install it
without hustle. I have no idea how to get crosvm up and running.

/Jarkko
