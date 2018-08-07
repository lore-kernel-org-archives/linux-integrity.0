Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42422 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387623AbeHGCrZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Aug 2018 22:47:25 -0400
Message-ID: <1533602145.3159.23.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Aug 2018 17:35:45 -0700
In-Reply-To: <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
         <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
         <1533596748.3159.19.camel@HansenPartnership.com>
         <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-08-06 at 17:09 -0700, Tadeusz Struk wrote:
> On 08/06/2018 04:05 PM, James Bottomley wrote:
> > For an async interface, shouldn't I be able to queue an
> > arbitrary number of commands without blocking?
> 
> That was the approach in the v1 version of this patch, but
> Jason requested this to be changed so that only one command
> at a time can be processed.

He did?  I don't remember that.  I think he told you the TPM itself can
only process one operation at once so you didn't need an elaborate
allocation scheme.

But anyway, if you're happy to limit the interface to block after one
command is issued, how is it useful as an asynchronous interface?  I
thought the whole argument for the patch was to avoid the producer-
consumer approach which is possible with the current interface and to
use a fully event driven polling interface which can be implemented
single threaded.  If you can block in submission, this latter isn't
really possible because your interface isn't really asynchronous.

James
