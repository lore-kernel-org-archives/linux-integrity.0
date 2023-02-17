Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A44C636D6
	for <linux-integrity@archiver.kernel.org>; Fri, 17 Feb 2023 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBQW1l (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQW1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 17:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B7212B1;
        Fri, 17 Feb 2023 14:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 342CDB82E73;
        Fri, 17 Feb 2023 22:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58766C433D2;
        Fri, 17 Feb 2023 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676672857;
        bh=DT/RoKeTdPukecQKfNwn1QV5W22xlN7aTcZ4wYMF9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DU9GuZvlMtukswzFQX9zVcwXR8PVTz5IpXXnD+DQ5MGWgtiWSFhCkdmW/K9iFKg46
         nL55T9feCCUYCv37y5u4jCOX2fXI6LCqXvWoxKU5KPiB0ymIy3xsmoxMAaOfniWZKn
         cApq1zZPX8HPdy2jbFRva0dhUguc4cCntG7tDnRU+c2TGD4IC3yby0HGdbpmcxZgho
         0DCGfRQdrnVMXIX2XJ2HIum/rfS2zsVoUDrPByFfIyzoD9WIE6fUonvkftEYhtH70P
         Kwu49AhG9S+e6hqzjLlX/KNdsV8afaPjaDI5MaWzjcw6wySAaLgMTviLMdk3y1f7ij
         ClQWYo6B7Oztg==
Date:   Sat, 18 Feb 2023 00:27:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Erkki Eilonen <erkki@bearmetal.eu>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, morten@linderud.pw, peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <Y+//Vf7hK2ZCHj19@kernel.org>
References: <YzyyZ6AFAgTRG5G5@kernel.org>
 <20230214215220.1190357-1-erkki@bearmetal.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214215220.1190357-1-erkki@bearmetal.eu>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 14, 2023 at 11:52:20PM +0200, Erkki Eilonen wrote:
> > Does the bug fix work for you? If you can give tested-by for it, then that
> > ofc changes everything.
> 
> Apologies for the delayed response.
> 
> Previously we had a similar but not quite the same patch being used, now I've tested this specific patch.
> 
> Tested-By: Erkki Eilonen <erkki@bearmetal.eu>
>   kernel: 5.10.121
>   Device: QuantaGrid D53X-1U
>   BIOS:
>     Vendor: INSYDE Corp.
>     Version: 3A16.Q402
>     Release_Date: 11/10/2021
> 
> Cheers,
> Erkki Eilonen

Thanks!

BR, Jarkko
