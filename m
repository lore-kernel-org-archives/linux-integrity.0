Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9FC74A5B
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Mar 2023 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCUIBP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUIBN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Mar 2023 04:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0137B53;
        Tue, 21 Mar 2023 01:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7A061A14;
        Tue, 21 Mar 2023 08:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813F6C433D2;
        Tue, 21 Mar 2023 08:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679385671;
        bh=YImeYXATTh7KJJItSyWvW1mvVveYbjMWmafKn9kx8a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEZgN3m9EnJIxXbN8l2mm1MUhMK6hRfmgevcwWpoBA4Fb2CZP7kHbxxznbtXfI+NA
         81NX5FOIZFts6lZQxNMdIhScywDw6B4mYm0ifz58dMS1ORDoSBp423aXuZANRKTuHd
         HtubPoAHqe3bkjxGLkCYQVPWYa3B4CAKXFSgADU0=
Date:   Tue, 21 Mar 2023 09:01:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] tpm: Fix a possible dereference of ERR_PTR in
 tpm_init()
Message-ID: <ZBlkRCWAJXWkTQI2@kroah.com>
References: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 11:14:15PM -0700, Harshit Mogalapalli wrote:
> Smatch reports:
> 	drivers/char/tpm/tpm-interface.c:470 tpm_init() error:
> 	'tpm_class' dereferencing possible ERR_PTR()
> 
> If class_create() returns error pointer, we are dereferencing a possible
> error pointer. Fix this by moving the dereference post error handling.
> 
> Fixes: a010eb881243 ("tpm: fix up the tpm_class shutdown_pre pointer when created")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, only compile tested.

Thanks for this, good catch, I've queued it up in my tree now as I have
the offending change that caused this.

greg k-h
