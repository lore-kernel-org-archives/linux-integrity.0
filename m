Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750908AbdLHUUG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:20:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8KJKrU108610
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 15:20:04 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2er0xhauph-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 15:20:04 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 13:20:03 -0700
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 15:20:02 -0500
MIME-Version: 1.0
In-Reply-To: <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/26/2017 9:06 AM, Jarkko Sakkinen wrote:
> 
> I think -EINVAL is better than synthetizing commands that are not really
> from the TPM. And we would break backwards compatability by doing this.
> 
> As I said in an earlier response I would rather compare resource
> manager to virtual memory than virtual machine.

Agreed that synthesizing a response is not trivial.  (It's not that hard 
either - a 6 byte hard coded header and a 4 byte big endian integer.)

But what would be wrong with sending an unknown command to the TPM and 
letting it handle the response?
