Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46692 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeHUVwZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Aug 2018 17:52:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id a4-v6so5684478plm.13
        for <linux-integrity@vger.kernel.org>; Tue, 21 Aug 2018 11:31:10 -0700 (PDT)
Date: Tue, 21 Aug 2018 12:31:08 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com,
        jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 04/23] TPM: Expose struct tpm_chip and related find_get
 and put functions
Message-ID: <20180821183108.GC25543@ziepe.ca>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Aug 21, 2018 at 04:57:16PM +0100, David Howells wrote:
> Expose struct tpm_chip and related find_get and put functions so that
> TPM-using code can make sure it uses the same TPM for any related set of
> operations.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---

>  drivers/char/tpm/tpm-interface.c |   19 ++++++++++++++++---
>  drivers/char/tpm/tpm.h           |    5 -----
>  include/linux/tpm.h              |   10 ++++++++++
>  3 files changed, 26 insertions(+), 8 deletions(-)

I think this is already in the kernel .. Stephen did it.

Jason
