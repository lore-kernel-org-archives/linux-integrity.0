Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C6C433F5
	for <linux-integrity@archiver.kernel.org>; Tue,  4 Oct 2022 22:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJDWkQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJDWkQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 18:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8F178B8;
        Tue,  4 Oct 2022 15:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3576154C;
        Tue,  4 Oct 2022 22:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DEEC433C1;
        Tue,  4 Oct 2022 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664923213;
        bh=TXHtvV5ZQ2yOBrkGMupsXGD6dQvin7zUfarcovd376o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L353apU/nFR1/ERWRCpu0dvvqc1yvNaUh5SsUtR7MI6HCMeJn4zlANB5G/x9RJU1H
         vLtHq6LfQZui8FjDf2wJtYBVmZWTBtAnzEGhOnGV0Cg3PFixK/OsuuFFwlQPvLwqP4
         PQdFemZ337m4iNEELiul/hb2Ypde86yxy9ipVehuS0xGn+feXHxxr7fjjXYHpzk/7B
         +SWRiDa3OtDe/a907sHotDhswtlLDgYw47jbELPtcburoiEysfRFm0XHe30mIh6YNU
         t/6LFjk5TwwEQmw5v1Oc97OQ1VjSKA7/JZ7kVTHSg5ex7TuTB1ywS+Re5nnZsrqiq5
         6012klPD/Ubjw==
Date:   Wed, 5 Oct 2022 01:40:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Morten Linderud <morten@linderud.pw>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 config
Message-ID: <Yzy2STXGSBmSLhmA@kernel.org>
References: <20210920203447.4124005-1-morten@linderud.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920203447.4124005-1-morten@linderud.pw>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 20, 2021 at 10:34:47PM +0200, Morten Linderud wrote:
> Some vendors report faulty values in the acpi TPM2 table. This causes

s/acpi/ACPI/

> the function to abort with EIO and essentially short circuits the

s/the function/tpm_read_log()/

> tpm_read_log function as we never even attempt to read the EFI
> configuration table for a log.

> 
> This changes the condition to only look for a positive return value,
> else hands over the eventlog discovery to the EFI configuration table
> which should hopefully work better.

Please, write in imperative ("Change...").

Also exlicitly state how are you changing the check for
tpm_read_log_acpi() in tpm_read_log().

You could *even* have a snippet how the checks change
here for clarity.

> It's unclear to me if there is a better solution to this then just
> failing. However, I do not see any clear reason why we can't properly
> fallback to the EFI configuration table.

This paragraph should not be part of the commit message.

Rest of the commit message made sense can you add also fixes tag
as this is clearly a bug fix?

Also, please remove the two spurious diff's from the commit that
are not relevant for a stable bug fix (pr_warn() and comment
removal).

BR, Jarkko
