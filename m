Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51218 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeCLK6a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 06:58:30 -0400
Message-ID: <4aa8a4daf4b2f9f76f86b07bbdcb2f4c06b69a98.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/6] add integrity and security to TPM2 transactions
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 12 Mar 2018 12:58:27 +0200
In-Reply-To: <1520720026.4495.11.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 14:13 -0800, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.
> 
> This patch series is about adding a simple API which can ensure the
> above properties as a layered addition to the existing TPM handling
> code.  This series now includes protections for PCR extend, getting
> random numbers from the TPM and data sealing and unsealing.  It
> therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
> encryption protection to sensitive data flowing into and out of the
> TPM.
> 
> This series is also dependent on additions to the crypto subsystem to
> fix problems in the elliptic curve key handling and add the Cipher
> FeedBack encryption scheme:
> 
> https://marc.info/?l=linux-crypto-vger&m=151994371015475
> 
> In the third version I've added data sealing and unsealing protection,
> apart from one API based problem which means that the way trusted keys
> were protected it's not currently possible to HMAC protect an authority
> that comes with a policy, so the API will have to be extended to fix
> that case
> 
> I've verified this using the test suite in the last patch on a VM
> connected to a tpm2 emulator.  I also instrumented the emulator to make
> sure the sensitive data was properly encrypted.
> 
> James

1. Can I ignore v2 and just review/test this version? I haven't even
   peeked into v2 yet.
2. Do you know in which kernel version will the crypto additions land?

/Jarkko
