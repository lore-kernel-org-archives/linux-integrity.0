Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62441 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752683AbeF2Ljm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 07:39:42 -0400
Message-ID: <7dddd668a1b45670a52b04daf6c612c947dde0a6.camel@linux.intel.com>
Subject: Re: [PATCH v7 3/5] tpm: Convert tpm_find_get_ops() to use
 tpm_default_chip()
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 29 Jun 2018 14:39:37 +0300
In-Reply-To: <20180626190933.2508821-4-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
         <20180626190933.2508821-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
