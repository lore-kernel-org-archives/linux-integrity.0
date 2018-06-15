Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965639AbeFOPUd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jun 2018 11:20:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5FFJOQE077590
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jun 2018 11:20:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jmf59jnet-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jun 2018 11:20:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 15 Jun 2018 16:20:29 +0100
Subject: Re: [integrity:next-integrity-queued 22/22]
 security/integrity/evm/evm_crypto.c:93: undefined reference to
 `hash_algo_name'
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>,
        Matthew Garrett <mjg59@google.com>
Cc: kbuild-all@01.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date: Fri, 15 Jun 2018 11:20:25 -0400
In-Reply-To: <1529060150.3740.79.camel@linux.vnet.ibm.com>
References: <201806140958.6pTSK5nT%fengguang.wu@intel.com>
         <1529060150.3740.79.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1529076025.3740.89.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-15 at 06:55 -0400, Mimi Zohar wrote:
> On Thu, 2018-06-14 at 09:07 +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
> > head:   6497009f11c75bae55a3329dedcd3eeb8e282eaf
> > commit: 6497009f11c75bae55a3329dedcd3eeb8e282eaf [22/22] evm: Allow non-SHA1 digital signatures
> > config: x86_64-randconfig-ws0-06140615 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout 6497009f11c75bae55a3329dedcd3eeb8e282eaf
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All errors (new ones prefixed by >>):
> >    security/integrity/evm/evm_crypto.o: In function `init_desc':
> > >> security/integrity/evm/evm_crypto.c:93: undefined reference to `hash_algo_name'
> > 
> > vim +93 security/integrity/evm/evm_crypto.c
> 
> Thanks!  Removing the hash.h include should fix it.  (commit updated.)

Reverting this change and selecting CRYPTO_HASH_INFO instead.
