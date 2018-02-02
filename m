Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40473 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBBSsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 13:48:25 -0500
Received: by mail-wm0-f44.google.com with SMTP id v123so14309917wmd.5
        for <linux-integrity@vger.kernel.org>; Fri, 02 Feb 2018 10:48:24 -0800 (PST)
Date: Fri, 2 Feb 2018 11:48:19 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: Re: [PATCH 0/2] Fix kernel buffer overruns caused by bit flips
Message-ID: <20180202184819.GB9080@ziepe.ca>
References: <1517592221.3137.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517592221.3137.18.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 02, 2018 at 06:23:41PM +0100, James Bottomley wrote:
> If a TPM is attached to a system via a serial bus on a platform that
> suffers bit flips, we can get back dangerously wrong data.  This patch
> series aims never to do a direct copy into a kernel buffer based on an
> unchecked size value returned from the TPM.
> 
> Jeremy Boone (2):
>   tpm: fix potential buffer overruns caused by bit glitches on the bus
>   tpm drivers: fix potential buffer overruns caused by bit glitches on
>     the bus

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
