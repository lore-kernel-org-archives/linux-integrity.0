Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752697AbdKHVEQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Nov 2017 16:04:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA8L2cE3043965
        for <linux-integrity@vger.kernel.org>; Wed, 8 Nov 2017 16:04:15 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e48sg2h1x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Nov 2017 16:04:15 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 8 Nov 2017 21:04:12 -0000
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: James Morris <james.l.morris@oracle.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date: Wed, 08 Nov 2017 16:04:07 -0500
In-Reply-To: <20171109075334.1809f4cc@canb.auug.org.au>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
         <1508774387.3639.128.camel@linux.vnet.ibm.com>
         <750.1509378910@warthog.procyon.org.uk>
         <3691.1509383138@warthog.procyon.org.uk>
         <1509385178.3583.159.camel@linux.vnet.ibm.com>
         <alpine.LFD.2.20.1710311424310.22021@localhost>
         <1510173982.4484.30.camel@linux.vnet.ibm.com>
         <20171109075334.1809f4cc@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510175047.4484.35.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-09 at 07:53 +1100, Stephen Rothwell wrote:
> Hi Mimi,
> 
> On Wed, 08 Nov 2017 15:46:22 -0500 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > [Cc'ing Stephen Rothwell]
> > 
> > On Tue, 2017-10-31 at 14:25 +1100, James Morris wrote:
> > > On Mon, 30 Oct 2017, Mimi Zohar wrote:
> > >   
> > > > James is staging the subsystem patches independently of each other, in
> > > > case of a similar problem, so that they can be pulled separately.
> > > >  There's a new "next-general" branch.  
> > > 
> > > If you send me a pull request, I'm combining branches into next-testing, 
> > > too, which is pulled into -next.  
> > 
> > linux-next already has the IMA patches, which might be confusing.
> 
> Not if they are the same *commits* i.e. if the tree/branch that James
> merges is the same as the one that I already merge of yours
> (git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity#next)

James' security tree is based on -rc3, while the integrity tree is
based on -rc4.  The rebased integrity patches are now in my security-
next-integrity branch.

Mimi
