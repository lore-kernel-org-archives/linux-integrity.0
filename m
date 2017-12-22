Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31894 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755940AbdLVSa4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:30:56 -0500
Date: Fri, 22 Dec 2017 20:30:52 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Ettle <james@ettle.org.uk>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171222183052.sfz6h5rln65cv7zq@linux.intel.com>
References: <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <6b41f2a7-3b6e-69f2-fd49-d2ae774ff0f5@ettle.org.uk>
 <20171219130017.dhley2g4avwo3vbu@linux.intel.com>
 <5d899290-c959-fa27-b0cf-83c86ac7f28c@ettle.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d899290-c959-fa27-b0cf-83c86ac7f28c@ettle.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> I'm OK with that.
> 
> Do you need any more info on the specifics of the machine I'm using?
> 
> (Note: I'm not currently aware of any BIOS updates for it. If this is ultimately a BIOS problem I wouldn't know what sort of report to file, or how to file it anyway...)
> 
> Thanks,
> James

I just found out that the original bug was specific to BSW with
Infineon SLB9655 chip.

Unless you have this specific chip you can just give Tested-by
(and Reviewed-by).

/Jarkko
