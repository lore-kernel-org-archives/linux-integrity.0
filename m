Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751178AbeECVmK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 17:42:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w43LeCCT124670
        for <linux-integrity@vger.kernel.org>; Thu, 3 May 2018 17:42:09 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hr6s783ah-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 May 2018 17:42:09 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 3 May 2018 22:42:07 +0100
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Patrick Callaghan <patrickc@us.ibm.com>
Date: Thu, 03 May 2018 17:42:00 -0400
In-Reply-To: <alpine.LRH.2.21.1805040311050.12843@namei.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1805040311050.12843@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525383720.3539.76.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-04 at 03:11 +1000, James Morris wrote:
> On Wed, 2 May 2018, Mehmet Kayaalp wrote:
> 
> > These patches add support for modifying the reserved space for extra
> > certificates in a compressed bzImage in x86. This allows separating the
> > system keyring certificate from the kernel build process. After the kernel
> > image is distributed, the insert-sys-cert script can be used to insert the
> > certificate for x86.
> 
> Can you provide more explanation of how this is useful and who would use 
> it?

I'm involved in a number projects that rely on a kernel build group to
actually build kernels for their systems.  Reserving memory for
additional public keys, allows product groups to insert public keys
post build.  Initially the product groups might insert development
keys, but eventually they would insert the product's public key.

Mimi
