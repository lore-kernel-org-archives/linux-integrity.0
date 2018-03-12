Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38873 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932510AbeCLQAs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 12:00:48 -0400
Subject: Re: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
 buffers
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
 <1520720090.4495.12.camel@HansenPartnership.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <277bd8a1-9e7f-f6e8-bede-5208f0456adf@gmail.com>
Date: Mon, 12 Mar 2018 09:00:42 -0700
MIME-Version: 1.0
In-Reply-To: <1520720090.4495.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);


Assuming that functions like tpm_buf_init() are the top-level API being 
defined in this patch, shouldn't it check if buf is valid before passing 
into the internal functions like __tpm_buf_init(buf) (maybe 
WARN()/BUG_ON()?).  Or does __tpm_buf_init(buf) do this check?

Thanks,
Jay
