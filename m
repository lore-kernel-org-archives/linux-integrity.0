Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47919C04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135DA20863
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 20:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135DA20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeLAHWa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:22:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHWa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 02:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23CB1C0495B2;
        Fri, 30 Nov 2018 20:12:05 +0000 (UTC)
Received: from localhost (ovpn-116-19.gru2.redhat.com [10.97.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7B45C1A1;
        Fri, 30 Nov 2018 20:12:04 +0000 (UTC)
Date:   Fri, 30 Nov 2018 18:12:03 -0200
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com
Subject: Re: [PATCH] libimaevm: get key description out of verbose condition
Message-ID: <20181130201203.GD25971@rhlt>
References: <20181130200411.19595-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <20181130200411.19595-1-bmeneg@redhat.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 30 Nov 2018 20:12:05 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ignore this patch, forgot to add "ima-evm-utils" as a prefix in the
subject line. I already sent a new patch with the correction.

Sorry for the noise.

On Fri, Nov 30, 2018 at 06:04:11PM -0200, Bruno E. O. Meneguele wrote:
> Key description in keyring is being filled with memory garbage during imp=
ort
> process if the LOG_LEVEL is not satisfied (using '-vv').
>=20
> Testing in kernels without trusted keyring support, and importing a v1 (R=
SA) key
> pair, the kernel fails to find the key since it looks for the key descrip=
tion,
> which is not found due to this issue:
>=20
>     "digsig: key not found, id: DD0558FEB7DDBD26"
>=20
> Looking at:
>     # keyctl show
>     Session Keyring
>      635748007 --alswrv      0     0  keyring: _ses
>      673181018 --alswrv      0 65534   \_ keyring: _uid.0
>      360651479 --alswrv      0     0       \_ keyring: _ima
>      499360916 --alswrv      0     0       |   \_ user: .N=3D
>      266933436 --alswrv      0     0       |   \_ user: B641632DA94DEE26
>=20
> Key id 499360916 and 266933436 are both the same key, but the first was a=
dded
> without '-vv' in the command line, while the second one was using it.
>=20
> Signed-off-by: Bruno E. O. Meneguele <bmeneg@redhat.com>
> ---
>  src/libimaevm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 6fa0ed4..b6f9b9f 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -672,12 +672,11 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const=
 unsigned char *pkey, int len
>  	memcpy(keyid, sha1 + 12, 8);
>  	log_debug("keyid: ");
>  	log_debug_dump(keyid, 8);
> +	id =3D __be64_to_cpup((__be64 *) keyid);
> +	sprintf(str, "%llX", (unsigned long long)id);
> =20
> -	if (params.verbose > LOG_INFO) {
> -		id =3D __be64_to_cpup((__be64 *) keyid);
> -		sprintf(str, "%llX", (unsigned long long)id);
> +	if (params.verbose > LOG_INFO)
>  		log_info("keyid-v1: %s\n", str);
> -	}
>  }
> =20
>  void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
> @@ -694,11 +693,10 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA =
*key)
>  	memcpy(keyid, sha1 + 16, 4);
>  	log_debug("keyid: ");
>  	log_debug_dump(keyid, 4);
> +	sprintf(str, "%x", __be32_to_cpup(keyid));
> =20
> -	if (params.verbose > LOG_INFO) {
> -		sprintf(str, "%x", __be32_to_cpup(keyid));
> +	if (params.verbose > LOG_INFO)
>  		log_info("keyid: %s\n", str);
> -	}
> =20
>  	free(pkey);
>  }
> --=20
> 2.19.1
>=20

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAlwBmZMACgkQYdRkFR+R
okOJuggArYoFKSBLLTYFBr/uJ0OnE2kjtaDw0t+3uUGNSXpS+POlLlGewxgxXHnp
z5OPh3p8p/xxHLKdT/rV0AGosXd5B2F1dBSp5VhPCqlJkbXHd3ScWJjjzZczqG07
jb+KpvXO1Kj6NzptmZNxijtV846v0cKgTUpRgq4mx0rlxVWgURLFPAQlEO05v7gF
U/f6lysgcFBVxEC75DMl6JpkodkvJld52GYNsSNpmkxnjw8pQUYepSOV2r1L0/Do
4DDbAqlGLmNELj8bGWVjzE3hGVC15DrwpJajIpjYBL32iYEAAZeX9Pr/LWn2mhVh
nJBqbZ2BPxNlfyijv/HqFhS4kQbWkA==
=peLY
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
