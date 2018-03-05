Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58956 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751838AbeCEPmt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 10:42:49 -0500
Message-ID: <1520264567.5312.14.camel@HansenPartnership.com>
Subject: Re: [RFC 0/2] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org
Date: Mon, 05 Mar 2018 07:42:47 -0800
In-Reply-To: <20180305140431.GA9335@ziepe.ca>
References: <1520057094.27452.16.camel@HansenPartnership.com>
         <20180305140431.GA9335@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-05 at 07:04 -0700, Jason Gunthorpe wrote:
> On Fri, Mar 02, 2018 at 10:04:54PM -0800, James Bottomley wrote:
> > 
> > By now, everybody knows we have a problem with the TPM2_RS_PW easy
> > button on TPM2 in that transactions on the TPM bus can be
> > intercepted and altered.  The way to fix this is to use real
> > sessions for HMAC capabilities to ensure integrity and to use
> > parameter and response encryption to ensure confidentiality of the
> > data flowing over the TPM bus.
> 
> We have the same issue for TPM1 then right?

Sort of.  HMAC authentication isn't optional in TPM1 like it is in
TPM2, so we do already use it (in the trusted keys code, for instance),
so we have less of a problem becasuse it doesn't have the insecure
TPM_RS_PW option.

However, TPM1 also has a specific weakness here in that if you don't
have authority in the object (i.e. no shared secret), the HMAC provides
no protection against an intelligent attacker.  The only way to get the
same security as we have with TPM2 in this situation is to use
transport encryption.

Given that sha1 is already compromised, TPM1 has a strictly limited
shelf life, especially as all laptops are being shipped with TPM2 now,
so I don't think it's unreasonable to say if you're worried about this
compromise you should use TPM2.

James
