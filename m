Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A23C77B61
	for <linux-integrity@archiver.kernel.org>; Mon, 24 Apr 2023 13:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjDXNWA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjDXNVz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 09:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA555A2;
        Mon, 24 Apr 2023 06:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF5562242;
        Mon, 24 Apr 2023 13:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4D1C433D2;
        Mon, 24 Apr 2023 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342502;
        bh=ALxdl1WkZwvyVJ+h0DnMAEX7Ukk2uYfLG+nzutr9Xpo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bDY/QL3ihJHnEHGlbXzqlmiE+9xqWhgLx7XVqClIyZyqqzFcV4/ZMT53DjFRfSpjr
         D6DTngInppkpH7aXPuDoStiMKkdSqdJky9IdMgnK0xcVneSx5gd52MvwR9gDigizdi
         3814JhyyBVuRdylNmiTYoF25fZx6cn5XedcZwCgtcbde1JpoFCH55qrVo1voxbIAtt
         xo+550lJ8SAfmarY/IQ4kSyD3gRJkYVeZulG/bRzlSTQ6kFGoH11Lq0ISuRt9Cyw/s
         c8ccdQcp9RUnrWP2mER6HSSx7xmNKpwxBdIVWRbtAt1T9HnWbWM6mDC0fTjDUFWWRY
         0kXImrYKHkZmg==
From:   Mark Brown <broonie@kernel.org>
To:     jsnitsel@redhat.com, robh+dt@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <20230421091309.2672-1-kyarlagadda@nvidia.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
Subject: Re: (subset) [Patch V10 0/3] Tegra TPM driver with HW flow control
Message-Id: <168234249853.85980.16863845615990531114.b4-ty@kernel.org>
Date:   Mon, 24 Apr 2023 14:21:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 21 Apr 2023 14:43:06 +0530, Krishna Yarlagadda wrote:
> TPM devices may insert wait state on last clock cycle of ADDR phase.
> For SPI controllers that support full-duplex transfers, this can be
> detected using software by reading the MISO line. For SPI controllers
> that only support half-duplex transfers, such as the Tegra QSPI, it is
> not possible to detect the wait signal from software. The QSPI
> controller in Tegra234 and Tegra241 implement hardware detection of the
> wait signal which can be enabled in the controller for TPM devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Add TPM HW flow flag
      commit: 67a142dc9eb96a5cc018e5db62390665eb5f038c
[3/3] spi: tegra210-quad: Enable TPM wait polling
      commit: 967ca91a996f82219f2883e9e53d8e20df49025a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

