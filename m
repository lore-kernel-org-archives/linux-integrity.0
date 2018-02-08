Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20814 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeBHNDg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 08:03:36 -0500
Date: Thu, 8 Feb 2018 15:03:32 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180208130332.qsvbcoq63qypfozm@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1517488970.3251.26.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 12:42:50PM +0000, James Bottomley wrote:
> OK, I'll try to find a fix.  It's clearly a marginal problem since I've
> booted most -rc kernels without issue, so there's some slight timing
> change in 4.15 that triggered it.  It could also be a shutdown issue.
>  Any NV ram stuff deferred to start up would take a variable amount of
> time.
> 
> You'd almost think it's some sort of TPM self protest: the more stuff I
> use it for the more problems it seems to create.  I'm definitely
> motivated to fix it because without a TPM I can't actually do much with
> my laptop.

I checked what was landed to 4.15:

* 125a22105410 ("tpm: React correctly to RC_TESTING from TPM 2.0 self tests")
* 87434f58be31 ("tpm: Use dynamic delay to wait for TPM 2.0 self test result")
* 2482b1bba512 ("tpm: Trigger only missing TPM 2.0 self tests")

/Jarkko
