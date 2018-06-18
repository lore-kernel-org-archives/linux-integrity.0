Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934674AbeFRO4a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 10:56:30 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1FBADADD1
        for <linux-integrity@vger.kernel.org>; Mon, 18 Jun 2018 14:56:29 +0000 (UTC)
Date: Mon, 18 Jun 2018 16:56:28 +0200
From: Matthias Gerstner <mgerstner@suse.de>
To: linux-integrity@vger.kernel.org
Subject: IMA: Deadlock in ima_appraise_measurement when /bin/kmod carries a
 digsig in security.evm
Message-ID: <20180618145628.GD8123@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,

I came across a deadlock issue when /bin/kmod carries a digital
signature in security.evm.

There was a patch suggested on the old linux-ima-devel mailing list here
<https://sourceforge.net/p/linux-ima/mailman/message/35628097/>, but it
seems not to have made it into the official tree.

Can anybody tell me what the status of this patch is?

Thank you

Matthias

-- 
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Telefon: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Linux GmbH
GF: Felix Imendorffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nuernberg)


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 849 bytes. ]
    [ Unable to print this part. ]
