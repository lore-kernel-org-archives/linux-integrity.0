Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968018AbeF1TDv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:51 -0400
Date: Thu, 28 Jun 2018 18:39:00 +0200
From: Matthias Gerstner <mgerstner@suse.de>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH] integrity: prevent deadlock during digsig verification.
Message-ID: <20180628163900.GD8003@f195.suse.de>
References: <20180627163342.3e1d6333@totoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
In-Reply-To: <20180627163342.3e1d6333@totoro>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

> In this patch, I propose add an exception for "crypto-pkcs1pad(rsa,*)"
> module requests only in case of enabled integrity asymmetric keys support.

I have tested the patch in my test setup and it looks good. No deadlocks
so far.

Regards

Matthias


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 849 bytes. ]
    [ Unable to print this part. ]
