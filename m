Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12565 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBIQOS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 11:14:18 -0500
Date: Fri, 9 Feb 2018 18:14:14 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: Re: [PATCH 1/2] tpm: fix potential buffer overruns caused by bit
 glitches on the bus
Message-ID: <20180209161414.ajpypqkrxs7ubgr3@linux.intel.com>
References: <1517592221.3137.18.camel@HansenPartnership.com>
 <1517592278.3137.19.camel@HansenPartnership.com>
 <20180208133402.xpszh2p5cpjnu6ki@linux.intel.com>
 <1518109652.21828.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1518109652.21828.6.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 08, 2018 at 09:07:32AM -0800, James Bottomley wrote:
> > Please add me to to-field in the future.
> 
> Will do.  I tend to assume everyone uses my workflow which means I junk
> the additional cc to me since I'll read it on the list anyway.

It's just that if there's lot of stuff going on those messages I'll
prioritize. Patches will get reviewed in all cases but there might
be more latency :-)

/Jarkko
