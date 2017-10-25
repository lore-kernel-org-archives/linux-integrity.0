Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:56701 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbdJYInc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 04:43:32 -0400
Received: by mail-it0-f49.google.com with SMTP id r127so141517itb.5
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 01:43:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
References: <20171024222148.gwnkj5vqsyj43qer@linux.intel.com>
From: Thiebaud Weksteen <tweek@google.com>
Date: Wed, 25 Oct 2017 10:43:10 +0200
Message-ID: <CA+zpnLft_o-c2cRxtUEoAPbYiiLzmLqAPYwrkFDdVoyk5t6Zfw@mail.gmail.com>
Subject: Re: Proposal: rename tpm1_eventlog.c and tpm2_eventlog.c
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 12:21 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> I noticed when making slides for KS that the naming for event log stuff
> that the naming is so broken that it is hard to understand the code.
> Here it really would make sense to have a patch set just to clean up the
> cruft.

Agreed and happy to help.

>
> Random examples of more senseful naming:
>
> * tpm2_bios_measurements_start() should be rather something like
>   tpm_eventlog_seq_agile_start().
> * tpm_bios_measurements_start() should be rather something like
>   tpm_eventlog_seq_sha1_start().
>
> Corresponding structs would be tpm_eventlog_agile_seq_ops and
> tpm_eventlog_sha1_seq_ops.
>
> Finally, I would place the file operations, being so complicated, in
> separate files:
>
> * tpm_eventlog_seq_sha1.c
> * tpm_eventlog_seq_eventlog.c

I assume you meant tpm_eventlog_seq_agile.c ?

>
> And move all the management code that is right now illogically located
> in tpm1_eventlog.c to tpm_eventlog.c that would be the entry point for
> the event log.
>
> The code is laid out so badly right now that I have really hard time
> understanding it if I haven't looked at it within last couple of weeks.
> It's really a trainwreck at the moment. We must clean up it up fast.
>
> Getting this done will help me to review patches to this area faster
> so it would be a benefit for everyone. The current structure makes every
> event log patch a pain to review.

Since this may conflict with the last patch set I sent, are you happy
for me to base this new set on tpmdd/master?

>
> /Jarkko
