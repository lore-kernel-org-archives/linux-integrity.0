Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbeHXO5L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Aug 2018 10:57:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OBEMg4013804
        for <linux-integrity@vger.kernel.org>; Fri, 24 Aug 2018 07:22:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m2dasrjmn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 Aug 2018 07:22:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 Aug 2018 12:22:56 +0100
Subject: Re: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to
 prevent inadvertent change of dev
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Howells <dhowells@redhat.com>, denkenz@gmail.com,
        jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Date: Fri, 24 Aug 2018 07:22:39 -0400
In-Reply-To: <20180824062557.GC3584@linux.intel.com>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
         <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
         <20180821183004.GB25543@ziepe.ca> <20180824062434.GB3584@linux.intel.com>
         <20180824062557.GC3584@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1535109759.19550.355.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-08-24 at 09:25 +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 24, 2018 at 09:24:34AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 21, 2018 at 12:30:04PM -0600, Jason Gunthorpe wrote:
> > > On Tue, Aug 21, 2018 at 04:56:56PM +0100, David Howells wrote:
> > > > Add newly registered TPMs to the tail of the list, not the beginning, so that
> > > > things that are specifying TPM_ANY_NUM don't find that the device they're
> > > > using has inadvertently changed.  Adding a second device would break IMA, for
> > > > instance.
> > > > 
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> > > > cc: stable@vger.kernel.org
> > > > ---
> > > 
> > > We really should apply this patch...
> > > 
> > > Jason
> > 
> > This is the first time I remember seeing it.
> 
> At least in the sense that I should review it.

I remember this patch, because it affected IMA.  It has already been
upstreamed as 398a1e71dc82.

Mimi
