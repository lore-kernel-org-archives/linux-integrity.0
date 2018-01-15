Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750740AbeAOWa5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 17:30:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0FMTJpd108815
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 17:30:56 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fh36amgfn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 17:30:56 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 15 Jan 2018 22:30:54 -0000
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        kgold@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Date: Mon, 15 Jan 2018 17:30:50 -0500
In-Reply-To: <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
         <20171208184658.9588-9-Alexander.Steffen@infineon.com>
         <1515700018.3420.13.camel@linux.vnet.ibm.com>
         <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516055450.6607.91.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> What would be a better implementation? No delay and simply retry for 
> five seconds?
> 
> What TPMs are you using for your tests? At least for the TPMs that I 
> have available for my tests (with a FIFO size of ~256 bytes) I would not 
> expect any wait states for extend commands.

The TPM burstcount is 32.  Unfortunately, with this patch set the
performance on the pi is worse than without it.  Without this patch
set we're seeing ~14 secs for a thousand measurements vs. either ~38s
or ~23s, depending on the wait sleep length introduced in patch 8/9.
 This testing was done on a pi with an emulated SPI bus.

On systems with a large burstcount, there is no difference, but on
systems with a small burstcount, we're seeing an improvement of ~39%
(~14s base time, ~8.5 with patches).  

Does anyone have a system with a TPM on a real SPI bus and is willing
to test this patch set?

thanks,

Mimi
