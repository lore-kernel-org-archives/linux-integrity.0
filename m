Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:38269 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdLURZ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 12:25:26 -0500
Received: by mail-qk0-f170.google.com with SMTP id i190so11400653qka.5
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 09:25:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <225df7f0-2422-1c5a-f44e-96cfd3b24232@redhat.com>
References: <20171220113538.16099-1-javierm@redhat.com> <5c098570-5aea-533c-c096-b5eb5ecc5c95@ettle.org.uk>
 <225df7f0-2422-1c5a-f44e-96cfd3b24232@redhat.com>
From: Jeffery Miller <jmiller@neverware.com>
Date: Thu, 21 Dec 2017 11:25:25 -0600
Message-ID: <CAERfUWpNfXkc+tKG72k_ZXeeNG_5pnTkJW0j18FJQ_gj-11yog@mail.gmail.com>
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: James Ettle <james@ettle.org.uk>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 6:46 AM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> I meant linux-tpmdd + the 4 patches in this series.

Javier,
I applied the four patches to the linux-tpmdd master 46dd3b29e328 this
morning and it
fixed the touchpad on my affected machine.

To be clear, the patchwork patches I applied were:
10125523
10125515
10125513
10125531

I have a slightly different machine (Lenovo Yoga 11e) but found the
same original CLKRUN commit doing a bisect.
