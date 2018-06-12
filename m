Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934156AbeFLXmk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jun 2018 19:42:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CNchqK035281
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jun 2018 19:42:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jjpc6k72w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jun 2018 19:42:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 00:42:37 +0100
Subject: Re: [USER] [PATCH 2/2] Add security.apparmor to the set of extended
 attributes used by EVM
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Tue, 12 Jun 2018 19:42:34 -0400
In-Reply-To: <20180417225601.6965-2-mjg59@google.com>
References: <20180417225601.6965-1-mjg59@google.com>
         <20180417225601.6965-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528846954.3874.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:
> The kernel is taking security.apparmor into account when validating EVM,
> so evmctl should be doing the same.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

The XATTR_NAME_APPARMOR is dependent on the version of
"/usr/include/linux/xattr.h".  Without it defined, evmctl fails to
build.

Mimi

> ---
>  src/evmctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 43d261f..e350f69 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -69,6 +69,7 @@
>  static char *evm_default_xattrs[] = {
>  	XATTR_NAME_SELINUX,
>  	XATTR_NAME_SMACK,
> +	XATTR_NAME_APPARMOR,
>  	XATTR_NAME_IMA,
>  	XATTR_NAME_CAPS,
>  	NULL
> @@ -80,6 +81,7 @@ static char *evm_extra_smack_xattrs[] = {
>  	XATTR_NAME_SMACKEXEC,
>  	XATTR_NAME_SMACKTRANSMUTE,
>  	XATTR_NAME_SMACKMMAP,
> +	XATTR_NAME_APPARMOR,
>  	XATTR_NAME_IMA,
>  	XATTR_NAME_CAPS,
>  	NULL
