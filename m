Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFIJb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 03:09:31 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Date: Tue, 6 Mar 2018 08:09:26 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F018@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180305125642.GA3425@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
 <20180305175912.GD5791@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E568@hasmsx108.ger.corp.intel.com>
 <20180306080159.GC3624@linux.intel.com>
In-Reply-To: <20180306080159.GC3624@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> 
> On Mon, Mar 05, 2018 at 06:04:56PM +0000, Winkler, Tomas wrote:
> > >
> > > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > > > enum tpm_duration {
> > > > > 	TPM_DURATION_DEFAULT = 2000,
> > > > > 	TPM_DURATION_LONG = 300000,
> > > > > };
> > > > >
> > > > How is this aligned with the spec PTP spec?
> > >
> > > For TPM 2.0 that spec only partially defines durations for CCs and
> > > thus our look up table is already kind "flakky". In a sense that the
> > > default duration is upper limit for spec defined durations.
> >
> > The timeouts for LONG and MEDIUM is defined by the  PTP spec,  we need
> to maintain those as those effect the system.
> > The UNDEFINED and LONG LONG is the implementation choice we driver
> from empirical data we have so far.
> 
> Where can be get this empirical data?
>From testing the HW.
> 
> You are not only adding 30s delay but also turning the 2s delay to 12s delay.


I'm adding 3 min, no other changes.  Where is 12s?

> IMHO we could very well use PTP LONG for all commands as the timeout.
> Why that would not work?


Empirically it doesn't go test it you have the HW.

Thanks
Tomas
