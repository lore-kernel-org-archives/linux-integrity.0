Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37767 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDQDCG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Apr 2018 23:02:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id p6so11479830pfn.4
        for <linux-integrity@vger.kernel.org>; Mon, 16 Apr 2018 20:02:06 -0700 (PDT)
Date: Mon, 16 Apr 2018 21:02:02 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thiebaud Weksteen <tweek@google.com>
Cc: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Add explicit endianness cast
Message-ID: <20180417030202.GA30624@ziepe.ca>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-2-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412101350.210547-2-tweek@google.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:13:47PM +0200, Thiebaud Weksteen wrote:
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
>  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
> index 96fd5646f866..d74568d58a66 100644
> +++ b/drivers/char/tpm/tpm_eventlog_of.c
> @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	 * but physical tpm needs the conversion.
>  	 */
>  	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> -		size = be32_to_cpup(sizep);
> -		base = be64_to_cpup(basep);
> +		size = be32_to_cpup((__be32 *)sizep);
> +		base = be64_to_cpup((__be64 *)basep);

Er, no.. change the definitions of sizep and basep to be __be

Jason
