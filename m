Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19449 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754513AbeARSiY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:38:24 -0500
Date: Thu, 18 Jan 2018 20:38:19 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] tpm-chip: Move idr_replace calls to appropriate
 places
Message-ID: <20180118183819.wgdahp5d4n6pwu6z@linux.intel.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214160614.11808-2-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:06:12PM +0100, Alexander Steffen wrote:
> According to the comments, adding/removing the chip from the list should be
> the first/last action in (un)register. But currently it is done in a
> subfunction in the middle of the process. Moving the code from the
> subfunctions to the appropriate places within (un)register ensures that the
> code matches the comments.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

What is the problem you are having that this commit tries to
address. Rather would not make changes for cosmetic reasons
to init code.

/Jarkko
