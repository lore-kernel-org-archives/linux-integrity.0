Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD706C77B7E
	for <linux-integrity@archiver.kernel.org>; Mon, 24 Apr 2023 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjDXL4e (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 24 Apr 2023 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjDXL4e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 07:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D933AAF;
        Mon, 24 Apr 2023 04:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89E6620FF;
        Mon, 24 Apr 2023 11:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5254C4339B;
        Mon, 24 Apr 2023 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682337392;
        bh=2C+OmzOkcznEoV0Ab0AckqNk9Q2kaZkT1tHfjXPMA7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rmj3vrsAy4XpmbqzGsIOemgihSFmdGMqVwtGm0G20F4oHnE2SwRPNy/zVpwi+Ca4+
         /9Q/O6NMbSbr57o57AycmbIoSOh3yDQwMYpI4x42M3ek8azC22WlVJ7p/kJNvsDNYa
         fBj1NEm72s4qRWjrcYB+DLz1lXQjXsO7CERO++qZbBXbM9bR18nFlLDTYKP4AgbelF
         f7Kn2pPKKcRme76hG6lhJfHqTU5mG0Q/nF3QLl52mcHQ0+ArqGDuS4nxaVFcp/efoH
         qrVlVPgus9arWviW+GM/MO0hsxjnalzberPq8FoJ5WxllLgZ4/bghDxa3+oOfSOdMF
         vvdFdzkxTiMUg==
Date:   Mon, 24 Apr 2023 12:56:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, jsnitsel@redhat.com,
        robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ut5sBOpq6GKRQNb"
Content-Disposition: inline
In-Reply-To: <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
X-Cookie: A rolling disk gathers no MOS.
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--1Ut5sBOpq6GKRQNb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 23, 2023 at 06:08:16PM +0300, Jarkko Sakkinen wrote:

> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> Should I pick these patches?

I've queued the spi side already.

--1Ut5sBOpq6GKRQNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbmgACgkQJNaLcl1U
h9DIJwf/ZUTnNktC/cLRDi3Pv+zIKz9BhX8xNlVL5nLvl6pV67Wo2+Ohc/lJOu81
6jtwTJG6cquuwoF0U/NKNRTWGJCVHJmfFQ5//TzNuRoqMQgLWn6GkD46q+HxEj7u
dGzALk6zUrQ1UteWXxDY27JNZ5ValePOGRMuk/JJzJgSbr7CdiSbZMvoO1wHrber
vPrB2fWtdIMmnPNqV/kPcUqWWQc9FMFsbmJ2OslKDoOs6XWRyY4E+2mOqPVugnki
4NwsJFRcHuxV0CT47SHkWnKHdBOWi1qW8yI0kRya07sSoA/G7m9rby7tgcCSjEN5
Un1LDG1dcmeIFFANKffFyN/Vx0VEsQ==
=g4Dn
-----END PGP SIGNATURE-----

--1Ut5sBOpq6GKRQNb--
