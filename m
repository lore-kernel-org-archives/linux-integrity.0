Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeBHNSe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 08:18:34 -0500
Date: Thu, 8 Feb 2018 15:18:29 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        regression@leemhuis.info,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
Message-ID: <20180208131829.nws75cermvf2e4uq@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 08:16:26PM +0100, Paul Menzel wrote:
> > The list of "A TPM error (2314) occurred continue selftest" is caused by
> > my commit 125a2210541079e8e7c69e629ad06cabed788f8c ("tpm: React
> > correctly to
> > RC_TESTING from TPM 2.0 self tests") [1]. 2314 is TPM_RC_TESTING, so the TPM
> > tells us that self-tests are still running in the background. This problem was
> > not visible in previous versions, since it (incorrectly) ignored > TPM_RC_TESTING.
> 
> Maybe the commit should be reverted for now until this has cleared up for
> the Dell XPS 13 9360(?) to adhere to Linux' no regression policy.

I think this should be done as an immediate action with Cc to stable.

/Jarkko
