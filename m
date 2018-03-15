Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41645 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOQct (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 12:32:49 -0400
Message-ID: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:32:44 +0200
In-Reply-To: <20180310082428.31519-4-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> +			      recd) {
> +			total = -EFAULT;
> +			break;
> +		}
> +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);

This rlength stuff can be handled with tpm_buf_length() as I do
in my pendig-for-review patch set:

https://patchwork.kernel.org/patch/10259331/

/Jarkko
