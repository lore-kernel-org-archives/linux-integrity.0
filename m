Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40353 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeA2R5Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jan 2018 12:57:25 -0500
Received: by mail-wm0-f42.google.com with SMTP id v123so35416937wmd.5
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jan 2018 09:57:25 -0800 (PST)
Date: Mon, 29 Jan 2018 10:57:20 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180129175720.GB23714@ziepe.ca>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
 <20180128075101.6883-2-tomas.winkler@intel.com>
 <20180128201559.GG23869@ziepe.ca>
 <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Jan 28, 2018 at 09:17:53PM +0000, Winkler, Tomas wrote:

> > I think if a driver can fail reliquish then it needs some kind of strategy to
> > recover.

> Maybe some driver can and some not, but if it doesn't succeed it
> should return an error.

But you can't just leave the driver in some inconsistent state..

Every time I've audited something to do with 'add error codes to
destroy/free/release' I find driver design issues..

> > Suggest trying the reliquish again on every next request until success,
> > otherwise fail request locality, potentially permanently.
> 
> This is something I rather prevent because it leaves the HW in kind of undefined state 
> ( and we should probably work on that a bit more later).
> As far as I've debugged the flow now, the driver just fails, and the error goes up 
> user space caller or the internal flow is stopped.

But tranmist_command will be called again - then what does the driver
do? The driver needs an answer for that..

If you don't want to retry then I'd rather see request_locality
permanently fail then adding a return code to release.

Jason
