Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752397AbdKMLrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 06:47:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADBj99V014506
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:47:50 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e77ek1uy2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:47:50 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 13 Nov 2017 11:47:48 -0000
Subject: Re: [PATCH] ima: add namespace template
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Boshi Wang <wangboshi@huawei.com>, linux-integrity@vger.kernel.org
Cc: hw.likun@huawei.com, dmitry.kasatkin@gmail.com
Date: Mon, 13 Nov 2017 06:47:43 -0500
In-Reply-To: <20171109024914.140203-1-wangboshi@huawei.com>
References: <20171109024914.140203-1-wangboshi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510573663.3404.111.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-09 at 10:49 +0800, Boshi Wang wrote:
> Currently IMA can store digests, filenames and signatures. But there may
> be different files which owns the same filename due to multiple mount
> namespaces, e.g. in the container environment. To distingush them, we
> introduce a new templete which contains a namespace field. The namespace
> field stores the mount namespace number.

A similar patch was previously posted by Guilherme Magalhaes.  As
discussed then, the namespace information should really not be
included in the IMA measurement list, but as messages produced by
ima_audit_measurement().

Guilherme posted a patch that adds the namespace info to the audit
record.

Mimi

> Signed-off-by: Boshi Wang <wangboshi@huawei.com>
> ---
>  security/integrity/ima/ima_template.c     |  3 +++
>  security/integrity/ima/ima_template_lib.c | 29 ++++++++++++++++++++++++++++-
>  security/integrity/ima/ima_template_lib.h |  4 ++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 7412d02..dd29d4e 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
>  	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
>  	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
>  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
> +	{.name = "ima-ns", .fmt = "d-ng|n-ng|ns"},
>  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
>  };
> 
> @@ -43,6 +44,8 @@ static struct ima_template_field supported_fields[] = {
>  	 .field_show = ima_show_template_string},
>  	{.field_id = "sig", .field_init = ima_eventsig_init,
>  	 .field_show = ima_show_template_sig},
> +	{.field_id = "ns", .field_init = ima_eventns_init,
> +	 .field_show = ima_show_template_ns},
>  };
>  #define MAX_TEMPLATE_NAME_LEN 15
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 28af43f..e0eb67d 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -13,6 +13,8 @@
>   *      Library of supported template fields.
>   */
> 
> +#include <linux/atomic.h>
> +#include <linux/proc_ns.h>
>  #include "ima_template_lib.h"
> 
>  static bool ima_template_hash_algo_allowed(u8 algo)
> @@ -27,7 +29,8 @@ enum data_formats {
>  	DATA_FMT_DIGEST = 0,
>  	DATA_FMT_DIGEST_WITH_ALGO,
>  	DATA_FMT_STRING,
> -	DATA_FMT_HEX
> +	DATA_FMT_HEX,
> +	DATA_FMT_UINT
>  };
> 
>  static int ima_write_template_field_data(const void *data, const u32 datalen,
> @@ -90,6 +93,9 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>  	case DATA_FMT_STRING:
>  		seq_printf(m, "%s", buf_ptr);
>  		break;
> +	case DATA_FMT_UINT:
> +		seq_printf(m, "%u", *(unsigned int *)buf_ptr);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -159,6 +165,12 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>  	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
>  }
> 
> +void ima_show_template_ns(struct seq_file *m, enum ima_show_type show,
> +			  struct ima_field_data *field_data)
> +{
> +	ima_show_template_field_data(m, show, DATA_FMT_UINT, field_data);
> +}
> +
>  /**
>   * ima_parse_buf() - Parses lengths and data from an input buffer
>   * @bufstartp:       Buffer start address.
> @@ -391,3 +403,18 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>  out:
>  	return rc;
>  }
> +
> +int ima_eventns_init(struct ima_event_data *event_data,
> +		     struct ima_field_data *field_data)
> +{
> +	struct ns_common *ns;
> +	unsigned int ns_id;
> +
> +	ns = mntns_operations.get(current);
> +	if (ns == NULL)
> +		return -ENOENT;
> +	ns_id = ns->inum;
> +	mntns_operations.put(ns);
> +	return ima_write_template_field_data(&ns_id, sizeof(ns_id),
> +					     DATA_FMT_UINT, field_data);
> +}
> diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
> index 6a3d8b8..9ca9059 100644
> --- a/security/integrity/ima/ima_template_lib.h
> +++ b/security/integrity/ima/ima_template_lib.h
> @@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
>  			      struct ima_field_data *field_data);
>  void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>  			   struct ima_field_data *field_data);
> +void ima_show_template_ns(struct seq_file *m, enum ima_show_type show,
> +			  struct ima_field_data *field_data);
>  int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
>  		  int maxfields, struct ima_field_data *fields, int *curfields,
>  		  unsigned long *len_mask, int enforce_mask, char *bufname);
> @@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
>  			  struct ima_field_data *field_data);
>  int ima_eventsig_init(struct ima_event_data *event_data,
>  		      struct ima_field_data *field_data);
> +int ima_eventns_init(struct ima_event_data *event_data,
> +		     struct ima_field_data *field_data);
>  #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
