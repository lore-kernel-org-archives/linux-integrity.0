Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:45470 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755206AbeF2MNP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 08:13:15 -0400
Message-ID: <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
Subject: Re: [PATCH v7 0/5] Have IMA find and use a tpm_chip until system
 shutdown
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 29 Jun 2018 15:13:09 +0300
In-Reply-To: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> This series of patches converts IMA's usage of the tpm_chip to find a TPM
> chip initially and use it until the machine is shut down. To do this we need
> to introduce a kref for the tpm_chip that IMA and all other users of a
> tpm_chip hold onto until they don't need the TPM chip anymore.

All the TPM patches are now in my tree and I just updated also the
next branch so they should be soon available also in linux-next.

/Jarkko
