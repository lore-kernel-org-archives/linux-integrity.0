Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38646 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdLHUSk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:18:40 -0500
Received: by mail-wm0-f46.google.com with SMTP id 64so4923588wme.3
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 12:18:39 -0800 (PST)
Date: Fri, 8 Dec 2017 13:18:35 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ken Goldman <kgold@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171208201835.GA10362@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <44ff3d81-809c-b8ea-ae27-42725ee0a9fc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44ff3d81-809c-b8ea-ae27-42725ee0a9fc@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 03:03:34PM -0500, Ken Goldman wrote:
> Do you really want to build in an every expanding list of commands that the
> kernel has to screen for?  I don't think so.

We have to, it is required for securing unpriv access.

> Remember that there are new commands, optional commands, and vendor
> proprietary commands.  What's the rationale for only looking at the command
> code and not rest of the parameters?

The TPM arch already split the commands in a way where you don't need
to look at params in most cases. I think we might, or should, look at
params in some of the 'get cap' cases ?

Jason
