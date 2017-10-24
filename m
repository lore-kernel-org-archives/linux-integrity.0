Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdJXNzU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 09:55:20 -0400
Date: Tue, 24 Oct 2017 15:55:11 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Use common error handling code in
 tpm_tis_send_data()
Message-ID: <20171024135511.773njwnmodnewtwo@linux.intel.com>
References: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
 <20171023134202.d6td6vvhd7pfv5ue@linux.intel.com>
 <455e93f6-c419-8318-6129-80e99fc8552f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <455e93f6-c419-8318-6129-80e99fc8552f@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 23, 2017 at 03:51:09PM +0200, SF Markus Elfring wrote:
> >> @@ -315,6 +311,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >>  
> >>  	return 0;
> >>  
> >> +report_timeout:
> >> +	rc = -ETIME;
> >>  out_err:
> >>  	tpm_tis_ready(chip);
> >>  	return rc;
> >> -- 
> >> 2.14.2
> >>
> > 
> > NAK. wait_for_tpm_stat() should give that error code.
> 
> This is a pity that you reject another bit of code reduction.
> 
> Regards,
> Markus

It is a pity that you continue doing this constant patch trolling.
That is what it is.

/Jarkko.
