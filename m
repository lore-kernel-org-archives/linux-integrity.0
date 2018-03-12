Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45452 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932342AbeCLR7R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 13:59:17 -0400
Message-ID: <1520877553.4522.25.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
 buffers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 12 Mar 2018 10:59:13 -0700
In-Reply-To: <277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
         <1520720090.4495.12.camel@HansenPartnership.com>
         <277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-12 at 09:00 -0700, J Freyensee wrote:
> > 
> > +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +{
> > +	int rc;
> > +
> > +	rc = __tpm_buf_init(buf);
> 
> 
> Assuming that functions like tpm_buf_init() are the top-level API
> being defined in this patch, shouldn't it check if buf is valid
> before passing into the internal functions like __tpm_buf_init(buf)
> (maybe WARN()/BUG_ON()?).  Or does __tpm_buf_init(buf) do this check?

These are kernel internal APIs designed for on stack struct tpm_buf
usage, so I can't think of a viable threat model that would require
this type of checking ... do you have one?

James
