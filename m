Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C62C433EF
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Apr 2022 12:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiDNMQ4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiDNMQ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 08:16:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76653881;
        Thu, 14 Apr 2022 05:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA44B82934;
        Thu, 14 Apr 2022 12:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23C5C385A1;
        Thu, 14 Apr 2022 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938468;
        bh=/lJMbuqCUvWBZpDnchq4yA5y4o3tnZsGQzcMlBudlhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhIklwqG0vK08DiwAvIq46xKLUt/JvMV2fvNoRox7yLjyIuBlgwssXE0jQyTaduf4
         Fj1e02mps6gNkaGfUaj6v6PTuxnFMAMwKHAbjPKt/VLqfruZ7oE+jWVgGRnwbXpShI
         Er/kXcujqDv91ZI+JRntMtLeZs9O8AJ9oz7sObp8FOZQlwldfJB6UvKiS0YuDf2SuH
         G7l84ppQyR0cUJQTn2PipFZABkvqO0PJbcumc01QZDk28aybHtHipO6xZxUPSyPP4i
         SDplQYQAFZdiFIEQsMO6jQaW05ZjpLSZPQJBYZQrL5HWN9CwvWJUa4ZhKHP2dGSTqw
         3fnzX95jTG8LA==
Date:   Thu, 14 Apr 2022 15:13:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/5] tpm: add functions to set and unset the tpm chips
 reset state
Message-ID: <YlgPxX3xCPUyR2F6@kernel.org>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-2-LinoSanfilippo@gmx.de>
 <20220407142526.GW64706@ziepe.ca>
 <20220410171123.GA24453@wunner.de>
 <20220411114741.GA64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411114741.GA64706@ziepe.ca>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 11, 2022 at 08:47:41AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 10, 2022 at 07:11:23PM +0200, Lukas Wunner wrote:
> > On Thu, Apr 07, 2022 at 11:25:26AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 07, 2022 at 01:18:45PM +0200, Lino Sanfilippo wrote:
> > > > Currently it is not possible to set the tpm chips reset state from within
> > > > the driver. This is problematic if the chip is still in reset after the
> > > > system comes up. This may e.g. happen if the reset line is pulled into
> > > > reset state by a pin configuration in the device tree.
> > > 
> > > This kind of system is badly misdesigned.
> > > 
> > > TPM PCRs fundementally cannot work if the TPM reset line is under
> > > software control.
> > 
> > Not every system which incorporates a TPM wants to use or is even capable
> > of measuring software state of any kind or perform secure boot.
> > 
> > Those systems may merely want to use the TPM to store key material.
> 
> Then maybe the TPM driver should make it clear somehow that the PCRs
> don't work in these systems.
> 
> It is really dangerous to add capabilities like this that should
> never, ever be used in sanely designed systems.
> 
> Jason

I agree. That niche should do the bad things with oot patches.

BR, Jarkko
