Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39707 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLRXet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 18:34:49 -0500
Received: by mail-wr0-f171.google.com with SMTP id a41so16042241wra.6
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 15:34:48 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jason Gunthorpe <jgg@ziepe.ca>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
References: <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
 <20171218201902.GF19056@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <781b45aa-547c-9b0f-4669-4e081cf39a93@redhat.com>
Date: Tue, 19 Dec 2017 00:34:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171218201902.GF19056@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jason,

On 12/18/2017 09:19 PM, Jason Gunthorpe wrote:
> On Mon, Dec 18, 2017 at 07:34:29PM +0000, Shaikh, Azhar wrote:
> 
>>> IIUC, if CLKRUN_EN is enabled, then all the devices attached to the
>>> LPC bus have to support the CLKRUN protocol. My guess is that on
>>> some Braswell systems LPC power management is enabled but the TPM
>>> device doesn't have CLKRUN support.
>>
>> I think this is what might be happening here.
> 
> That makes it a BIOS bug, not a chipset bug, and we shouldn't be
> trying to fix it like this in Linux.
>

Indeed, the system integrator should make sure that all peripherals that
are connected through the LPC bus either support the CLKRUN protocol and
CLKRUN_EN is enabled or CLKRUN_EN should be disabled.
 
> Based on the original discussion I always thought this was an Intel
> chipset bug and applies to all cases.
>

After thinking about this and with a better understanding of the issue,
I think we have 2 options (please let me know if I got something wrong):

1) Leave the code as is and apply the patch I shared with James. In that
   case the CLKRUN protocol will be disabled only during TPM transactions
   and not enabled again after transactions if it wasn't enabled.

   This shouldn't affect other peripherals since even if they have CLKRUN
   support, they should work correctly while CLKRUN protocol is disabled.

   The disadvantage is that TPM devices that have CLKRUN support (do they
   exist?) will not take the advantage of the power management feature of
   stopping the LPC host LCLK clock during low-power states.

2) Drop the pending CLKRUN patch in linux-tpmdd and revert CLKRUN commit
   in mainline. And instead of disabling the CLKRUN protocol during the
   TPM transactions, disable if the CLKRUN_EN is enabled and the system
   is in a list of systems that have a TPM that doesn't support CLKRUN.

   This list could be for example a struct dmi_system_id array and match
   using DMI data on module_init().

   The advantage is that TPM devices with CLKRUN protocol support could
   make use of the CLKRUN power management feature and only systems with
   a TPM that doesn't support the CLKRUN protocol will disable it.

   The disadvantage is that the struct dmi_system_id array to match will
   have to be maintained and every known-to-be-broken system added to it.

Thoughts?

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
