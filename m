Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:42640 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdLKQB0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 11:01:26 -0500
Received: by mail-wm0-f46.google.com with SMTP id b199so11662375wme.1
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 08:01:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513007322.3846.146.camel@linux.vnet.ibm.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com> <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
 <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
 <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
 <1513000117.3846.122.camel@linux.vnet.ibm.com> <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
 <1513007322.3846.146.camel@linux.vnet.ibm.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Mon, 11 Dec 2017 11:01:04 -0500
Message-ID: <CAO6P2QQe_gX3MYz-YwQF2=YCk1-Bna+Phg8Rz_-yp5rKtG1SzA@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Great!  And if you replaced the "uid=0" with "fowner=0" the appraisal
> would succeed whether or not you're running as root.

I was looking to appraise any binaries that a single user is running,
not anything any user runs that's owned by root.

> Different files can be signed with different keys, but all keys should
> be loaded onto the same _ima keyring.  (This will change once IMA is
> namespaced.)

Yes. Good copy on that.

My question was about how to ensure the _ima keyring is present in all
user's keyrings, if the IMA module is searching the user executing the
program's keyring. See the terminal output in my last mail.



Once again, the kernel is throwing errors if I try to appraise
binaries that uid 1000 is running unless the _ima keyring is linked to
uid 1000's @u keyring. Is this expected behavior, and if so, where can
I read more about this?




> The policy defines which files should be appraised.  If you want to
> verify files owned by uid 1000, the policy would include an appraise
> rule fowner=1000.

I want to appraise anything run by user 1000, regardless of file
owner. I can only seem to do this if uid 1000's @u has a _ima keyring
under it, and **not** if uid 0's @u has an _ima keyring under it. Is
this expected behavior?

> Normally one starts with something that is known to work, before
> attempting/complaining something different doesn't work.

Cheers, thanks for that.

I'd like to point out that at no point have I complained, even about
things fully deserving of it, such as the lack of documentation or
opaque errors. I've been courteous and tried to provide helpful
information and context proactively. To be honest, I'm a bit
disappointed and frustrated at this side-comment.

I understand you must be frustrated, and I appreciate you replied on a
weekend and it's not your job to provide support, but as a newcomer, I
am just as frustrated with this interaction.

A bit of empathy would be nice.


Cheers,
   Paul


-- 
:wq
