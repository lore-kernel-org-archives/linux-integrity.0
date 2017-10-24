Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53331 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdJXN43 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 09:56:29 -0400
Date: Tue, 24 Oct 2017 15:56:22 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] xen-tpmfront: Use common error handling code in
 vtpm_send()
Message-ID: <20171024135622.uswu3apuj23njbna@linux.intel.com>
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
 <9cfcbfd0-75c3-4de5-f735-0ace23d2abcb@users.sourceforge.net>
 <20171023134257.txnpbg5c5z7uaquf@linux.intel.com>
 <f68ee5b6-2da1-e3c8-4d0d-f13a0563385e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f68ee5b6-2da1-e3c8-4d0d-f13a0563385e@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 23, 2017 at 03:57:30PM +0200, SF Markus Elfring wrote:
> >> @@ -108,11 +106,14 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> >>  	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
> >>  			&priv->read_queue, true) < 0) {
> >>  		/* got a signal or timeout, try to cancel */
> >> -		vtpm_cancel(chip);
> >> -		return -ETIME;
> >> +		goto cancel_vtpm;
> >>  	}
> >>  
> >>  	return count;
> >> +
> >> +cancel_vtpm:
> >> +	vtpm_cancel(chip);
> >> +	return -ETIME;
> >>  }
> >>  
> >>  static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> >> -- 
> >> 2.14.2
> >>
> > 
> > NAK
> 
> Do you need any more facts to show the influence of the proposed small code reduction?
> 
> Regards,
> Markus

Already explained when I reviewed another patch dealing with
-ETIME.

/Jarkko
