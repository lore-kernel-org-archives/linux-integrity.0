Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbdLASPY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Dec 2017 13:15:24 -0500
Date: Fri, 1 Dec 2017 16:15:22 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: dmitry.kasatkin@gmail.com, zohar@linux.vnet.ibm.com
Cc: linux-integrity@vger.kernel.org
Subject: IMA-EVM-Utils OpenSSL1.1 interface update
Message-ID: <20171201181522.GB3056@glitch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi folks,

I don't really know what are your best interest in update ima-evm-utils
1.0 package to support OpenSSL 1.1 new interface considering lots of
distros are chaging to it as the default one. Some are maintaining
compatibility packages to OpenSSL 1.0, but usually it remains available
in the official repos for something like 1 or 2 releases and then
removed completely.

Actually I have a simple/small port of it to OpenSSL 1.1 that I plan to
maintain for Fedora's Rawhide (next release, f28) package. Do you guys
have interest on it? I could post it as a patch.

Thanks!



    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
