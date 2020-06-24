Return-Path: <SRS0=8o/c=AF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B0FC433E0
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Jun 2020 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B828D2076E
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Jun 2020 22:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYPNinYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbgFXWgf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:36:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732717AbgFXWgf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 18:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593038194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KT+iFSV3SRmbqLeA7KYP8qez1zRUe3LLad6cmdUTh44=;
        b=YYPNinYpx5nhobwcLWCVKtueeBA2HiUEEeag5w522/zrcy2wRONydc86mwSqpPXUCbv6l5
        8NFWo2ulpf3QxJ35l1SQvNxPDUbZQ9vbIWdWWDqTj22Z5AJE0IAVtx/J9OpuEh3gGsoMAW
        B0i6VYxgy3X7fw6sHpCd9zehrHUDm24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-IYX4POuSOXmAgld86RPSDw-1; Wed, 24 Jun 2020 18:36:29 -0400
X-MC-Unique: IYX4POuSOXmAgld86RPSDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E60518A8220;
        Wed, 24 Jun 2020 22:36:28 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B26827C20A;
        Wed, 24 Jun 2020 22:36:27 +0000 (UTC)
Date:   Wed, 24 Jun 2020 19:36:26 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: skip test for discrete TPM 1.2 and exec'd
 as normal user
Message-ID: <20200624223626.GE2639@glitch>
References: <20200624212420.3300-1-bmeneg@redhat.com>
 <1593036848.27152.211.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1593036848.27152.211.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 06:14:08PM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Wed, 2020-06-24 at 18:24 -0300, Bruno Meneguele wrote:
> > boot_aggregate test make use of a software TPM 2.0 in case it doesn't f=
ind
> > any /dev/tpm0 in the system or if the test is ran as a normal user. How=
ever,
> > when the system has a discrete TPM 1.2 and the user runs the test with =
a
> > non-root user evmctl fails to return the software TPM 2.0 boot aggregat=
e
> > value because it tries to access the sysfs PCRs file and, consequently,=
 the
> > test fails.
> >=20
> > Supporting a software TPM 1.2 involved some more work and new dependenc=
y in
> > other programs to extend the PCRs accordingly. Because of that, just dr=
op
> > support for this scenario for now.
>=20
> The problem is that the TPM 1.2 PCRs are visible to userspace.
> =A0Insteaad of reading the software TPM PCRs, it's reading the discrete
> TPM 1.2 PCRs. =A0I would drop this paragraph and simply say the sample
> TPM 2.0 log test is not supported on systems with a discrete TPM 1.2.
>=20

Ack. Will send a v2 dropping it.

> The patch itself is fine.
>=20
> thanks,
>=20
> Mimi
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7z1WoACgkQYdRkFR+R
okNNqwf+K6EbSOp/oeM5jMZU2V4NRKTfjNMZ5zSNtZWncDauXL3Y3SMZrAnSbBkm
+zoXgpHiLp9Z9uWUxEDNww4c2g17mhNS2x+dtPRDtB+GM6RavK4p9sHA+I87HHhg
ACGRlUzyl6BJ89kiZOwCxV+lEutCKX43XMWAwAo5wVBV6G/PILMpN9aDHowZSNTn
32MQqfQMzaWGEAI6ONqM+/Jr4+ihk8Dvg4wUE76/3mLBmOxlxtXhDnNK7cGxVwO8
1eDF30MrbEoma36TnxaVmI9ztIKbXbC+Xw+WwDQ3Ncsk7JrtAFaiZvpQW4U2G+Rm
DuYgp7S84HHH7HUk/SaLMv+dYXOzNA==
=LWpF
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

