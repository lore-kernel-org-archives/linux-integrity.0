Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753327AbeDYOvk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 10:51:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3PEldvi014967
        for <linux-integrity@vger.kernel.org>; Wed, 25 Apr 2018 10:51:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hju73sv48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Apr 2018 10:51:40 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 25 Apr 2018 15:51:38 +0100
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified
 xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Date: Wed, 25 Apr 2018 10:51:32 -0400
In-Reply-To: <CACdnJusixeW6LUhFzTEdLgQwRfxf9SXup3CwCAL+gXfA0PPO8g@mail.gmail.com>
References: <20180413225220.20130-1-mjg59@google.com>
         <1523801140.3272.187.camel@linux.vnet.ibm.com>
         <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
         <1523909802.3272.238.camel@linux.vnet.ibm.com>
         <CACdnJusXUkwmxsJiwysMniYj4AvmJjBjH0XXzMiTXwsR9+T+Fw@mail.gmail.com>
         <CACdnJusixeW6LUhFzTEdLgQwRfxf9SXup3CwCAL+gXfA0PPO8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1524667892.3371.67.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[CC'ing Igor]

On Tue, 2018-04-24 at 20:03 +0000, Matthew Garrett wrote:
> On Mon, Apr 16, 2018 at 1:22 PM Matthew Garrett <mjg59@google.com> wrote:
> > I could go either way on this - I think that doing it on the command line
> > would satisfy all my use cases.
> 
> Thinking about this some more - I think being able to do this at runtime is
> actually important. If we add an additional xattr to the signatures then we
> want to be able to update machine policy without forcing a reboot first,
> otherwise we have a chicken and egg problem where we have to gate any new
> package update against having a machine rebooted with an updated command
> line (otherwise the signature validation will fail for packages that
> contain new signatures)

If the list of xattr names is append only, there is no reason for re-
allocating the entire xattr name list each time.  As long as the xattr
name list pointer is defined as __ro_after_init, we can work with Igor
on using "protectable memory" once it is upstreamed.

Mimi
