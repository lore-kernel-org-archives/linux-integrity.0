Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D35C7EE29
	for <linux-integrity@archiver.kernel.org>; Fri,  2 Jun 2023 19:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjFBTVX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjFBTVW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 15:21:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D51B8;
        Fri,  2 Jun 2023 12:21:20 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 850051C0E51; Fri,  2 Jun 2023 21:21:17 +0200 (CEST)
Date:   Fri, 2 Jun 2023 21:21:14 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     jarkko@kernel.org, gregkh@linuxfoundation.org, pavel@denx.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        linux-integrity@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH] tpm, tpm_tis: correct tpm_tis_flags enumeration values
Message-ID: <ZHpBKi4Mk2+hvSom@duo.ucw.cz>
References: <20230530164116.20770-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w9Khytz2WmtvP9wq"
Content-Disposition: inline
In-Reply-To: <20230530164116.20770-1-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--w9Khytz2WmtvP9wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>=20
> With commit 858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in test
> for interrupts") bit accessor functions are used to access flags in
> tpm_tis_data->flags.
>=20
> However these functions expect bit numbers, while the flags are defined as
> bit masks in enum tpm_tis_flag.
>=20
> Fix this inconsistency by using numbers instead of masks also for the fla=
gs
> in the enum.
>=20

Reviewed-by: Pavel Machek <pavel@denx.de>

Thank you!

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--w9Khytz2WmtvP9wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHpBKgAKCRAw5/Bqldv6
8iFbAJ4tQr2ZZkoJAQQwMB1LxZcY64Tp8gCgtTqX7sTiTc12sDu7z5xhTjevRQ8=
=q5/Y
-----END PGP SIGNATURE-----

--w9Khytz2WmtvP9wq--
