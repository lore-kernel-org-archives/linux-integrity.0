Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9788 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPMCk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 08:02:40 -0400
Message-ID: <f1521f6afa2e89ce666503148d6fad425cb5b813.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
 buffers
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Fri, 16 Mar 2018 14:02:26 +0200
In-Reply-To: <6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
         <1520720090.4495.12.camel@HansenPartnership.com>
         <6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-16 at 13:58 +0200, Jarkko Sakkinen wrote:
> On Sat, 2018-03-10 at 14:14 -0800, James Bottomley wrote:
> >  	TPM_BUF_OVERFLOW	= BIT(0),
> > +	TPM_BUF_2B		= BIT(1),
> 
> Instead of re-using this I would prefer to have another enum for
> buffer type. tpm_buf_init() could have the signature:
> 
> int tpm_buf_init(unsigned int type);
> 
> For commands there should be a function:
> 
> void tpm_buf_set_command_header(struct tpm_buf *buf, u16 tag, u32 ordinal);
> 
> And tpm_buf_append_2b() should not exist at all. It should be
> maintained automatically by other append commands.

Can you send the next version this patch as a separate entity? Once
I can land this we have kind of stable ground for the following
patches. After that it is easier test and review them.

/Jarkko
