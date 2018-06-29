Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38966 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932331AbeF2LgX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 07:36:23 -0400
Message-ID: <d6ffc33cc0870a097fc261e78b4bb3b4eed47f52.camel@linux.intel.com>
Subject: Re: [PATCH v7 2/5] tpm: Implement tpm_default_chip() to find a TPM
 chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 29 Jun 2018 14:36:17 +0300
In-Reply-To: <20180626190933.2508821-3-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
         <20180626190933.2508821-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> Implement tpm_default_chip() to find the first TPM chip and return it to
> the caller while increasing the reference count on its device. This
> function can be used by other subsystems, such as IMA, to find the system's
> default TPM chip and use it for all subsequent TPM operations.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
