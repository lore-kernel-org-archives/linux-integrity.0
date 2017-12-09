Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38815 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdLIWBo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Dec 2017 17:01:44 -0500
Received: by mail-wm0-f50.google.com with SMTP id 64so8180527wme.3
        for <linux-integrity@vger.kernel.org>; Sat, 09 Dec 2017 14:01:44 -0800 (PST)
MIME-Version: 1.0
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Sat, 9 Dec 2017 17:01:22 -0500
Message-ID: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
Subject: IMA keyctl problems
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hey all!

I have an asymmetric key loaded into _ima on my root user's @u
keyring. v/r/s is set on the keyrings, and key:

```
 943483453 --alswrv      0 65534  keyring: _uid.0
 559919368 ----s-rv      0     0   \_ keyring: _ima
 475931491 ----s-rv      0     0       \_ asymmetric: Local IMA Key
```

However, when I try and run my VM with IMA set to log, I'm getting a
log full of:

"integrity: no _ima keyring: -126"

Anyone have a tip on what I'm doing wrong?

--
:wq
