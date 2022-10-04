Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D757C433F5
	for <linux-integrity@archiver.kernel.org>; Tue,  4 Oct 2022 22:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJDWE1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJDWE0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 18:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C19558EB;
        Tue,  4 Oct 2022 15:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB3F614A7;
        Tue,  4 Oct 2022 22:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCF5C433C1;
        Tue,  4 Oct 2022 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664921064;
        bh=K6MSXesUBRkQT1JBME2CxSTln3XxX+D3uM4eCblrckM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eytRLa+gwVd863I0cWHTRxgulo8xfq5pq9xEqFxGYL8ulTkoiECivILY9z3Mj9Hz8
         aa7W+cJLxJPVW2Zxce9FSQc0/I8rgZoyFbYxu3yeJnNNTRag1l73Z9cRHFiFwjiBzL
         DkyERQ04BBpy7oLtZKZ4rRz+5OxSFROqbfJW12NunQWf3bA4V8fmxQCPCcz62moKqA
         AnYYuxmjv6D5DxdaqB2oxJnQOY0fnhg1FPXimyMeYbon/adGoppoBnbD89kb6WGZr9
         TZfuo/SH00MmfY4IFOt9AXN050AUJ2cB8Y/03Vgk4cQUmxs1R9Dwm6BBb0QKuIZrfQ
         PughiWLine1ug==
Date:   Wed, 5 Oct 2022 01:04:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tpm: st33zp24: drop support for platform data
Message-ID: <Yzyt5O4p5J/Y6vWZ@kernel.org>
References: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 10:51:40PM -0700, Dmitry Torokhov wrote:
> Drop support for platform data from the driver because there are no
> users of st33zp24_platform_data structure in the mainline kernel.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
