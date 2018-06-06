Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3173 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752136AbeFFO2x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jun 2018 10:28:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w56EOfNK146411
        for <linux-integrity@vger.kernel.org>; Wed, 6 Jun 2018 10:28:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jefe06s90-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Jun 2018 10:28:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 6 Jun 2018 15:28:51 +0100
Subject: Re: violations and invalidated PCR value
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Wed, 06 Jun 2018 10:28:35 -0400
In-Reply-To: <AT5PR8401MB113985C429E1F854FE9B62D3FF660@AT5PR8401MB1139.NAMPRD84.PROD.OUTLOOK.COM>
References: <AT5PR8401MB113985C429E1F854FE9B62D3FF660@AT5PR8401MB1139.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528295315.3255.25.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Guilherme,

On Tue, 2018-06-05 at 21:22 +0000, Magalhaes, Guilherme (Brazil R&D-
CL) wrote:
> Hi Mimi,
> I am trying to understand why violations (tomtou, open writers) cause 
> the aggregated PCR value to be invalidated. 
> 
> Invalidating the PCR makes clear the file measurement errors, but once 
> violations are common (when using the (TCB) default policy) it seems 
> difficult to perform a full attestation process if violations are not 
> handled.
> 
> Is it safe to just report the violations and still perform a full attestation 
> of the log by replacing zeroed digest with ff..ff? I believe we can safely 
> detect a violation entry in the log by checking the hash values are zeroes. 
> Please confirm.

It's not clear if you're asking what your attestation server should
being do or suggesting that the kernel should not invalidate the PCR.

The builtin policies are loaded before the LSM policies. As a result,
they can not be defined in terms of LSM labels.  The builtin policies
can be replaced at run time with a policy based on LSM labels (eg. log
files), which should limit a number of these violations.

Someone should go through the remaining violations to determine if
they're benign, expected or not.  Some applications unnecessarily open
files rw.  Fix those applications.  Identify those violations which
are acceptable.  Only then can the attestation server safely know how
to handle violations, whether it is safe to replace the 0x00's with
0xff's.

Mimi
