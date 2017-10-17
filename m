Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753415AbdJQPRt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 11:17:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9HFFKFr089472
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 11:17:49 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dnk894dq8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 11:17:49 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 16:17:47 +0100
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Alexander.Steffen@infineon.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        clabbe.montjoie@gmail.com, jarkko.sakkinen@linux.intel.com,
        jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
        kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
        nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 11:17:33 -0400
In-Reply-To: <alpine.DEB.2.20.1710171456360.5035@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
         <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
         <1508238182.16112.475.camel@linux.intel.com>
         <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
         <1508244757.4234.60.camel@linux.vnet.ibm.com>
         <alpine.DEB.2.20.1710171456360.5035@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508253453.4234.81.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-17 at 14:58 +0200, Julia Lawall wrote:
> 
> On Tue, 17 Oct 2017, Mimi Zohar wrote:
> 
> > On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
> > wrote:
> > > > > Replace the specification of data structures by pointer dereferences
> > > > > as the parameter for the operator "sizeof" to make the corresponding
> > > > > size
> > > > > determination a bit safer according to the Linux coding style
> > > > > convention.
> > > >
> > > >
> > > > This patch does one style in favor of the other.
> > >
> > > I actually prefer that style, so I'd welcome this change :)
> >
> > Style changes should be reviewed and documented, like any other code
> > change, and added to Documentation/process/coding-style.rst or an
> > equivalent file.
> 
> Actually, it has been there for many years:
> 
> 14) Allocating memory
> ---------------------
> ...
> The preferred form for passing a size of a struct is the following:
> 
> .. code-block:: c
> 
> 	p = kmalloc(sizeof(*p), ...);
> 
> The alternative form where struct name is spelled out hurts readability and
> introduces an opportunity for a bug when the pointer variable type is changed
> but the corresponding sizeof that is passed to a memory allocator is not.

True, thanks for the reminder.  Is this common in new code?  Is there
a script/ or some other automated way of catching this usage before
patches are upstreamed?

Just as you're doing here, the patch description should reference this
in the patch description.

Mimi
