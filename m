Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:38009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965026AbeCAJWv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Mar 2018 04:22:51 -0500
Date: Thu, 1 Mar 2018 11:22:45 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and
 recv() in tpm_transmit()
Message-ID: <20180301092222.GC29420@linux.intel.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> In tpm_transmit, after send(), the code checks for status in a loop

Maybe cutting hairs now but please just use the actual function name
instead of send(). Just makes the commit log more useful asset.

> -		tpm_msleep(TPM_TIMEOUT);
> +		tpm_msleep(TPM_TIMEOUT_POLL);

What about just calling schedule()?

/Jarkko
