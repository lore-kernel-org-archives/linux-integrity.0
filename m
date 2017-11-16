Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932697AbdKPUCB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 15:02:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGJxIjX094360
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 15:02:00 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e9fspd4qx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 15:02:00 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 20:01:57 -0000
Subject: Re: [USER] [PATCH V2] Add support for portable EVM format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Thu, 16 Nov 2017 15:01:53 -0500
In-Reply-To: <20171116182111.26267-1-mjg59@google.com>
References: <20171116182111.26267-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510862513.3711.457.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

> @@ -1679,6 +1692,9 @@ int main(int argc, char *argv[])
>  		case 'i':
>  			evm_immutable = true;
>  			break;
> +		case 'o':
> +			evm_portable = true;
> +			break;

If this is ok by you,  I'll make the change:

-                       evm_immutable = true;
+                       if (evm_portable)
+                               log_err("Portable and immutable options are exclusive, ignoring immutable option.");
+                       else
+                               evm_immutable = true;
+                       break;
+               case 'o':
+                       if (evm_immutable)
+                               log_err("Portable and immutable options are exclusive, ignoring portable option.");
+                       else
+                               evm_portable = true;


+                       else
+                               evm_portable = true;
                        break;

Mimi
