Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43144 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbdLRUR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 15:17:56 -0500
Received: by mail-wm0-f47.google.com with SMTP id n138so172176wmg.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 12:17:55 -0800 (PST)
Date: Mon, 18 Dec 2017 13:17:50 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171218201750.GE19056@ziepe.ca>
References: <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 18, 2017 at 08:29:30PM +0100, Javier Martinez Canillas wrote:

> My knowledge of LPC is near to non-existent so I please forgive me if I'm wrong,
> but my understanding is that it's the opposite of what you said.
> 
> When CLKRUN_EN is SET, power management is ENABLED on the LPC bus and the host
> LCLK clock may be stopped when entering in some low-power states.
>
> The CLKRUN# signal is then used by peripherals to restart the LCLK clock after
> resuming from low-power states to be able to transmit again.
> 
> When CLKRUN_EN is CLEAR, power management is DISABLED on the LPC bus and the
> host LCLK clock is never stopped even when entering in some low-power states.

Okay, that makes sense.

Jason
