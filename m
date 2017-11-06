Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:35580 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdKFV0m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 16:26:42 -0500
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: IMA skips some file measurements
Date: Mon, 6 Nov 2017 21:26:38 +0000
Message-ID: <TU4PR84MB03028A1CDA4AD6F77368F730FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB03023D92432F2AA6E9348873FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
 <1510000742.3320.5.camel@linux.vnet.ibm.com>
In-Reply-To: <1510000742.3320.5.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Mimi Zohar [mailto:zohar@linux.vnet.ibm.com]
> Sent: segunda-feira, 6 de novembro de 2017 18:39
> To: Magalhaes, Guilherme (Brazil R&D-CL)
> <guilherme.magalhaes@hpe.com>; linux-integrity@vger.kernel.org
> Subject: Re: IMA skips some file measurements
> 
> On Mon, 2017-11-06 at 19:22 +0000, Magalhaes, Guilherme (Brazil R&D-
> CL) wrote:
> > We are trying to understand why some file measurements are skipped
> > by IMA. In some circumstances, it seems that this could lead to an
> > incorrect assessment of the integrity of the host. Consider the
> > following, example in which we begin with a vulnerable bash binary
> > (e.g. Shellshock) and patch it.
> >
> > 1. Load vulnerable bash (measured by IMA)
> > 2. Patch the bash file
> > 3. Load good bash (measured by IMA)
> > 4. Change back to vulnerable bash
> > 5. Load vulnerable bash (not measured by IMA)
> >
> > After step 5, the IMA logs appear to tell you that the system is using a
> > good binary, but a vulnerable binary is installed and being used.
> >
> > We identified that 'ima_htable.queue' prevented the measurement at
> > step 5 since the same vulnerable bash was loaded on step 1 and 5 and
> > then its respective hash was already present in 'ima_htable.queue'.
> >
> > So in this scenario the last/current file state is not identified using the
> > IMA log. Is it not important to identify through the IMA log whether or
> > not the last known file state is good?
> >
> > Does anybody know why 'ima_htable.queue' is preventing already
> > logged file hashes from being re-measured?
> 
> Yes, we're trying to limit the number of measurements.  This is a last
> check before adding something already measured to the measurement list
> and extending the TPM.
> 
> For example, a file is removed from dcache, causing the iint to be
> deleted as well.  The next access would cause the entry to be re-added
> to the measurement list and extend the TPM for no good reason.
A side effect for this mechanism is that IMA skips measuring a changed file
in case the file is changed to a state already measured before, as 
demonstrated by the example I enumerated above. Then, it could lead to an 
incorrect integrity assessment considering the last file state/hash may not be 
in the IMA log.

So I assume it is a side effect and not working by design. Please, clarify.

--
Guilherme

> 
> Mimi
