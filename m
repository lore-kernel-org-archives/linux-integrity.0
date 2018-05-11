Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751857AbeEKEEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 00:04:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B3wm7x101884
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 00:04:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hw1qq486b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 00:04:13 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 05:04:11 +0100
Subject: Re: [PATCH V4 1/2] EVM: turn evm_config_xattrnames into a list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
In-Reply-To: <20180509202811.29875-1-mjg59@google.com>
References: <20180509202811.29875-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 May 2018 00:03:24 -0400
Mime-Version: 1.0
Message-Id: <1526011404.3414.4.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-05-09 at 13:28 -0700, Matthew Garrett wrote:

> @@ -565,10 +588,11 @@ static int __init init_evm(void)
>   */
>  static int __init evm_display_config(void)
>  {
> -	char **xattrname;
> +	struct xattr_list *xattr;
> +
> +	list_for_each_entry(xattr, &evm_config_xattrnames, list)
> +		pr_info("%s\n", xattr->name);
> 
> -	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++)
> -		pr_info("%s\n", *xattrname);
>  	return 0;
>  }
> 

The list is only created in init_evm(), which is initialized at
late_initcall(), yet here we're displaying the list at
pure_initcall().  None of the xattrs are being displayed.

Mimi
