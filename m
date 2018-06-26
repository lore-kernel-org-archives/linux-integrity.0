Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeFZNTH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 09:19:07 -0400
Message-ID: <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/5] tpm: rename tpm_chip_find_get() to
 tpm_find_get_ops()
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 26 Jun 2018 16:18:57 +0300
In-Reply-To: <20180626110619.2362791-2-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-2-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
> the tpm_put_ops() counter part.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Awesome, makes sense by itself alone. Thanks Stefan. If we need
follow up versions, no need to include this patch. I would take
it even if the whole patch set was discarded for whatever reason.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
