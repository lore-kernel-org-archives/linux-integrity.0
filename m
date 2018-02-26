Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25790 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeBZMJq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Feb 2018 07:09:46 -0500
Message-ID: <1519646980.12825.4.camel@linux.intel.com>
Subject: Re: [PATCH 1/2 v5] tpm: cmd_ready command can be issued only after
 granting locality
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Feb 2018 14:09:40 +0200
In-Reply-To: <20180225120049.29308-1-tomas.winkler@intel.com>
References: <20180225120049.29308-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-02-25 at 14:00 +0200, Tomas Winkler wrote:
>  	if (need_locality && chip->ops->relinquish_locality) {
> -		chip->ops->relinquish_locality(chip, chip->locality);
> +		/* this coud be on error path, don't override error code */
> +		int l_rc = chip->ops->relinquish_locality(chip, chip-
> >locality);
> +
> +		if (l_rc)
> +			dev_err(&chip->dev, "%s: relinquish_locality: error
> %d\n",
> +				__func__, l_rc);
> +
>  		chip->locality = -1;
>  	}

The 'l_rc' declaration causes NAK as I've stated before.

Why don't you just make a helper function:

static void tpm_relinquish_locality(struct tpm_chip *chip)
{
	int rc;

	if (!chip->ops->relinquish_locality)
		return 0;

	rc = chip->ops->relinquish_locality(chip);
	if (rc)
		dev_err(&chip->dev, "%s: error %d\n", __func__, rc);

	chip->locality = -1;
}

Then the original code would be simply:

if (need_locality)
	tpm_relinquish_locality(chip);

/Jarkko
