Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60817 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760710AbdLSNAX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:00:23 -0500
Date: Tue, 19 Dec 2017 15:00:17 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Ettle <james@ettle.org.uk>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219130017.dhley2g4avwo3vbu@linux.intel.com>
References: <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <6b41f2a7-3b6e-69f2-fd49-d2ae774ff0f5@ettle.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b41f2a7-3b6e-69f2-fd49-d2ae774ff0f5@ettle.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 18, 2017 at 06:26:35PM +0000, James Ettle wrote:
> The keyboard and touchpad work OK with the patch quoted below and the earlier two applied, i.e. the three patches with signatures:
> 
> 667dcc75be864ff4c17cf58891853b7393bba3e2
> db3248e8a036c39141c8f7e9f1cf5c5ae6815f76
> 370d45a34dc8914066a995a3a6d6df1953ea9f60
> 
> I applied these to a vanilla kernel.org 4.14.7 source using Fedora 4.14.5-300.fc27 .config. Confirmed the tpm modules are loaded.
> 
> Tests:
> 1. Keyboard and touchpad work OK on boot - PASS
> 2. Still work after suspend/resume - PASS
> 
> Let me know if you want any further tests.
> 
> Many thanks,
> James.

Thank you for your awesome help! I guess Javier can add your
Tested-by to the patch?

/Jarkko
