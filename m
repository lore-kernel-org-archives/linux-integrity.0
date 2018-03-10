Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40573 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeCJMty (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Mar 2018 07:49:54 -0500
Message-ID: <18e2f4debbbc05ed4169d3eb263479df91941aa0.camel@linux.intel.com>
Subject: Re: [RFC 0/5] add integrity and security to TPM2 transactions
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Sat, 10 Mar 2018 14:49:48 +0200
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-07 at 15:29 -0800, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.
> 
> This RFC is about adding a simple API which can ensure the above
> properties as a layered addition to the existing TPM handling code.
>  Eventually we can add this to the random number generator, the PCR
> extensions and the trusted key handling, but this all depends on the
> conversion to tpm_buf which is not yet upstream, so I've constructed a
> second patch which demonstrates the new API in a test module for those
> who wish to play with it.
> 
> This series is also dependent on additions to the crypto subsystem to
> fix problems in the elliptic curve key handling and add the Cipher
> FeedBack encryption scheme:
> 
> https://marc.info/?l=linux-crypto-vger&m=151994371015475
> 
> In the second version, I added security HMAC to our PCR extend and
> encryption to the returned random number generators and also extracted
> the parsing and tpm2b construction API into a new file.
> 
> James

Might take up until end of next week before I have time to try this out.
Anyway, I'll see if I get this running on my systems before at the code
that much.

/Jarkko
