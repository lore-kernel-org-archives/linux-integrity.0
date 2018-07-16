Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42281 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbeGPUjm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Jul 2018 16:39:42 -0400
Subject: Re: [PATCH] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        flihp <flihp@twobit.us>
Cc: linux-integrity@vger.kernel.org
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180604195554.GD2691@linux.intel.com>
 <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
 <20180618182517.GF20697@linux.intel.com>
 <f52e541e-123e-0849-2cc7-8baf7fa39616@twobit.us>
 <20180716173411.GA5780@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <7c197161-9cb2-1e67-bb7f-b360d557bad9@intel.com>
Date: Mon, 16 Jul 2018 13:10:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180716173411.GA5780@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/16/2018 10:34 AM, Jarkko Sakkinen wrote:
> On Thu, Jul 05, 2018 at 04:15:06PM -0700, flihp wrote:
>> Thanks for reviewing the patch Jarkko. While you're doing that I took
>> some time to hack up code to demonstrate the utility of supporting this
>> feature. The code can be found here:
>>
>> https://github.com/flihp/glib-tss2-async-example
>>
>> In short, the example application `glib-tss2-event` uses a glib main
>> event loop to create an RSA 2048 primary key in the TPM2 NULL hierarchy
>> while using a glib timer event to time the operation. A GSource object
>> is used to generate an event when the FD underlying the tss2 function
>> call has data ready. While the application waits for an event indicating
>> that the CreatePrimary operation is complete, it counts timer events
>> that occur every 100ms. Once the CreatePrimary operation completes the
>> number of timer events that occurred is used to make a rough calculation
>> of the elapsed time. This value is then printed to the console.
>>
>> This takes ~300 lines of C code and requires no management or
>> synchronization of threads. The glib GMainContext is "just a poll()
>> loop" according to the glib documentation here:
>>
>> https://developer.gnome.org/programming-guidelines/stable/main-contexts.html.en
>>
>> and so supporting 'poll' is the easiest way to integrate with glib /
>> gtk+. This is true of any other event system that relies on 'poll'
>> instead of worker threads.
>>
>> I've tested this against the userspace resource management daemon (which
>> supports 'poll') as well as the kernel interface using Tadeusz's patch
>> currently under review here. If / when this gets merged feel free to add
>> a "tested-by" line for myself:
>> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> 
> I see the value now. I'll test this at early August when I'm back from
> my leave.
> 
> Noticed now that the whole patch should be reposted because CC is missing
> linux-kernel and linux-security-module (maybe with a link to your test
> application in the cover letter).

I'll rebase and resend it after you will be back from vacation.
Thanks,
-- 
Tadeusz
