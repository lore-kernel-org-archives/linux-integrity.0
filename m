Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41473 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934072AbeFZNW7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 09:22:59 -0400
Message-ID: <19062c6c3e07dbd24680f9d56c4bb73fd5154608.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/5] tpm: Implement tpm_default_chip() to find a TPM
 chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 26 Jun 2018 16:22:53 +0300
In-Reply-To: <20180626110619.2362791-3-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Implement tpm_default_chip() to find a TPM chip and get a reference to it.
> This function is also suitable for other subsystems to call and hold onto
> the chip.

Please make the commit message a bit more verbose i.e. explain what this
tpm_default_chip() is and what it is used for.

/Jarkko
