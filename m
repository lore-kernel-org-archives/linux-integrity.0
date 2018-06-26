Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4008 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934072AbeFZN0E (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 09:26:04 -0400
Message-ID: <fbf7822a1c6a07adad22a5afbb0eb4de48e2d48e.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/5] ima: Use tpm_default_chip() and call TPM
 functions with a tpm_chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 26 Jun 2018 16:25:44 +0300
In-Reply-To: <20180626110619.2362791-5-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-5-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Rather than accessing the TPM functions by passing a NULL pointer for
> the tpm_chip, which causes a lookup for a suitable chip every time, get a
> hold of a tpm_chip and access the TPM functions using it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

(i.e. LGTM but competence to give a detailed review).

/Jarkko
