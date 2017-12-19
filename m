Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36950 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762922AbdLSNKm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:10:42 -0500
Date: Tue, 19 Dec 2017 15:10:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219131036.tjmdw5epeskwvhpc@linux.intel.com>
References: <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
 <20171218201902.GF19056@ziepe.ca>
 <781b45aa-547c-9b0f-4669-4e081cf39a93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <781b45aa-547c-9b0f-4669-4e081cf39a93@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Dec 19, 2017 at 12:34:46AM +0100, Javier Martinez Canillas wrote:
> Hello Jason,
> 
> On 12/18/2017 09:19 PM, Jason Gunthorpe wrote:
> > On Mon, Dec 18, 2017 at 07:34:29PM +0000, Shaikh, Azhar wrote:
> > 
> >>> IIUC, if CLKRUN_EN is enabled, then all the devices attached to the
> >>> LPC bus have to support the CLKRUN protocol. My guess is that on
> >>> some Braswell systems LPC power management is enabled but the TPM
> >>> device doesn't have CLKRUN support.
> >>
> >> I think this is what might be happening here.
> > 
> > That makes it a BIOS bug, not a chipset bug, and we shouldn't be
> > trying to fix it like this in Linux.
> >
> 
> Indeed, the system integrator should make sure that all peripherals that
> are connected through the LPC bus either support the CLKRUN protocol and
> CLKRUN_EN is enabled or CLKRUN_EN should be disabled.
>  
> > Based on the original discussion I always thought this was an Intel
> > chipset bug and applies to all cases.
> >
> 
> After thinking about this and with a better understanding of the issue,
> I think we have 2 options (please let me know if I got something wrong):
> 
> 1) Leave the code as is and apply the patch I shared with James. In that
>    case the CLKRUN protocol will be disabled only during TPM transactions
>    and not enabled again after transactions if it wasn't enabled.
> 
>    This shouldn't affect other peripherals since even if they have CLKRUN
>    support, they should work correctly while CLKRUN protocol is disabled.
> 
>    The disadvantage is that TPM devices that have CLKRUN support (do they
>    exist?) will not take the advantage of the power management feature of
>    stopping the LPC host LCLK clock during low-power states.

CLKRUN is enabled after TPM has processed the command so how this could
make power mgmt worse?

/Jarkko
