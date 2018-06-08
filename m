Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43403 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeFHTgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 15:36:21 -0400
Received: by mail-ot0-f196.google.com with SMTP id i19-v6so16991426otk.10
        for <linux-integrity@vger.kernel.org>; Fri, 08 Jun 2018 12:36:21 -0700 (PDT)
Subject: Re: [PATCH] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180604195554.GD2691@linux.intel.com>
From: flihp <flihp@twobit.us>
Message-ID: <f270fec0-cd79-0119-b84d-3af23bc3b150@twobit.us>
Date: Fri, 8 Jun 2018 12:36:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180604195554.GD2691@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/04/2018 12:55 PM, Jarkko Sakkinen wrote:
> On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
>> The TCG SAPI specification [1] defines a set of functions, which allows
>> applications to use the TPM device in either blocking or non-blocking fashion.
>> Each command defined by the specification has a corresponding
>> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
>> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
>> mode of operation. Currently the driver supports only blocking calls, which
>> doesn't allow asynchronous operation. This patch changes it and adds support
>> for nonblocking write and a new poll function to enable applications using
>> the API as designed by the spec.
>> The new functionality can be tested using standard TPM tools implemented
>> in [2], with modified TCTI from [3].
> 
> I would need some statistics before I have interest to take these
> changes in any form eg use case where this matters in the end.

The use cases motivating this feature are the same ones that motivated
the non-blocking behavior of other kernel interfaces (files, sockets and
other hardware) that has the potential to block threads in a process. By
implementing this same behavior in the TPM driver our goal is to enable
use of the TPM in programming languages / frameworks implementing an
"event-driven" model. There are a lot of them out there but since the
TSS2 APIs are currently limited to C our example code is in glib / GSource.

Hopefully this is sufficient but if it isn't it would help us to get
additional details on what you're looking for.

Thanks,
Philip
