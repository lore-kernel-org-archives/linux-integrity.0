Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17381 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbdJWNmg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:42:36 -0400
Date: Mon, 23 Oct 2017 15:42:31 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] Xen vTPM frontend: Fine-tuning for vtpm_send()
Message-ID: <20171023134231.ndvk5upc5qyeubk6@linux.intel.com>
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 22, 2017 at 01:28:14PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Oct 2017 13:23:45 +0200
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Use common error handling code
>   Combine two condition checks into one statement
> 
>  drivers/char/tpm/xen-tpmfront.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> -- 
> 2.14.2
> 

Useless cover letter. Two separate unrelated patches.

/Jarkko
