Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:52858 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756600AbdLOPYr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 10:24:47 -0500
From: <Mario.Limonciello@dell.com>
To: <pmenzel@molgen.mpg.de>, <Alexander.Steffen@infineon.com>,
        <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael.j.wysocki@intel.com>, <len.brown@intel.com>
Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Date: Fri, 15 Dec 2017 15:24:22 +0000
Message-ID: <5bb6d2bc874f4227b7341c88373cf01f@ausx13mpc120.AMER.DELL.COM>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
 <20171208155641.GA2883@ziepe.ca>
 <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
 <20171208161814.GB2883@ziepe.ca>
 <d70c683a-9ac2-e731-d6fd-173ac35c5b1b@molgen.mpg.de>
 <c700bf23fcf44221bc179a7b0e6df5c9@infineon.com>
 <3159adc4-4236-c963-a118-500a61f21338@molgen.mpg.de>
 <10b81a727ba940889095fa4bb29d0863@infineon.com>
 <f3371f11c6fa42fba3a07cffa571d6a6@ausx13mpc120.AMER.DELL.COM>
 <cdbfa6c972684ed28a92b5105be71071@infineon.com>
 <5efeaf9e50e54b999efa91c39f311bd9@ausx13mpc120.AMER.DELL.COM>
 <127aefc5-44e1-7382-2548-5cd4774275b0@molgen.mpg.de>
 <39ff773039e04506affc4a8522bde99f@ausx13mpc120.AMER.DELL.COM>
 <6344e116-763f-98d5-5174-7395d761de45@molgen.mpg.de>
In-Reply-To: <6344e116-763f-98d5-5174-7395d761de45@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
> Sent: Friday, December 15, 2017 9:11 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Alexander Steffen
> <Alexander.Steffen@infineon.com>; Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> rafael.j.wysocki@intel.com; len.brown@intel.com
> Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
> occurred continue selftest`
> 
> Dear Mario,
> 
> 
> On 12/15/17 15:39, Mario.Limonciello@dell.com wrote:
> >> -----Original Message-----
> >> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
> >> Sent: Friday, December 15, 2017 5:54 AM
> >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Alexander Steffen
> >> <Alexander.Steffen@infineon.com>; Jason Gunthorpe <jgg@ziepe.ca>
> >> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J.
> >> Wysocki <rafael.j.wysocki@intel.com>; Len Brown <len.brown@intel.com>
> >> Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
> >> occurred continue selftest`
> 
> [...]
> 
> >> the added line breaks to the quoted parts really mess up the citation.
> >> Can we please try to use MUAs avoiding that, or fixing that manually?
> >
> > I don't know what you mean.  I think this is directed at Alexander?
> > If this is directed to me I can't change mail clients, sorry.
> 
> I think it started in Alexander's reply (Message-ID:
> <10b81a727ba940889095fa4bb29d0863@infineon.com>) that line breaks were
> added to quotes. Your only adds a long "Original Message" header.
> 
File->Options->Mail->Replies and Forwards
Change "When Replying to a message"
to "Prefix each line of the original message"

That should help.

> > <snip>
> >
> >>> Yes it's required for the TPM model/vendor that is used in the XPS model that
> >>> Paul has.  If you try to run the upgrade without clearing it the firmware will
> >>> reject the upgrade.
> >>
> >> Mario, thank you for your quick reaction.
> >>
> >> [...]
> >>
> >> 1.  Can you reproduce this issue too?
> >
> > I haven't seen this, but if this is a regression I also have not run anything
> > later than 4.15-rc1 right now.
> 
> Well as far as I understood it, it's not a regression, and there is now
> just better error reporting. Did you ever get the TPM to work?

I don't personally use a TPM with Linux on the XPS 9360, but TPM was 
tested by our partners when the XPS 9360 was enabled for Ubuntu.

> 
> >> 2.  How do I find out, what TPM firmware version is installed?
> >
> > fwupd will tell you.  Documentation (and code) here:
> > https://github.com/hughsie/fwupd/tree/master/plugins/dell
> 
> Unfortuntately it's not listed with fwupd 0.7.0-0ubuntu4.3 in Ubuntu
> 16.04.3 LTS installed by Dell.

If you're unwilling to upgrade to a newer userspace, you can write 
a simple application that can use the new dell-smbios from 4.15 interface to look this up.

Most of the work is already done (see
https://github.com/torvalds/linux/blob/master/tools/wmi/dell-smbios-example.c#L179)

You'll just need to add some parsing around the output (see fwupd code) to
tell the version.  If you do this, please feel free to submit it platform-x86, it may be useful
for someone else in this sample application too.

Given you don't have a newer fwupd on your system you won't be able to "easily" flash
the newer TPM firmware.
