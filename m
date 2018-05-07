Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753023AbeEGUgp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 16:36:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47KYpsk082747
        for <linux-integrity@vger.kernel.org>; Mon, 7 May 2018 16:36:45 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2htw74svr8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 16:36:44 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 7 May 2018 21:36:42 +0100
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ltp <ltp@lists.linux.it>,
        Petr Vorel <pvorel@suse.cz>
Date: Mon, 07 May 2018 16:36:37 -0400
In-Reply-To: <20180420053926.GB15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
         <20180412101350.210547-3-tweek@google.com>
         <20180420053926.GB15364@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525725397.3551.10.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing Petr Vorel and the ltp mailing list]

Hi Jarrko,

On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I just noticed this is queued in your next branch.

Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
tests includes walking the TPM binary_runtime_measurements in order to
calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
measurement in the IMA measurement list.

Mimi
