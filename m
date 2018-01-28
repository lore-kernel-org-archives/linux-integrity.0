Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55380 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752008AbeA1RjS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 12:39:18 -0500
Message-ID: <1517161157.3082.41.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: Add backward compatible support for
 openssl 1.1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Sun, 28 Jan 2018 09:39:17 -0800
In-Reply-To: <1517157665.3082.17.camel@HansenPartnership.com>
References: <1517157665.3082.17.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-01-28 at 08:41 -0800, James Bottomley wrote:
> Openssl 1.1 is really annoying in that it made certain objects opaque
> and added accessors for the necessary components, but these accessors
> often don't exist in 1.0 and before, so there's no way to create
> clean code that will compile with both 1.0 and 1.1; instead you have
> to compiled with both code bases to make sure everything is working.
> 
> The other problem is that since the structures are opaque, their size
> isn't known, so having a structure declared as a variable is no
> longer possible.
> 
> This change switches all uses of EVP_MD_CTX to be pointers
> initialised with the correct EVP_MD_CTX_new() (not available in 1.0),
> does the same for HMAC_CTX, and uses the 1.1 only primitive
> RSA_get0_key() to extract the public modulus and exponent from an RSA
> key.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com
> >
> Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

OK, let me try that again without the line breaks.

James
