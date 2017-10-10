Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from blatinox.fr ([51.254.120.209]:50770 "EHLO vps202351.ovh.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757004AbdJJUaX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 16:30:23 -0400
Date: Tue, 10 Oct 2017 16:30:11 -0400
From: =?UTF-8?B?SsOpcsOpbXk=?= Lefaure <jeremy.lefaure@lse.epita.fr>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] tpm: use ARRAY_SIZE
Message-ID: <20171010163011.2df093d1@blatinox-laptop.localdomain>
In-Reply-To: <20171004121449.kywykfgyxtkmu2ar@linux.intel.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
        <20171001193101.8898-14-jeremy.lefaure@lse.epita.fr>
        <20171004121449.kywykfgyxtkmu2ar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 4 Oct 2017 15:14:49 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Sun, Oct 01, 2017 at 03:30:51PM -0400, Jeremy Lefaure wrote:
> > Using the ARRAY_SIZE macro improves the readability of the code.
> > 
> > Found with Coccinelle with the following semantic patch:
> > @r depends on (org || report)@
> > type T;
> > T[] E;
> > position p;
> > @@
> > (
> >  (sizeof(E)@p /sizeof(*E))
> > |
> >  (sizeof(E)@p /sizeof(E[...]))
> > |
> >  (sizeof(E)@p /sizeof(T))
> > )
> > 
> > Signed-off-by: Jeremy Lefaure <jeremy.lefaure@lse.epita.fr>  
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
Hi Jarkko,
This patch is an individual patch, it's not really part of a series
(my fault, sorry).

Could you apply this patch to your tree ?

Thank you,
Jeremy
