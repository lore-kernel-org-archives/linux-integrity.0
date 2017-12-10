Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44430 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdLJQQX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 11:16:23 -0500
Received: by mail-wm0-f41.google.com with SMTP id t8so10386889wmc.3
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 08:16:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512921715.3846.33.camel@linux.vnet.ibm.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Sun, 10 Dec 2017 11:16:01 -0500
Message-ID: <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hey Mimi,

Thanks again for the quick response!

> Both dracut and systemd have examples for loading keys on the IMA keyring.
>
> - https://git.kernel.org/pub/scm/boot/dracut/dracut.git/tree/modules.d/98integrity/ima-keys-load.sh
>
> - https://github.com/systemd/systemd/blob/master/src/core/ima-setup.c

Yeah, I read those, and I don't see any of them doing anything I'm not
already doing.

The basics of how I'm loading the key are:

```
IMA_KEYRING_NAME="_ima"
IMA_KEY_PERMS="0x0b0b0b0b"
IMA_KEYRING_ID=$(keyctl newring ${IMA_KEYRING_NAME} @us)
IMA_KEY_ID=$(keyctl padd asymmetric 'Local IMA Key' ${IMA_KEYRING_ID}
< ${IMA_DIR}/cert_evm.der)

keyctl link ${IMA_KEYRING_ID} @u

keyctl setperm ${IMA_KEY_ID} ${IMA_KEY_PERMS}
keyctl setperm ${IMA_KEYRING_ID} ${IMA_KEY_PERMS}
```

Can you see what's going wrong here? I also can't seem to read the DER
from the asymmetric key, maybe that's related?

I understand evmctl can do some of this, but I need to understand the
internals here. Is it because I'm linking the keyring in after I build
it?


> Also, you might be interested in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=850339

Yeah, that's interesting. I'd be interested in sponsoring (after I
generate a new OpenPGP key :) ) such work if you have a debian source
package prepared

> Mimi
>

   Paul



-- 
:wq
