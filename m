Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967212AbdIZSrD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 14:47:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8QIhgUm064129
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 14:47:03 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d7v4t0y7t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 14:47:02 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Tue, 26 Sep 2017 12:47:02 -0600
Subject: Re: about context gap
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
 <20170918180250.6db5ti4gpinqr5jz@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 14:46:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170918180250.6db5ti4gpinqr5jz@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <03018f5e-4afc-7db5-b5a8-dfed8e2bd8d2@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/18/2017 2:02 PM, Jarkko Sakkinen wrote:

> Other than context gap it would probably make sense to estimate TPM
> capacity in order to make implementation more intelligent. We could
> measure memory capacity of a TPM in the driver initialization by filling
> it with fixed size dummy objects.
> 
> TPM2_GetCapability gives stuff that cannot be really trusted as spec
> compliant TPM HW could just return always '1' for max.

I don't see anything in the TPM specs that claim the TPM can return 1.

E.g., the PC Client spec says that loaded sessions must return a minimum 
of 3.  Active sessions must return a minimum of 64.

I think the resource manager can safely use these getcapability values.
