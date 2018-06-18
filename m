Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63560 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935689AbeFRSZV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jun 2018 14:25:21 -0400
Date: Mon, 18 Jun 2018 21:25:17 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: flihp <flihp@twobit.us>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for nonblocking operation
Message-ID: <20180618182517.GF20697@linux.intel.com>
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180604195554.GD2691@linux.intel.com>
 <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 08, 2018 at 12:36:18PM -0700, flihp wrote:
> On 06/04/2018 12:55 PM, Jarkko Sakkinen wrote:
> > On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
> >> The TCG SAPI specification [1] defines a set of functions, which allows
> >> applications to use the TPM device in either blocking or non-blocking fashion.
> >> Each command defined by the specification has a corresponding
> >> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> >> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> >> mode of operation. Currently the driver supports only blocking calls, which
> >> doesn't allow asynchronous operation. This patch changes it and adds support
> >> for nonblocking write and a new poll function to enable applications using
> >> the API as designed by the spec.
> >> The new functionality can be tested using standard TPM tools implemented
> >> in [2], with modified TCTI from [3].
> > 
> > I would need some statistics before I have interest to take these
> > changes in any form eg use case where this matters in the end.
> 
> The use cases motivating this feature are the same ones that motivated
> the non-blocking behavior of other kernel interfaces (files, sockets and
> other hardware) that has the potential to block threads in a process. By
> implementing this same behavior in the TPM driver our goal is to enable
> use of the TPM in programming languages / frameworks implementing an
> "event-driven" model. There are a lot of them out there but since the
> TSS2 APIs are currently limited to C our example code is in glib / GSource.
> 
> Hopefully this is sufficient but if it isn't it would help us to get
> additional details on what you're looking for.

Thanks Philip. I'll look into the patch itself.

/Jarkko
