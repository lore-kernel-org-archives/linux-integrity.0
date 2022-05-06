Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B7EC433F5
	for <linux-integrity@archiver.kernel.org>; Fri,  6 May 2022 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392498AbiEFWeX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 6 May 2022 18:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376814AbiEFWeW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 18:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27F1DA55;
        Fri,  6 May 2022 15:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98439B839E4;
        Fri,  6 May 2022 22:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA910C385A8;
        Fri,  6 May 2022 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651876234;
        bh=sxTU7PppLMUUauXKN/Szps48K3+Yp2KuJRpingZK3pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDBkPEfCg1pTGI8Srn8739MyPkk2qMvSwV5sgShyDnzwm2lTu+dc0YamxXpUd+wDB
         kQej8guNE45PJAKhANDPCD6M2I4/LJ6fWESpOBSJWaVip8jbACe5/ga4LBByuK1YpK
         AkA//mqxjAC19szynaJE4BOdiKcR5dJRdP20m/z89Xetfoy9/QHLLoGPEcA8dhdJRl
         QHnws7EP1tPtJMFxLJyPzZzlukTQpemzHiWMBmJH0EYpwV6nae3L38HZu1twa4HhPm
         2FYcfdXI14oxzvGIIlBpMyRbIBw8gIRil/yEq9nphSPTscJeQdv5AoP7tRldrWfj7x
         4IJ1vYhpVH4gA==
Date:   Sat, 7 May 2022 01:32:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 15/21] xen/tpmfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
Message-ID: <YnWh6P7kBtPa2aTA@kernel.org>
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-16-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505081640.17425-16-jgross@suse.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 05, 2022 at 10:16:34AM +0200, Juergen Gross wrote:
> Simplify tpmfront's ring creation and removal via xenbus_setup_ring()
> and xenbus_teardown_ring().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Please add to the commit message why these provide an equivalent
functionality.

BR, Jarkko
