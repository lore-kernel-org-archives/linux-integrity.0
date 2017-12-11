Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:44730 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbdLKC7g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 21:59:36 -0500
Received: by mail-wm0-f50.google.com with SMTP id t8so11814181wmc.3
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 18:59:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com> <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Sun, 10 Dec 2017 21:59:14 -0500
Message-ID: <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Since I'm still stuck on this, I rebuilt the Debian kernel, patching
security/integrity/didsig.c round-about line 55 on Linux 4.12.2 to
add:

```
pr_err("XXX: type=%s name=%s\n", key_type_keyring, keyring_name[id]);
```

I see logs that look like:

```
integrity: XXX: type=_ima name=(null)
integrity: no _ima keyring: -126
```

That strikes me as weird. Seems like request_key would have wanted a
type of "keyring" or something, and a description of "_ima", not a
type of "_ima" and no description.

Does this rustle up any thoughts from anyone?
  Paul


-- 
:wq
