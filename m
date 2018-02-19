Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50482 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752655AbeBSMVf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 07:21:35 -0500
Message-ID: <1519042888.4721.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Feb 2018 07:21:28 -0500
In-Reply-To: <1518813108.4419.3.camel@HansenPartnership.com>
References: <1518813108.4419.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 12:31 -0800, James Bottomley wrote:
> Ever since
> 
> commit 2482b1bba5122b1d5516c909832bdd282015b8e9
> Author: Alexander Steffen <Alexander.Steffen@infineon.com>
> Date:   Thu Aug 31 19:18:56 2017 +0200
> 
>     tpm: Trigger only missing TPM 2.0 self tests
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
> work (necessitating a reboot). The problem seems to be that the TPM
> gets into a state where the partial self-test doesn't return
> TPM_RC_SUCCESS (meaning all tests have run to completion), but
> instead
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
> TPM_RC_TESTING returns (which it might if they send a command
> that needs a TPM subsystem which is still under test), we loop in
> tpm_transmit_cmd until either a timeout or we don't get a
> TPM_RC_TESTING return.

Having run this through a TPM emulator, there's one additional return
that needs to be accounted for: for TPMs that don't get a startup from
the BIOS return TPM_RC_INITIALIZE which is used to trigger the startup
sequence.  I'll send a v3 with this fixed.

James
