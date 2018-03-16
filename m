Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:27330 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbeCPL6N (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 07:58:13 -0400
Message-ID: <6da309e727bec176fed7253ba5276f47f784d759.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM
 buffers
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Fri, 16 Mar 2018 13:58:08 +0200
In-Reply-To: <1520720090.4495.12.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
         <1520720090.4495.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 14:14 -0800, James Bottomley wrote:
>  	TPM_BUF_OVERFLOW	= BIT(0),
> +	TPM_BUF_2B		= BIT(1),

Instead of re-using this I would prefer to have another enum for
buffer type. tpm_buf_init() could have the signature:

int tpm_buf_init(unsigned int type);

For commands there should be a function:

void tpm_buf_set_command_header(struct tpm_buf *buf, u16 tag, u32 ordinal);

And tpm_buf_append_2b() should not exist at all. It should be
maintained automatically by other append commands.

/Jarkko
