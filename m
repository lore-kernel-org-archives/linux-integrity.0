Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753261AbdJMXgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Oct 2017 19:36:18 -0400
Subject: Re: [PATCH] EVM: Include security.apparmor in EVM measurements
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com
References: <20171013220925.6420-1-mjg59@google.com>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <eaabb1e3-4cfe-653b-a1a8-8dabd5f24e06@canonical.com>
Date: Fri, 13 Oct 2017 16:36:13 -0700
MIME-Version: 1.0
In-Reply-To: <20171013220925.6420-1-mjg59@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 10/13/2017 03:09 PM, Matthew Garrett wrote:
> Apparmor will be gaining support for security.apparmor labels, and it
> would be helpful to include these in EVM validation now so appropriate
> signatures can be generated even before full support is merged.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: John Johansen <John.johansen@canonical.com>


> ---
>  include/uapi/linux/xattr.h        | 3 +++
>  security/integrity/evm/evm_main.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 1590c49cae57..e630b9cd70cb 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -65,6 +65,9 @@
>  #define XATTR_NAME_SMACKTRANSMUTE XATTR_SECURITY_PREFIX XATTR_SMACK_TRANSMUTE
>  #define XATTR_NAME_SMACKMMAP XATTR_SECURITY_PREFIX XATTR_SMACK_MMAP
>  
> +#define XATTR_APPARMOR_SUFFIX "apparmor"
> +#define XATTR_NAME_APPARMOR XATTR_SECURITY_PREFIX XATTR_APPARMOR_SUFFIX
> +
>  #define XATTR_CAPS_SUFFIX "capability"
>  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
>  
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 40bf3a20605d..78a5b1fddfc7 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -49,6 +49,9 @@ char *evm_config_xattrnames[] = {
>  	XATTR_NAME_SMACKMMAP,
>  #endif
>  #endif
> +#ifdef CONFIG_SECURITY_APPARMOR
> +	XATTR_NAME_APPARMOR,
> +#endif
>  #ifdef CONFIG_IMA_APPRAISE
>  	XATTR_NAME_IMA,
>  #endif
> 
