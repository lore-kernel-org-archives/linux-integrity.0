Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755144AbeF2PB6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 11:01:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TF06Op090099
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 11:01:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwpba1xcm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 11:01:55 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 16:01:53 +0100
Subject: Re: [PATCH v7 0/5] Have IMA find and use a tpm_chip until system
 shutdown
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 29 Jun 2018 11:01:37 -0400
In-Reply-To: <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
         <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530284497.3366.145.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-29 at 15:13 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> > This series of patches converts IMA's usage of the tpm_chip to find a TPM
> > chip initially and use it until the machine is shut down. To do this we need
> > to introduce a kref for the tpm_chip that IMA and all other users of a
> > tpm_chip hold onto until they don't need the TPM chip anymore.
> 
> All the TPM patches are now in my tree and I just updated also the
> next branch so they should be soon available also in linux-next.

James, do you have a preference?  Should I merge the patches in
Jarkko's next branch or just base the integrity branch on top of it?

Mimi
