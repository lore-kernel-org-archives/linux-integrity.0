Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752326AbeGBPZY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 11:25:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FOR0q016959
        for <linux-integrity@vger.kernel.org>; Mon, 2 Jul 2018 11:25:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jykvgfptd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 11:25:23 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 11:25:23 -0400
Subject: Re: [PATCH v7 5/5] ima: Get rid of ima_used_chip and use ima_tpm_chip
 != NULL instead
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
 <20180626190933.2508821-6-stefanb@linux.vnet.ibm.com>
 <1530544304.3709.40.camel@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 2 Jul 2018 11:25:20 -0400
MIME-Version: 1.0
In-Reply-To: <1530544304.3709.40.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b5fe7a69-ae53-70de-b8eb-bd7cb81fb15c@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/02/2018 11:11 AM, Mimi Zohar wrote:
> Hi Stefan,
>
> On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
>> Get rid of ima_used_chip and use ima_tpm_chip variable instead for
>> determining whether to use the TPM chip.
> I don't see a need for separating this change from the previous patch.
> Could you squash this patch with the previous one?
>
> As Jarkko has already queued the TPM patches, there's no need for
> posting them.  Posting just this one IMA patch is fine.
>
> thanks!
Posted
