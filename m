Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43034 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbdLSUU4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 15:20:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id n138so6034619wmg.2
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 12:20:55 -0800 (PST)
Date: Tue, 19 Dec 2017 13:20:51 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219202051.GB14814@ziepe.ca>
References: <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
 <20171218201902.GF19056@ziepe.ca>
 <20171219130432.tlf6tiv62nf4rreh@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219130432.tlf6tiv62nf4rreh@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Dec 19, 2017 at 03:04:32PM +0200, Jarkko Sakkinen wrote:

> > That makes it a BIOS bug, not a chipset bug, and we shouldn't be
> > trying to fix it like this in Linux.
> > 
> > Based on the original discussion I always thought this was an Intel
> > chipset bug and applies to all cases.
> 
> It would not be first time when some BIOS issues are circumvented in the
> kernel.

Yes, but we don't circumvent BIOS bugs by detecting the chipset type,
we look for the buggy BIOS.

Jason
