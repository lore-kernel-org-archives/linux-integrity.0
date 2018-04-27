Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47479 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeD0Jcx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Apr 2018 05:32:53 -0400
Date: Fri, 27 Apr 2018 11:32:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
Message-ID: <20180427093250.h5myocnvwgrfij34@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <1524759504.3647.12.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1524759504.3647.12.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

> > * ima_measurements.sh
> >   - don't require iversion for kernel >= 4.16
> >   - avoid using tmpfs

> This is working nicely!
:).


...
> test: cmdline="ima_policy.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> ima_policy 1 TINFO: verify that invalid policy isn't loaded
> ima_policy 1 TPASS: didn't load invalid policy
> ima_policy 2 TINFO: verify that policy file is not opened concurrently
> and able to loaded multiple times
> ima_policy 2 TFAIL: problem with loading policy (policy should be able
> to load multiple times)

> For now, could we change "problem with loading policy (policy should
> be able to load multiple times)" to say, "problem loading or extending
> policy (may require policy to be signed)"?
Sure, thanks!


> I'm also seeing, 

> test: ima_tpm
> <<<test_output>>>
> ima_tpm 1 TINFO: verify boot aggregate
> ima_tpm 1 TPASS: bios aggregate matches IMA boot aggregate
> ima_tpm 2 TINFO: verify PCR values
> ima_tpm 2 TINFO: evmctl version: evmctl 1.0
> ima_tpm 2 TINFO: new PCRS path, evmctl >= 1.1 required
> ima_tpm 2 TINFO: verify PCR (Process Control Register)
> ima_tpm 2 TFAIL: failed to get PCR-10
> ima_tpm 2 TPASS: aggregate PCR value matches real PCR value

> It's unclear how the script could fail to get PCR-10, but pass the
> following test.
Thanks, fixed (wrong return).

> Mimi


Kind regards,
Petr
