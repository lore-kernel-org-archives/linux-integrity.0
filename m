Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755311AbeF2M1X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 08:27:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TCIxOL021761
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 08:27:23 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwhptg1e4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 08:27:23 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 06:27:22 -0600
Subject: Re: [PATCH v7 0/5] Have IMA find and use a tpm_chip until system
 shutdown
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
 <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 08:27:16 -0400
MIME-Version: 1.0
In-Reply-To: <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <70d1e3ae-eebd-9ffc-5c28-79bf0e295bda@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/29/2018 08:13 AM, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
>> This series of patches converts IMA's usage of the tpm_chip to find a TPM
>> chip initially and use it until the machine is shut down. To do this we need
>> to introduce a kref for the tpm_chip that IMA and all other users of a
>> tpm_chip hold onto until they don't need the TPM chip anymore.
> All the TPM patches are now in my tree and I just updated also the
> next branch so they should be soon available also in linux-next.
Thanks.

   Stefan
> /Jarkko
>
