Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751333AbeCLXTu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 19:19:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2CNJFE3026674
        for <linux-integrity@vger.kernel.org>; Mon, 12 Mar 2018 19:19:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gnx6y2g1k-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Mar 2018 19:19:50 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 12 Mar 2018 23:19:48 -0000
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jiandi An <anjiandi@codeaurora.org>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 19:19:42 -0400
In-Reply-To: <20180312230501.GJ24717@ziepe.ca>
References: <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <20180312215957.GI24717@ziepe.ca>
         <1520895525.3547.226.camel@linux.vnet.ibm.com>
         <20180312230501.GJ24717@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520896782.3547.245.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-12 at 17:05 -0600, Jason Gunthorpe wrote:
> On Mon, Mar 12, 2018 at 06:58:45PM -0400, Mimi Zohar wrote:
> > On Mon, 2018-03-12 at 15:59 -0600, Jason Gunthorpe wrote:
> > > On Mon, Mar 12, 2018 at 05:53:18PM -0400, Mimi Zohar wrote:
> > > 
> > > > Using Kconfig to force the TPM to be builtin is not required, but
> > > > helpful.  Users interested in IMA-measurement could configure the TPM
> > > > as builtin themselves.  Without the TPM builtin, IMA goes into TPM-
> > > > bypass mode.
> > > 
> > > This issues, broadly speaking, we have lots of TPM drivers, selecting
> > > only some to actually support IMA shows we have some kind of problem
> > > here.
> > 
> > True, IMA is not selecting the older TPM vendor specific modules, but
> > only the newer TPM_TIS and now TPM_CRB modules.  That doesn't imply
> > that IMA only supports some TPMs.  It means that by default, these
> > TPMs are builtin.  Anyone building a kernel, can select the vendor
> > specific TPM to be builtin.
> 
> That doesn't help distros, which is the main point of the complaint
> with this scheme :)

Years ago because of faulty TPM drivers, IMA was disabled in one of
the main distro's.  Deciding which vendor specific TPMs should be
builtin, is a discussion between the distro's and TPM vendors.

Mimi
