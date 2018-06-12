Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47814 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeFLANf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jun 2018 20:13:35 -0400
Subject: Re: [PATCH] tpm: add support for nonblocking operation
To: flihp <flihp@twobit.us>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180604195554.GD2691@linux.intel.com>
 <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <f4fd0eef-1340-e5e9-5ce1-d49f6f2ac886@intel.com>
Date: Mon, 11 Jun 2018 17:13:34 -0700
MIME-Version: 1.0
In-Reply-To: <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/08/2018 12:36 PM, flihp wrote:
> On 06/04/2018 12:55 PM, Jarkko Sakkinen wrote:
>> On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
>>> The TCG SAPI specification [1] defines a set of functions, which allows
>>> applications to use the TPM device in either blocking or non-blocking fashion.
>>> Each command defined by the specification has a corresponding
>>> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
>>> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
>>> mode of operation. Currently the driver supports only blocking calls, which
>>> doesn't allow asynchronous operation. This patch changes it and adds support
>>> for nonblocking write and a new poll function to enable applications using
>>> the API as designed by the spec.
>>> The new functionality can be tested using standard TPM tools implemented
>>> in [2], with modified TCTI from [3].
>>
>> I would need some statistics before I have interest to take these
>> changes in any form eg use case where this matters in the end.
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

I tried to run some tests w/r/t blocking to non-blocking.
and for example for tpm2_createprimary (type RSA) it looks more less like this:
blocking:
real	0m3.194s
user	0m0.052s
sys	0m0.094s

vs nonblocking:
real	0m1.031s
user	0m0.043s
sys	0m0.162s

that's on Minnowboard Turbot D0 PLATFORM
running FW Version: MNW2MAX1.X64.0097.R01.1709211204

The number are different every time I run it though.
Is this what you wanted to see?

Thanks,
-- 
Tadeusz
