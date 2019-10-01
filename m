Return-Path: <SRS0=aMgY=X2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00471ECE587
	for <linux-integrity@archiver.kernel.org>; Tue,  1 Oct 2019 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA77C21872
	for <linux-integrity@archiver.kernel.org>; Tue,  1 Oct 2019 12:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfJAM6T (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:58:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726712AbfJAM6T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Oct 2019 08:58:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA7E8AE89
        for <linux-integrity@vger.kernel.org>; Tue,  1 Oct 2019 12:58:17 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:58:17 +0200
From:   Matthias Gerstner <mgerstner@suse.de>
To:     linux-integrity@vger.kernel.org
Subject: Re: bluez: NULL pointer dereference in bluetooth-meshd
 org.bluez.mesh.Network1.Join
Message-ID: <20191001125817.GF9771@f195.suse.de>
References: <20191001125600.GD9771@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <20191001125600.GD9771@f195.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My apologies, this email went to the wrong mailing list.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAl2TTWkACgkQFMQFyXGS
NVN9kg//YflqrFEFbH7/cC9EvcTWn6DQxsqzKb9IH88I2O32DNdip/MyoxLiYfjS
lD7qxldTmRMmFSk3zhHyRh7aBuI28GGk6V1v4E0MvVHIpmVwYjmo0/M/JqeA+ZRY
wdFiYD4w+zfmUahtaMyGrRdGgplcnn/W4GxHOGLwUNIRY+jo8p2vHePUlxC0R5V1
wYXQHJBHm6s92onHQnVCmh6agmb7mvUdoDia7P7DaoGjTz+zTLxlWS54sxhtAR3e
SwYnAJe4NXh/EnCeNVEhtzqi8x3q5Wi/+BYvDeLP9zEO9Nu9YdSVyolWunAr5URu
pfXI0OUTtylDz4I+CUZIBFCnnSxcA1hT2CVQo7+ED44320ytTSefWIm72XM39aQ/
bncWCbDQ5ZH0zXXQkUGxgD6sEbc6L1K45Tbm+W3wANDIXKH6PloJ6LcSx9K5fGsL
WeEdMO7HiPU+bGjHaCdu8XhpPaentPbUBP6TPkBr9MXx42AfGd396OszUHxES49l
n0iTeSsWnIYsjYwnG5lOcZPhGYHq8SPTVUkw0R+pacMQXYYyOJbw4SNMZsZwQ5IZ
g78CT/0v7kxhrOirdRyWJLI/QD2iSlGXZu6Zc5JjpWBPtnulz0E682CZHJesz2ay
T44XiJ/afrc5hCI5fmKaLtaQGS01X0eBBOm/DYioSLS/UcluQt0=
=Edxq
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
