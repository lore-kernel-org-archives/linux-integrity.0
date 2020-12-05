Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D52C433FE
	for <linux-integrity@archiver.kernel.org>; Sat,  5 Dec 2020 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4B722DFA
	for <linux-integrity@archiver.kernel.org>; Sat,  5 Dec 2020 12:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgLEKl6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 5 Dec 2020 05:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbgLEKkr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 05:40:47 -0500
Date:   Sat, 5 Dec 2020 12:39:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607164801;
        bh=ya75zup16uvciko51cfo9cxYRN4wjQt4zz/di3M+HUc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxcHQBhbkXZmRYCTdX6D6sLKNGhthkg1RD/jj+nsJCoMq5D9vhBnQhpqITLSzPOFR
         6P16fGAsvC9mpyjb0d0uN1zi4UWn8aC6SPqONPHj0jvFDTDCLmlNPWSNSVqcz2chXe
         goJtuoMtBKAFRl7UgS1AqAh6haemykgGvkPApdgbz19JYKIiZuin7eBGAp+T2/UtQn
         xwPQb0b4/SsSRCwX6Adm5E0Le004HEZGFwGdoGHfsRQigIUdh2D4hsLR3qBa9NB0Nm
         YyyD3AuUKNfzu78kkGpgX3+PD3bJ81vxFE2/fCLKqXbPsL8jtaLMBF2rvVs0Gd9yQ6
         ruN5KUVa+XHOg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
Message-ID: <20201205103954.GA17088@kernel.org>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-2-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205014340.148235-2-jsnitsel@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 06:43:37PM -0700, Jerry Snitselaar wrote:
> To try and detect potential interrupt storms that
> have been occurring with tpm_tis devices it was suggested
> to use kstat_irqs() to get the number of interrupts.
> Since tpm_tis can be built as a module it needs kstat_irqs
> exported.

I think you should also have a paragraph explicitly stating that
i915_pmu.c contains a duplicate of kstat_irqs() because it is not
exported as of today. It adds a lot more weight to this given that
there is already existing mainline usage (kind of).

> 
> Reported-by: kernel test robot <lkp@intel.com>

I'm not sure if this makes much sense.

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

/Jarkko
