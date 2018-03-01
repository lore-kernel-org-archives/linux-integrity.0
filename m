Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41374 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161969AbeCAWKZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Mar 2018 17:10:25 -0500
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
Date: Thu, 1 Mar 2018 14:10:17 -0800
MIME-Version: 1.0
In-Reply-To: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

.
.
.
I'm new to this area of the kernel, but I'm not getting these lines:

> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	tpm_buf_destroy(&buf);
>   	if (rc <  0)
Why is this if() check not directly after the tpm_transmit_cmd() call 
that sets rc?  Is it correct you want to destroy buf regardless of the 
tpm_transmit_cmd() outcome?
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	out = (struct tpm_output_header *)buf.data;

So buf has been destroyed, buf.data sill has something valid to assign 
to out?
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
>   
>   	return 0;
Thanks,
Jay
