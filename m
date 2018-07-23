Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50341 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbeGWXLn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 19:11:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so577244wmc.0
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jul 2018 15:08:26 -0700 (PDT)
Date: Mon, 23 Jul 2018 16:08:22 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723220822.GJ532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
 <20180723215620.GH532@ziepe.ca>
 <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jul 23, 2018 at 03:00:20PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> > The proposed patch doesn't clear the data_pending if the entire buffer
> > is not consumed, so of course it is ABI breaking, that really isn't OK.
> 
> The data_pending will be cleared by the timeout handler if the user doesn't
> read the response fully before the timeout expires. The is the same situation
> if the user would not read the response at all.

That causes write() to fail with EBUSY

NAK from me on breaking the ABI like this

Jason
