Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:59422 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLLA2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 07:00:28 -0400
Message-ID: <5546fb07e9f45b0d501cfe9b6ee62712153ef32f.camel@linux.intel.com>
Subject: Re: [RFC 0/5] add integrity and security to TPM2 transactions
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 12 Mar 2018 13:00:26 +0200
In-Reply-To: <1520706580.4495.4.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
         <18e2f4debbbc05ed4169d3eb263479df91941aa0.camel@linux.intel.com>
         <1520706580.4495.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:29 -0800, James Bottomley wrote:
> OK, you might want to wait for v3 then.  I've got it working with
> sealed (trusted) keys, well except for a problem with the trusted keys
> API that means we can't protect the password for policy based keys.  I
> think the API is finally complete, so I'll send v3 as a PATCH not an
> RFC.
> 
> The point of the last patch is to show the test rig for this I'm
> running in a VM using an instrumented tpm2 emulator to prove we're
> getting all the correct data in and out (and that the encryption and
> hmac are working); more physical TPM testing would be useful ..

Sorry, I did not notice this email in my inbox before I responded
to you v3 cover letter :-) Thank you.

/Jarkko
