Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37790 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdLKOOE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 09:14:04 -0500
Received: by mail-wm0-f45.google.com with SMTP id f140so14380489wmd.2
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 06:14:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513000117.3846.122.camel@linux.vnet.ibm.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com> <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
 <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
 <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com> <1513000117.3846.122.camel@linux.vnet.ibm.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Mon, 11 Dec 2017 09:13:42 -0500
Message-ID: <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: multipart/mixed; boundary="94eb2c0e374a7cbdcf05601125f9"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 11, 2017 at 8:48 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The "uid=" is a condition that limits which files to appraise.  By
> changing "uid=" to 0, I assume by "worked as expected" means nothing
> verified.

Not quite, when I say "works as expected" I mean, everything worked
(since I signed all binaries) except for one (which was logged, as I
mentioned, and when I turned it onto enforce, it gave me permission
denied. As root.

> This all seems to indicate that the keys are not being loaded onto
> root's _ima keyring.  See if there is a difference if you "su -",
> before creating the _ima keyring.

I was running this as uid 0 in the initramfs. It's in a keyring named
_ima and it's linked to @u. That appears to not be sufficient. How do
I create a keyring that spans all user's @u?

> Even if you don't add any keys during boot, enabling dracut/systemd
> would at least properly create the _ima keyring.

Do you have a pointer as to what I'm doing on? I attached the script
I'm running in my initramfs. I'd rather figure out what I'm doing
wrong before punting this to another tool for now.

As for the current behavior --


I've rebooted the machine, here's some output from a terminal from
both root and the user from the keyring as set up currently --

The user can find the keyring called _ima which is attached to root's
@u, but it is not in the user's @u (which should be fine, except it's
not). The user can still find the _ima keyring.

```
# whoami
root
# keyctl show @u
Keyring
 860222890 --alswrv      0 65534  keyring: _uid.0
1007461092 --alswrv      0     0   \_ keyring: _ima
 484254545 --alswrv      0     0       \_ asymmetric: Local IMA Key
# keyctl show %keyring:_ima
Keyring
1007461092 --alswrv      0     0  keyring: _ima
 484254545 --alswrv      0     0   \_ asymmetric: Local IMA Key
# exit
$ whoami
user
$ keyctl show @u
Keyring
 958372548 --alswrv   1000 65534  keyring: _uid.1000
$ keyctl show %keyring:_ima
Keyring
1007461092 --alswrv      0     0  keyring: _ima
 484254545 --alswrv      0     0   \_ asymmetric: Local IMA Key
$
```

This, however, is in the failed state, unless I change uid to 0 and
check enforcement as root rather than user.


  Paul




-- 
:wq


    [ Part 2, Application/OCTET-STREAM (Name: "ima") 732 bytes. ]
    [ Unable to print this part. ]
