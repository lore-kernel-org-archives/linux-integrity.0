Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753056AbeEAB4c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Apr 2018 21:56:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w411tLJU022556
        for <linux-integrity@vger.kernel.org>; Mon, 30 Apr 2018 21:56:31 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hpc92de6x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Apr 2018 21:56:31 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 02:56:29 +0100
Subject: Re: [PATCH V2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Mon, 30 Apr 2018 21:56:24 -0400
In-Reply-To: <20180427194155.41282-1-mjg59@google.com>
References: <20180427194155.41282-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525139784.5669.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-04-27 at 12:41 -0700, Matthew Garrett wrote:

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 9ea9c19a545c..86b1632d6b5b 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -35,7 +35,7 @@ static const char * const integrity_status_msg[] = {
>  };
>  int evm_hmac_attrs;
> 
> -char *evm_config_xattrnames[] = {
> +char *evm_config_default_xattrnames[] = {
>  #ifdef CONFIG_SECURITY_SELINUX
>  	XATTR_NAME_SELINUX,
>  #endif
> @@ -57,6 +57,8 @@ char *evm_config_xattrnames[] = {
>  	NULL
>  };
> 
> +LIST_HEAD(evm_config_xattrnames);
> +
>  static int evm_fixmode;
>  static int __init evm_set_fixmode(char *str)
>  {
> @@ -66,12 +68,30 @@ static int __init evm_set_fixmode(char *str)
>  }
>  __setup("evm=", evm_set_fixmode);
> 
> -static void __init evm_init_config(void)
> +static int __init evm_init_config(void)
>  {
> +	struct xattr_list *tmp;
> +	char **xattrname;
> +
> +	for (xattrname = evm_config_default_xattrnames; *xattrname != NULL;
> +	     xattrname++) {
> +		tmp = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +		tmp->name = kstrdup(*xattrname, GFP_KERNEL);
> +		if (!tmp->name) {
> +			kfree(tmp);
> +			return -ENOMEM;
> +		}
> +		list_add_tail(&tmp->list, &evm_config_xattrnames);

If evm_config_xattrnames[] is defined as struct xattr_list, there's no
need for allocating memory for the xattr_list and name.  Something
like in ima_init_policy() would work.

Could we break this patch up to simplify review?  The first patch
would create and use the xattrname list.  The subsequent patch(es)
would add the new functionality.

thanks,

Mimi

> +	}
> +
>  #ifdef CONFIG_EVM_ATTR_FSUUID
>  	evm_hmac_attrs |= EVM_ATTR_FSUUID;
>  #endif
>  	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
> +
> +	return 0;
>  }
> 
>  static bool evm_key_loaded(void)
> 
