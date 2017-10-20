Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752172AbdJTKKc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 06:10:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9KA9Zmm000736
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 06:10:31 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dqdha4tum-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 06:10:31 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 20 Oct 2017 11:10:29 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9KAAOOn28180570
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 10:10:26 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9KAAPit030503
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 21:10:25 +1100
Subject: Re: [PATCH] EVM: Allow userland to permit modification of
 EVM-protected xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Fri, 20 Oct 2017 06:10:21 -0400
In-Reply-To: <20171019225739.4196-1-mjg59@google.com>
References: <20171019225739.4196-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508494221.3268.70.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index 319cf16d6603..0ce5134d3de5 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -81,6 +81,10 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
>  			return ret;
>  		/* Forbid further writes after the symmetric key is loaded */
>  		i |= EVM_SETUP;
> +		/* Don't allow protected xattr modification if a
> +		 * symmetric key is loaded
> +		 */
> +		i &= ~(EVM_PERMIT_XATTR_WRITES);
>  	}
> 
>  	evm_initialized |= i;

Is "|= i" now correct?
