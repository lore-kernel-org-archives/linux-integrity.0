Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35809 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937031AbdLSCIC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 21:08:02 -0500
Received: by mail-io0-f176.google.com with SMTP id 14so5455294iou.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 18:08:02 -0800 (PST)
Date: Mon, 18 Dec 2017 19:08:00 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219020800.GK19056@ziepe.ca>
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

I would like to hear from Intel why they made this patch in the first
place, since we are mostly guessing...

> 1) Leave the code as is and apply the patch I shared with James. In that
>    case the CLKRUN protocol will be disabled only during TPM transactions
>    and not enabled again after transactions if it wasn't enabled.

This seems necessary no matter what, especially if it works..

> 2) Drop the pending CLKRUN patch in linux-tpmdd and revert CLKRUN commit
>    in mainline. And instead of disabling the CLKRUN protocol during the
>    TPM transactions, disable if the CLKRUN_EN is enabled and the system
>    is in a list of systems that have a TPM that doesn't support CLKRUN.

This is also a good possible idea.

Again, depends why Intel did this. I assumed it was a chipset bug
since Intel was sending it not a system builder..

Jason
