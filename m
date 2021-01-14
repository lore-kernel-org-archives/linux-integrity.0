Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6408C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Jan 2021 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AB423406
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Jan 2021 02:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhANCwT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbhANCwM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:52:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08D5235FF;
        Thu, 14 Jan 2021 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610592692;
        bh=kA9yXXpdDPjKVxfq3CqRKkEzJJlAEd43QeCIiR9fR4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tt9GZfIfGlQnWcVcwsCJLfnGfb4UxiZbUl/tNF0YLHnTCEKKlujGIvZyAadpASTw+
         rYUTlNF7QehedC0VxcQ1AQx90WJb4sdMhiPLCq/wQF+ig3Bppt3T5EEQFNk5cBbyJS
         DF0t3E4I/hgKwycox366VECqRrXjlyMnohf+6Xg4Lik7Rq6ox4EDMD3khlHxXRK0GU
         H0NwpUW3L83hKnfBDb7GuGQemViJEiBvsmU+Nk6ahcJgspGayYpHBKiOILOZdshtUG
         yunuWEvBtiK/5fd1osL87KQjPXKZHHtg+gF9AoMNWxtTnYkx1d6MsXMhCOmUTTIFOl
         K7FoO0v9ByL6Q==
Date:   Thu, 14 Jan 2021 04:51:27 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] tpm/tpm_tis: Fix variable reset during IRQ probing
Message-ID: <X/+xr/L+m2k5fObZ@kernel.org>
References: <20210113120021.59045-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113120021.59045-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 08:00:21PM +0800, Tianjia Zhang wrote:
> In tpm_tis_core_init(), tpm2_probe() will be called first, this
> function will eventually call tpm_tis_send(), and then
> tpm_tis_probe_irq_single() will detect whether the interrupt is
> normal, mainly the installation interrupted, set `priv->irq_tested`
> to false. The logic will eventually be executed to tpm_tis_send()
> to trigger an interrupt.
> 
> There is currently such a scenario, which will cause the IRQ probe
> code to never be executed, so that the TPM device is in polling
> mode: after setting irq_tested to false, an interrupt occurs
> between entering the ttpm_tis_send() function, and the interrupt
> will be first set irq_tested to true will cause the IRQ probe code
> to never be executed.

Can you describe the scenario more detail?

> It seems that this interrupt comes from tpm2_probe(). Although the
> interrupt has not been installed when tpm2_probe() is called, the
> interrupt of tpm2_probe() is only received after IRQ detection.
> 
> This patch solves this issue by introducing a new variable, which
> is only used in interrupts, and irq_tested only marks whether the
> interrupt test has been completed.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---

I'm not sure I understand this patch. TPM should be in polling
mode. This is also assumption before calling tpm_get_timeouts():

/* Before doing irq testing issue a command to the TPM in polling mode
 * to make sure it works. May as well use that command to set the
 * proper timeouts for the driver.
 */
if (tpm_get_timeouts(chip)) {
        dev_err(dev, "Could not get TPM timeouts and durations\n");
        rc = -ENODEV;
        goto out_err;
}

/Jarkko
