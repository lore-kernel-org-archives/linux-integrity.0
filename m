Return-Path: <SRS0=uUqS=3M=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A63C2D0DB
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jan 2020 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C2524655
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jan 2020 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgAWMWM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:22:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:44063 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMWM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 07:22:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 04:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="220650513"
Received: from wkalinsk-mobl.ger.corp.intel.com ([10.252.23.16])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2020 04:22:06 -0800
Message-ID: <0effdeeeccdb9544cc69f185fd23cd06828ae8fc.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string
 for SynQuacer TPM
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 14:22:05 +0200
In-Reply-To: <20200114141647.109347-2-ardb@kernel.org>
References: <20200114141647.109347-1-ardb@kernel.org>
         <20200114141647.109347-2-ardb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> Add a compatible string for the SynQuacer TPM to the binding for a
> TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> slightly differently on this hardware, so it requires its own
> identifier.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> index 7c6304426da1..b604c8688dc8 100644
> --- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> @@ -12,6 +12,7 @@ Required properties:
>  - compatible: should contain a string below for the chip, followed by
>                "tcg,tpm-tis-mmio". Valid chip strings are:
>  	          * "atmel,at97sc3204"
> +		  * "socionext,synquacer-tpm-mmio"
>  - reg: The location of the MMIO registers, should be at least 0x5000 bytes
>  - interrupts: An optional interrupt indicating command completion.
>  

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Someone else needs to give reviewed-by as I am not expert on DT bindings.

/Jarkko

