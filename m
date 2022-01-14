Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9259BC433EF
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jan 2022 08:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiANIxN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Jan 2022 03:53:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49506 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiANIxM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 03:53:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15DD81F3BF;
        Fri, 14 Jan 2022 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642150391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8IHZ/Hky+no6jLGdjAJCDrjLZc5+zFZ1khnmnGZuMN8=;
        b=XWOMasDra8vtmEW5T/qHkXJFqZ/VKGeNDPA440PeSjOo7KvaPnV6D+0zBHWObdG3CuykYF
        84tr8GnebmZ8H9q7ggm5rBjWH7THpU+M66hwHXroFngoHIoA/hkySN5w710yaNDkeq10yu
        lToJ208E0sLloJ6bRkjxJngdDlksCOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642150391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8IHZ/Hky+no6jLGdjAJCDrjLZc5+zFZ1khnmnGZuMN8=;
        b=oj0ABhrhHbhJTd8wH+BNz+ZRs0+Nm5Q+PQIq+R/tDE8KLc/BU9ScZYoKSwR07XzrjdQIoD
        oi0pFvjZ3qW2mwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBD1713C16;
        Fri, 14 Jan 2022 08:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IXe4LvY54WFWfQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 08:53:10 +0000
Date:   Fri, 14 Jan 2022 09:53:09 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/1] ima_measurements.sh: Use /proc/uptime instead of date
Message-ID: <YeE59WLtUBP04i/r@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220112150123.13768-1-pvorel@suse.cz>
 <8f0d69607590096c1be5d7c4c2a3ece316100ca0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0d69607590096c1be5d7c4c2a3ece316100ca0.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Wed, 2022-01-12 at 16:01 +0100, Petr Vorel wrote:
> > It fixes more iterations (e.g. -i2) which is more precise.
> > date +%s could be used, but it's better use procfs file instead
> > requiring binary.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, Petr.

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks a lot for your review, merged.

Kind regards,
Petr

