Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45743 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJEImd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 04:42:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so9127540oig.12
        for <linux-integrity@vger.kernel.org>; Thu, 04 Oct 2018 18:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180926032455.224600-1-louiscollard@chromium.org> <20180926103521.GB4885@linux.intel.com>
In-Reply-To: <20180926103521.GB4885@linux.intel.com>
From: Louis Collard <louiscollard@chromium.org>
Date: Fri, 5 Oct 2018 09:45:57 +0800
Message-ID: <CAKNRAJVibJ0VnxbEiWR_8_q3FzKHT+Q9etcnqJ8Fny40p_cx8g@mail.gmail.com>
Subject: Re: [PATCH] Allow hwrng to initialize crng.
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David R. Bild" <david.bild@xaptum.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Buesch <m@bues.ch>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Gary R Hook <gary.hook@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 26, 2018 at 6:35 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 26, 2018 at 11:24:55AM +0800, Louis Collard wrote:
> > Some systems, for example embedded systems, do not generate
> > enough entropy on boot through interrupts, and boot may be blocked for
> > several minutes waiting for a call to getrandom to complete.
> >
> > Currently, random data is read from a hwrng when it is registered,
> > and is loaded into primary_crng. This data is treated in the same
> > way as data that is device-specific but otherwise unchanging, and
> > so primary_crng cannot become initialized with the data from the
> > hwrng.
> >
> > This change causes the data initially read from the hwrng to be
> > treated the same as subsequent data that is read from the hwrng if
> > it's quality score is non-zero.
> >
> > The implications of this are:
> >
> > The data read from hwrng can cause primary_crng to become
> > initialized, therefore avoiding problems of getrandom blocking
> > on boot.
> >
> > Calls to getrandom (with GRND_RANDOM) may be using entropy
> > exclusively (or in practise, almost exclusively) from the hwrng.
> >
> > Regarding the latter point; this behavior is the same as if a
> > user specified a quality score of 1 (bit of entropy per 1024 bits)
> > so hopefully this is not too scary a change to make.
> >
> > This change is the result of the discussion here:
> > https://patchwork.kernel.org/patch/10453893/
> >
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> /Jarkko

Thanks!

Adding a few people I think I should have included previously - I'm
new to this process so apologies for any missteps; please let me know
if there is anything else I can / should be doing!
