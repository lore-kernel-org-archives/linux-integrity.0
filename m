Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B7C4361B
	for <linux-integrity@archiver.kernel.org>; Sun,  6 Dec 2020 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1F23358
	for <linux-integrity@archiver.kernel.org>; Sun,  6 Dec 2020 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgLFRz1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 6 Dec 2020 12:55:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRz0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 12:55:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607277285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07War4FnpacwFh1YaF/5joszhDH3pMW7WlC56is9w4I=;
        b=q1LwrbiDzWFlcihybyILl6urNUUlW3xoBHDW2gCbvkfnkEPMrsJZsZxh/u3wITbzLbrzsP
        muFiLKraQSlM6tmzlPpbkAra17ztgm20WOUD8w3h4bcn5gRFbnzKyPIjnEPubhplt2u4fx
        9Q+sEZJLg4KDNIj8Dwm+rrY7hUHRnJEu8dHN0lJLxPoLarEd6FJ3y0rzv7EllFhJCToaJU
        te848un/yV8u6K3ZeXL94SlrBnMb4v53QoV3v0yVtOJ2XNMOIo17w+IjymH+AeTP7kjaWJ
        9lO2rzwwoGDJAkNSoSmcP98uT/dNDppnGFTEHkThFMH5lzXPtOdoIT5Asm8Cjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607277285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07War4FnpacwFh1YaF/5joszhDH3pMW7WlC56is9w4I=;
        b=yKxLEMiFuaSYO1WtTlFlvn2N71he2D9R3O/UuYqLb68HVEC9MGqjskvFkXhbXCAC/YUhO3
        Ya9c1fGGjdMVKDCA==
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
In-Reply-To: <20201205014340.148235-2-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-2-jsnitsel@redhat.com>
Date:   Sun, 06 Dec 2020 18:54:44 +0100
Message-ID: <87y2ia7rbv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jerry,

On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:

The proper prefix is 'genirq:' git log kernel/irq/irqdesc.c would have
told you. 

> To try and detect potential interrupt storms that
> have been occurring with tpm_tis devices it was suggested
> to use kstat_irqs() to get the number of interrupts.
> Since tpm_tis can be built as a module it needs kstat_irqs
> exported.

I'm not really enthused about exporting this without making it at least
safe. Using it from an interrupt handler is obviously safe vs. concurrent
removal, but the next driver writer who thinks this is cool is going to
get it wrong for sure.

Though I still have to figure out what the advantage of invoking a
function which needs to do a radix tree lookup over a device local
counter is just to keep track of this.

I'll reply on the TPM part of this as well.

Thanks,

        tglx
