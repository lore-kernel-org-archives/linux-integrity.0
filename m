Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7CC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAC2084D
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 09:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfBYJ4D (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:56:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:64983 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfBYJ4D (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 04:56:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 01:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="118856304"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2019 01:55:58 -0800
Date:   Mon, 25 Feb 2019 11:55:58 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Tolnay <dtolnay@gmail.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190225095558.GA3921@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com>
 <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com>
 <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com>
 <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 24, 2019 at 02:12:03PM -0800, David Tolnay wrote:
> We avoid implementing TIS or any other TPM-specific interface mechanism,
> and we avoid implementing ACPI or OF or PNP or I2C or any other
> additional bus necessitated by the existing set of Linux TPM drivers
> which we wouldn't otherwise need.
> 
> The virtio driver performs discovery via virtio, which crosvm implements
> already for all of its supported devices. This substantially reduces the
> amount of TPM-specific code compared to your suggestions, and lowers the
> barrier to entry for implementing TPM support in other hypervisors which
> I hope we agree is beneficial.

I don't necessarily because it adds to our codebase.

> Turning this around a different way, suppose that there already was a
> virtio TPM driver in the kernel. For me as a hypervisor implementer,
> what advantages do you see that would make me decide to implement
> TPM-specific virtual hardware emulation in the form of TIS rather than
> simply leveraging a virtio driver like for other virtual devices?

Well the way QEMU does it is already proven model. We don't need
anything new to kernel. You can take the ideas from there how to
implement the user space.

> QEMU dedicated to TIS. Without a virtio driver (or socsim, or something
> else that avoids TPM-specific hardware emulation for device discovery),
> QEMU and crosvm and other hypervisors need to reproduce a TIS
> implementation. Conceptually this is simple but it is still a quite
> substantial barrier compared to not needing any TPM-specific discovery.

If we are speaking about user space code, 1000+ lines is nothing. Adding
more complexity to the kernel is much more expensive .

/Jarkko
