Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932368AbeCKWGu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Mar 2018 18:06:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2BM4U8t047993
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 18:06:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gn2xadc5d-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 18:06:50 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 11 Mar 2018 22:06:47 -0000
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jiandi An <anjiandi@codeaurora.org>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Sun, 11 Mar 2018 18:06:41 -0400
In-Reply-To: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520806001.3547.10.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-06 at 23:26 -0600, Jiandi An wrote:
> TPM_CRB driver is the TPM support for ARM64.  If it
> is built as module, TPM chip is registered after IMA
> init.  tpm_pcr_read() in IMA driver would fail and
> display the following message even though eventually
> there is TPM chip on the system:
> 
> ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> 
> Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> built in kernel and initializes before IMA driver.
> 
> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>

Thanks, this patch has been applied.

Mimi

> ---
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 35ef693..6a8f677 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -10,6 +10,7 @@ config IMA
>  	select CRYPTO_HASH_INFO
>  	select TCG_TPM if HAS_IOMEM && !UML
>  	select TCG_TIS if TCG_TPM && X86
> +	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
>  	help
>  	  The Trusted Computing Group(TCG) runtime Integrity
