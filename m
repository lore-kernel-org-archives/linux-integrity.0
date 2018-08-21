Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38748 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUVvV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Aug 2018 17:51:21 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so5355391itb.3
        for <linux-integrity@vger.kernel.org>; Tue, 21 Aug 2018 11:30:06 -0700 (PDT)
Date: Tue, 21 Aug 2018 12:30:04 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com,
        jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to
 prevent inadvertent change of dev
Message-ID: <20180821183004.GB25543@ziepe.ca>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Aug 21, 2018 at 04:56:56PM +0100, David Howells wrote:
> Add newly registered TPMs to the tail of the list, not the beginning, so that
> things that are specifying TPM_ANY_NUM don't find that the device they're
> using has inadvertently changed.  Adding a second device would break IMA, for
> instance.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> cc: stable@vger.kernel.org
> ---

We really should apply this patch...

Jason
