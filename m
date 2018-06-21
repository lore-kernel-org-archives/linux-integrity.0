Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:59336 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbeFURPd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 13:15:33 -0400
Date: Thu, 21 Jun 2018 20:15:18 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621171518.GI11859@linux.intel.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip. Once done with using the chip, the reference
> is released using tpm_chip_put().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

You should sort this out in a way that we don't end up with duplicate
functions.

/Jarkko
