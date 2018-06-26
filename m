Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14919 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934199AbeFZNVs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 09:21:48 -0400
Message-ID: <0084b7ca7e5b9a48f4f8354805eed8b3c44f90c3.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/5] tpm: rename tpm_chip_find_get() to
 tpm_find_get_ops()
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 26 Jun 2018 16:21:40 +0300
In-Reply-To: <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-2-stefanb@linux.vnet.ibm.com>
         <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 16:18 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> > Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
> > the tpm_put_ops() counter part.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> Awesome, makes sense by itself alone. Thanks Stefan. If we need
> follow up versions, no need to include this patch. I would take
> it even if the whole patch set was discarded for whatever reason.
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already pushed to my master. Kind of waiting James to rebase his
tree before moving stuff to next.

/Jarkko
