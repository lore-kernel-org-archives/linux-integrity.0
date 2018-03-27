Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750914AbeC0ToW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Mar 2018 15:44:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2RJf5A0014773
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 15:44:21 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gys8d8wjy-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 15:44:21 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 27 Mar 2018 20:44:19 +0100
Subject: Re: [RFC PATCH v2 3/4] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 8k
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@us.ibm.com>
Date: Tue, 27 Mar 2018 15:44:15 -0400
In-Reply-To: <20180314155731.5943-4-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
         <20180314155731.5943-4-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1522179855.3541.191.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing George Wilson]

On Wed, 2018-03-14 at 16:57 +0100, Petr Vorel wrote:
> This is needed as according IMA developers there are BIOS events larger
> than 4k [1]. Actual size for TPM 1.2 is undefined, TPM 2.0 specifies:
> "For software parsing the event log, the parser can choose an arbitrary
> maximum size, but this specification recommends a maximum value for the
> TCG_PCR_EVENT2.eventSize field of 1MB." [2].
> 
> So hope 8k is enough.

Is there a way of making this value system dependent?  On my 
laptop this is fine, but for PowerVM w/TPM 1.2 I've been told this is
too small.

> [1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
> [2] http://lists.linux.it/pipermail/ltp/2018-January/007002.html
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index f7ae77cb1..c52cea4c9 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -30,7 +30,7 @@ char *TCID = "ima_boot_aggregate";
>  #if HAVE_LIBCRYPTO
>  #include <openssl/sha.h>
> 
> -#define MAX_EVENT_SIZE 500
> +#define MAX_EVENT_SIZE 8192
>  #define EVENT_HEADER_SIZE 32
>  #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
>  #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */
