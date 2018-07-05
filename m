Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41022 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeGEXPJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jul 2018 19:15:09 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so3862433ybe.8
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jul 2018 16:15:09 -0700 (PDT)
Subject: Re: [PATCH] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc: linux-integrity@vger.kernel.org
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180604195554.GD2691@linux.intel.com>
 <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
 <20180618182517.GF20697@linux.intel.com>
From: flihp <flihp@twobit.us>
Message-ID: <f52e541e-123e-0849-2cc7-8baf7fa39616@twobit.us>
Date: Thu, 5 Jul 2018 16:15:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180618182517.GF20697@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/18/2018 11:25 AM, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 12:36:18PM -0700, flihp wrote:
>> On 06/04/2018 12:55 PM, Jarkko Sakkinen wrote:
>>> On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
>>>> The TCG SAPI specification [1] defines a set of functions, which allows
>>>> applications to use the TPM device in either blocking or non-blocking fashion.
>>>> Each command defined by the specification has a corresponding
>>>> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
>>>> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
>>>> mode of operation. Currently the driver supports only blocking calls, which
>>>> doesn't allow asynchronous operation. This patch changes it and adds support
>>>> for nonblocking write and a new poll function to enable applications using
>>>> the API as designed by the spec.
>>>> The new functionality can be tested using standard TPM tools implemented
>>>> in [2], with modified TCTI from [3].
>>>
>>> I would need some statistics before I have interest to take these
>>> changes in any form eg use case where this matters in the end.
>>
>> The use cases motivating this feature are the same ones that motivated
>> the non-blocking behavior of other kernel interfaces (files, sockets and
>> other hardware) that has the potential to block threads in a process. By
>> implementing this same behavior in the TPM driver our goal is to enable
>> use of the TPM in programming languages / frameworks implementing an
>> "event-driven" model. There are a lot of them out there but since the
>> TSS2 APIs are currently limited to C our example code is in glib / GSource.
>>
>> Hopefully this is sufficient but if it isn't it would help us to get
>> additional details on what you're looking for.
> 
> Thanks Philip. I'll look into the patch itself.

Thanks for reviewing the patch Jarkko. While you're doing that I took
some time to hack up code to demonstrate the utility of supporting this
feature. The code can be found here:

https://github.com/flihp/glib-tss2-async-example

In short, the example application `glib-tss2-event` uses a glib main
event loop to create an RSA 2048 primary key in the TPM2 NULL hierarchy
while using a glib timer event to time the operation. A GSource object
is used to generate an event when the FD underlying the tss2 function
call has data ready. While the application waits for an event indicating
that the CreatePrimary operation is complete, it counts timer events
that occur every 100ms. Once the CreatePrimary operation completes the
number of timer events that occurred is used to make a rough calculation
of the elapsed time. This value is then printed to the console.

This takes ~300 lines of C code and requires no management or
synchronization of threads. The glib GMainContext is "just a poll()
loop" according to the glib documentation here:

https://developer.gnome.org/programming-guidelines/stable/main-contexts.html.en

and so supporting 'poll' is the easiest way to integrate with glib /
gtk+. This is true of any other event system that relies on 'poll'
instead of worker threads.

I've tested this against the userspace resource management daemon (which
supports 'poll') as well as the kernel interface using Tadeusz's patch
currently under review here. If / when this gets merged feel free to add
a "tested-by" line for myself:
Tested-by: Philip Tricca <philip.b.tricca@intel.com>

Thanks,
Philip
