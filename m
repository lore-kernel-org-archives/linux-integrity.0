Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49483 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeBUHEo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 02:04:44 -0500
Subject: Re: [PATCH v3] tpm: fix intermittent failure with self tests
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <1519043040.4721.5.camel@HansenPartnership.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <7f00fe85-8943-54f0-3313-8b81db7b9b2f@molgen.mpg.de>
Date: Wed, 21 Feb 2018 08:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <1519043040.4721.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear James,


Am 19.02.2018 um 13:24 schrieb James Bottomley:
> Ever since
> 
> commit 2482b1bba5122b1d5516c909832bdd282015b8e9
> Author: Alexander Steffen <Alexander.Steffen@infineon.com>
> Date:   Thu Aug 31 19:18:56 2017 +0200
> 
>      tpm: Trigger only missing TPM 2.0 self tests
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
> work (necessitating a reboot). The problem seems to be that the TPM
> gets into a state where the partial self-test doesn't return
> TPM_RC_SUCCESS (meaning all tests have run to completion), but instead
> returns TPM_RC_TESTING (meaning some tests are still running in the
> background).  There are various theories that resending the self-test
> command actually causes the tests to restart and thus triggers more
> TPM_RC_TESTING returns until the timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down
> the boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that
> have passed and if it gets a failure return TPM_RC_FAILURE to every
> subsequent command.  So the fix is to kick off self tests once and if
> they return TPM_RC_TESTING log that as a backgrounded self test and
> continue on.  In order to prevent other tpm users from seeing any
> TPM_RC_TESTING returns (which it might if they send a command that
> needs a TPM subsystem which is still under test), we loop in
> tpm_transmit_cmd until either a timeout or we don't get a
> TPM_RC_TESTING return.
> 
> Finally, there have been observations of strange returns from a
> partial test. One Nuvoton is occasionally returning
> TPM_RC_COMMAND_CODE, so treat any unexpected return from a partial
> self test as an indication we need to run a full self test.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 2482b1bba5122b1d5516c909832bdd282015b8e9

Thank you for fixing the regression. Could you tag this for stable too, 
or does this subsystem handle this differently?


Kind regards,

Paul
