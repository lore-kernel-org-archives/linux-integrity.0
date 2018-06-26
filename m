Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41584 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934072AbeFZN0X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 09:26:23 -0400
Message-ID: <2bb4c098622cff2430d96f17c02b34fcef4d882e.camel@linux.intel.com>
Subject: Re: [PATCH v5 5/5] ima: Get rid of ima_used_chip and use
 ima_tpm_chip != NULL instead
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 26 Jun 2018 16:26:13 +0300
In-Reply-To: <20180626110619.2362791-6-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-6-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Get rid of ima_used_chip and use ima_tpm_chip variable instead for
> determining whether to use the TPM chip.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

(i.e. LGTM but no competence to give a detailed review).

/Jarkko
