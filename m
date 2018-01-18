Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752955AbeARVLH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 16:11:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0IL9PqW022835
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 16:11:07 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fk1btcuu8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 16:11:06 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 18 Jan 2018 21:11:05 -0000
Subject: Re: [PATCH] ima/policy: fix parsing of fsuuid
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Date: Thu, 18 Jan 2018 16:11:00 -0500
In-Reply-To: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516309860.3772.0.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-01-17 at 20:27 +0200, Mike Rapoport wrote:
> The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
> is zero during parsing of "fsuuid=" rule. Instead of making sure the
> &entry->fsuuid field is not attempted to be overwriten, we bail out for
> perfectly correct rule.
> 
> Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Thanks, Mike.

> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ee4613fa5840..f19f4841a97a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -743,7 +743,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		case Opt_fsuuid:
>  			ima_log_string(ab, "fsuuid", args[0].from);
> 
> -			if (uuid_is_null(&entry->fsuuid)) {
> +			if (!uuid_is_null(&entry->fsuuid)) {
>  				result = -EINVAL;
>  				break;
>  			}
