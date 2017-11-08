Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752616AbdKHUqa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Nov 2017 15:46:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA8KhgCJ012412
        for <linux-integrity@vger.kernel.org>; Wed, 8 Nov 2017 15:46:29 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e4896b3qx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Nov 2017 15:46:29 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 8 Nov 2017 20:46:27 -0000
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <james.l.morris@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date: Wed, 08 Nov 2017 15:46:22 -0500
In-Reply-To: <alpine.LFD.2.20.1710311424310.22021@localhost>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
         <1508774387.3639.128.camel@linux.vnet.ibm.com>
         <750.1509378910@warthog.procyon.org.uk>
         <3691.1509383138@warthog.procyon.org.uk>
         <1509385178.3583.159.camel@linux.vnet.ibm.com>
         <alpine.LFD.2.20.1710311424310.22021@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510173982.4484.30.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing Stephen Rothwell]

On Tue, 2017-10-31 at 14:25 +1100, James Morris wrote:
> On Mon, 30 Oct 2017, Mimi Zohar wrote:
> 
> > James is staging the subsystem patches independently of each other, in
> > case of a similar problem, so that they can be pulled separately.
> >  There's a new "next-general" branch.
> 
> If you send me a pull request, I'm combining branches into next-testing, 
> too, which is pulled into -next.

linux-next already has the IMA patches, which might be confusing.

Mimi
