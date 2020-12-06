Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EFC433FE
	for <linux-integrity@archiver.kernel.org>; Sun,  6 Dec 2020 19:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745BE23107
	for <linux-integrity@archiver.kernel.org>; Sun,  6 Dec 2020 19:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgLFT3n (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFT3n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 14:29:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D0C0613D0;
        Sun,  6 Dec 2020 11:29:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607282941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZQJBUKdSm7qhXiIkkwFWbNpcU0Xq1O8cNhq+2evmiE=;
        b=IbGHUp/1hMNV93l5vjljjSUWY75j8BVopqgHCyrUaU185k7KWM2oqvogUhsKQlq6ctYwVy
        Zpzir1n+Pcrh6Xlj13FVXn8OHQ+UDR3AUkVXD3DuqqpWqsspTyizJFyZSwx1eWPDXLq49i
        xwKLOSZLwYK+NOVJuCL4GLJCGozpo+KjTuuO1m/jExShNJM9SwXmHz7wGR8mPXxu9sgFV8
        16A2O2rB+s+zLHPz77paylJX5nGRPdiOWIt38YJ7hc2aODTCguBd6cZ/aBE8uiU/w5P7CA
        0LFQ0Xf4sfqfJrZpelzGVF2aJ3P+Q6G6gKWM/123hl6I6tcK6pHeM25OMNUTrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607282941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZQJBUKdSm7qhXiIkkwFWbNpcU0Xq1O8cNhq+2evmiE=;
        b=AegeveRBXMBfxnkThNlcHmQFhlF4eBAmdAOQ8DJt7ZQI2Nnpi8XL+HHu0QV/JPYt9gegON
        TUMDS1B6Vtwr7bCw==
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
In-Reply-To: <7fe2d70b5daca57d9cd50d3877376e420658ed71.camel@HansenPartnership.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-2-jsnitsel@redhat.com> <20201205103954.GA17088@kernel.org> <87360i99ck.fsf@nanos.tec.linutronix.de> <7fe2d70b5daca57d9cd50d3877376e420658ed71.camel@HansenPartnership.com>
Date:   Sun, 06 Dec 2020 20:29:00 +0100
Message-ID: <87r1o27myr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 06 2020 at 09:40, James Bottomley wrote:
> On Sun, 2020-12-06 at 17:40 +0100, Thomas Gleixner wrote:
>> On Sat, Dec 05 2020 at 12:39, Jarkko Sakkinen wrote:
>> > On Fri, Dec 04, 2020 at 06:43:37PM -0700, Jerry Snitselaar wrote:
>> > > To try and detect potential interrupt storms that
>> > > have been occurring with tpm_tis devices it was suggested
>> > > to use kstat_irqs() to get the number of interrupts.
>> > > Since tpm_tis can be built as a module it needs kstat_irqs
>> > > exported.
>> > 
>> > I think you should also have a paragraph explicitly stating that
>> > i915_pmu.c contains a duplicate of kstat_irqs() because it is not
>> > exported as of today. It adds a lot more weight to this given that
>> > there is already existing mainline usage (kind of).
>> 
>> It's abusage and just the fact that it exists is not an argument by
>> itself.
>
> What we want is a count of the interrupts to see if we're having an
> interrupt storm from the TPM device (some seem to be wired to fire the
> interrupt even when there's no event to warrant it).  Since
> kstat_irqs_user() does the correct RCU locking, should we be using that
> instead?

If we need to export it, yes. But I still have to understand the
value. See my other reply.

Thanks,

        tglx
