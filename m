Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37966 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934724AbeFLBng (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jun 2018 21:43:36 -0400
Message-ID: <1528767814.3572.25.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for nonblocking operation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: flihp <flihp@twobit.us>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org
Date: Mon, 11 Jun 2018 18:43:34 -0700
In-Reply-To: <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
         <20180604195554.GD2691@linux.intel.com>
         <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-08 at 12:36 -0700, flihp wrote:
> On 06/04/2018 12:55 PM, Jarkko Sakkinen wrote:
> > On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
> > > The TCG SAPI specification [1] defines a set of functions, which
> > > allows applications to use the TPM device in either blocking or
> > > non-blocking fashion. Each command defined by the specification
> > > has a corresponding Tss2_Sys_<COMMAND>_Prepare() and
> > > Tss2_Sys_<COMMAND>_Complete() call, which together with
> > > Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> > > mode of operation. Currently the driver supports only blocking
> > > calls, which doesn't allow asynchronous operation. This patch
> > > changes it and adds support for nonblocking write and a new poll
> > > function to enable applications using the API as designed by the
> > > spec. The new functionality can be tested using standard TPM
> > > tools implemented in [2], with modified TCTI from [3].
> > 
> > I would need some statistics before I have interest to take these
> > changes in any form eg use case where this matters in the end.
> 
> The use cases motivating this feature are the same ones that
> motivated the non-blocking behavior of other kernel interfaces
> (files, sockets and other hardware) that has the potential to block
> threads in a process. By implementing this same behavior in the TPM
> driver our goal is to enable use of the TPM in programming languages
> / frameworks implementing an "event-driven" model. There are a lot of
> them out there but since the TSS2 APIs are currently limited to C our
> example code is in glib / GSource.

But the TPM isn't like any of those resources, which can handle
multiple outstanding requests at once and get more efficient
utilisation doing so: it *is* single threaded in operation.  Meaning if
it's occupied doing something when you make your request, you wait
until it's finished up before your request goes through.  This means
that even for modern webby languages, the single worker thread
producer/consumer queue model is the best way of handling it because
it's the model that most closely corresponds to actual operation.  That
model just works today with the worker thread owning the open tpmrm
device.

I mean some of the actual devices are polled rather than interrupt
driven to give those watching some idea of how primitive our control
bus is.

> Hopefully this is sufficient but if it isn't it would help us to get
> additional details on what you're looking for.

OK, so I still don't see an actual use case for having poll, but on the
other hand the patches look simple enough so I don't see them adding
unmaintainable complexity either; on that measure, I'm OK with this as
long as you support it.

James
