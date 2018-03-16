Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:30723 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753058AbeCPNeG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 09:34:06 -0400
Date: Fri, 16 Mar 2018 15:34:02 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 0/6] add integrity and security to TPM2 transactions
Message-ID: <20180316133402.GA7387@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
 <4aa8a4daf4b2f9f76f86b07bbdcb2f4c06b69a98.camel@linux.intel.com>
 <1520870233.4522.20.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520870233.4522.20.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 12, 2018 at 08:57:13AM -0700, James Bottomley wrote:
> I think the way I'm going to fix the trusted key policy problem is to
> move it back into the kernel for the simple PCR lock policy (which will
> make changing from 1.2 to 2.0 seamless because the external Key API
> will then become the same) so the kernel gets the missing TPM nonce and
> can then do TPM2_PolicyAuthValue.

Sounds reasonable.

> User generated policy sessions for trusted keys are very flexible but
> also a hugely bad idea for consumers because it's so different from the
> way 1.2 works and it means now the user has to exercise a TPM API to
> produce the policy sessions.
> 
> Longer term, I think having a particular trusted key represent a policy
> session which can then be attached to a different trusted key
> representing the blob is the best idea because we can expose the policy
> build up via the trusted key API and keep all the TPM nastiness inside
> the kernel.

/Jarkko
