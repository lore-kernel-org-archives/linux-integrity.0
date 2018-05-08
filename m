Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754208AbeEHJPz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 05:15:55 -0400
Message-ID: <1525770559.24345.10.camel@suse.com>
Subject: Re: [PATCH v3 1/2] usb: misc: xapea00x: add driver for Xaptum ENF
 Access Card
From: Oliver Neukum <oneukum@suse.com>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-usb@vger.kernel.org
Date: Tue, 08 May 2018 11:09:19 +0200
In-Reply-To: <CAAi9uDuhR+X37aedWjmrPssr4RjgzuJoJ4vL7md1fMsHq5ASJQ@mail.gmail.com>
References: <20180504130022.5231-1-david.bild@xaptum.com>
         <20180504130022.5231-2-david.bild@xaptum.com>
         <1525687128.24345.3.camel@suse.com>
         <CAAi9uDuhR+X37aedWjmrPssr4RjgzuJoJ4vL7md1fMsHq5ASJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Am Montag, den 07.05.2018, 08:31 -0500 schrieb  David R. Bild :
> > > +     spi_master->flags = 0;
> > > +     spi_master->setup = xapea00x_spi_setup;
> > > +     spi_master->transfer_one_message = xapea00x_spi_transfer_one_message;
> > > +
> > > +     retval = spi_register_master(spi_master);
> > > +
> > > +     if (retval)
> > > +             goto free_spi;
> > > +
> > > +     dev->spi_master = spi_master;
> > 
> > Race condition.
> > 
> 
> What race condition do you see?  (I appreciate the review, but need
> some more specific help here.)

Hi,

you have registered the master. So it is functional, but if any
callback goes for dev->spi_master at that point, it will read an
incorrect value.

	HTH
		Oliver
