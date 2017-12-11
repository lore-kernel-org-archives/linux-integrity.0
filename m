Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37550 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbdLKD7e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 22:59:34 -0500
Received: by mail-wm0-f53.google.com with SMTP id f140so11653504wmd.2
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 19:59:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com> <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
 <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Sun, 10 Dec 2017 22:59:12 -0500
Message-ID: <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

(break-break)

Phew. OK. I think I've made sense of what was going on here.

I took another look at my policy and on a hunch, figured I ought to
look at the only unique line I had written:

```
appraise appraise_type=imasig uid=1000
```

When I changed that to uid=0, everything worked as expected.

On a hunch, I changed it back to uid=1000, got the error, and ran:

```
keyctl link %keyring:_ima %keyring:_uid.1000
```

At which point, the kernel errors went away, and I got the single
`IMA-signature-required` error I was looking for. Huzzah!


Now, can anyone point me in the right direction as to why I had to
link this keyring to a user to enforce policy?

Is there a reason the lookup doesn't behave as if it were doing a
%keyring:{_,.}ima lookup? That works even before linking it to
_uid.1000.

Do other tools load this for each UID on the system? What happens if a
new user is added at runtime?

This was a pretty not-obvious way for this system to fail, are there
docs that cover this?

   Paul
