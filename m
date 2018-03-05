Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:39084 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933579AbeCEOEg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 09:04:36 -0500
Received: by mail-pg0-f53.google.com with SMTP id e3so2161591pga.6
        for <linux-integrity@vger.kernel.org>; Mon, 05 Mar 2018 06:04:36 -0800 (PST)
Date: Mon, 5 Mar 2018 07:04:31 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC 0/2] add integrity and security to TPM2 transactions
Message-ID: <20180305140431.GA9335@ziepe.ca>
References: <1520057094.27452.16.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1520057094.27452.16.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Mar 02, 2018 at 10:04:54PM -0800, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.

We have the same issue for TPM1 then right?

Jason
