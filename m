Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:56673 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935776AbeCSVG2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 17:06:28 -0400
Date: Mon, 19 Mar 2018 23:06:21 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        '@linux.intel.com
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
Message-ID: <20180319210620.GB14364@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
 <1521249631.12827.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1521249631.12827.5.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Mar 16, 2018 at 06:20:31PM -0700, James Bottomley wrote:
> It turns out this bit is wrong ... I just discovered it testing the
> RC_RETRY code.  You can't feed the buf back to tpm_transmit because the
> header has already been changed to give you back the return code.  To
> make this work, you have to save the header and handle area and restore
> it before the command is resent.
> 
> I think the best solution for this hunk of code is to merge it with the
> retry code.

Yeah, right, so it is embarrasingly so :-) I wonder how I missed ths
during the review. Thanks for spotting this one out. Are you saying
that I should merge the patches into a single one? Perhaps you could
send me the merged patch if so?

If you agree, please send only that patch. I'll send v4 of my patch
set after 4.17 pull request.

/Jarkko
