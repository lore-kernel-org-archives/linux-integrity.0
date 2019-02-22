Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F2C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8987120645
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 10:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfBVK0h (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:26:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:55765 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBVK0g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 05:26:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 02:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,399,1544515200"; 
   d="scan'208";a="301725171"
Received: from delmer-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2019 02:26:23 -0800
Date:   Fri, 22 Feb 2019 12:26:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Tolnay <dtolnay@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222102610.GB5613@linux.intel.com>
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
> Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> kernel side of TPM over virtio.
> 
> Use case: TPM support is needed for performing trusted work from within
> a virtual machine launched by Chrome OS.
> 
> Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> implementation of the virtio TPM device can be found in these two source
> files:
> 
> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs

These files/links do not make sense for kernel testing. Please remove
them from the next version.

> and is currently backed by the libtpm2 TPM simulator:
> 
> - https://chromium.googlesource.com/chromiumos/third_party/tpm2/
> 
> Reviewed-on: https://chromium-review.googlesource.com/1387655

A non-standard flag. Should be removed. Also

> Reviewed-by: Andrey Pronin <apronin@chromium.org>
> Tested-by: David Tolnay <dtolnay@gmail.com>
> Signed-off-by: David Tolnay <dtolnay@gmail.com>

Your SOB should first and you cannot peer test your own patches. Please
remove tested-by.

The whole thing looks like an early draft. Why the patch does not have
an RFC tag? You should use it for early drafts. Now it is like saying
"please merge this".

I don't have much knowledge of virtio. The commit message should at
least give rough overview what is meant by "kernel side" in this
context.

Since one cannot use standard Linux environment to test this I'm not too
optimistic about this getting merged any time soon. And since even the
commit message is broken I don't think it makes sense to review the code
in detail at this point.

/Jarkko
