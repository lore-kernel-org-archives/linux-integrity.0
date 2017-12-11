Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:44588 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdLKRlb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 12:41:31 -0500
Received: by mail-wm0-f45.google.com with SMTP id t8so15997929wmc.3
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 09:41:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513012934.3846.197.camel@linux.vnet.ibm.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
 <1512915528.3846.29.camel@linux.vnet.ibm.com> <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
 <1512921715.3846.33.camel@linux.vnet.ibm.com> <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
 <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
 <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
 <1513000117.3846.122.camel@linux.vnet.ibm.com> <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
 <1513007322.3846.146.camel@linux.vnet.ibm.com> <CAO6P2QQe_gX3MYz-YwQF2=YCk1-Bna+Phg8Rz_-yp5rKtG1SzA@mail.gmail.com>
 <1513012934.3846.197.camel@linux.vnet.ibm.com>
From: "Paul R. Tagliamonte" <paultag@gmail.com>
Date: Mon, 11 Dec 2017 12:41:09 -0500
Message-ID: <CAO6P2QQSe0Mn4FmE6hqKDNu=j_1xAE7Ay+G4UAZjuA0sitpqgw@mail.gmail.com>
Subject: Re: IMA keyctl problems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Instead of "appraise func=BPRM_CHECK fowner=0 appraise_type=imasig"
> the appraise rule would be "appraise func=BPRM_CHECK
> appraise_type=imasig".

Spot on, thank you!

I didn't have a func=* which was causing this entire mess. I changed
the rule from:

`appraise appraise_type=imasig uid=1000` to:
`appraise appraise_type=imasig func=BPRM_CHECK uid=1000`

All behaves exactly as expected. I now have this VM booting and doing
so with enforced IMA signatures. Neato, thanks!

Weird so much came out as what looked like a keyctl issue. Apologies
for focusing on that and not posting the policy file, It's not clear
exactly why this policy rule bug surfaced like that, but I think I'm
off with a baseline now.

Thanks a ton for the help!
  Paul

-- 
:wq
