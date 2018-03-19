Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:30682 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933000AbeCSVeZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 17:34:25 -0400
Date: Mon, 19 Mar 2018 23:34:20 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Andrey Pronin <apronin@chromium.org>
Cc: James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org
Subject: Re: Should we handle TPM_RC_RETRY internally?
Message-ID: <20180319213420.GF14364@linux.intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
 <20180316142958.GD9616@linux.intel.com>
 <1521215304.4379.8.camel@HansenPartnership.com>
 <CAP7wa8Kq_++HasQY6bZ9idJ_TDOyXhnRAmyUY6t1B+HZWKF8ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAP7wa8Kq_++HasQY6bZ9idJ_TDOyXhnRAmyUY6t1B+HZWKF8ig@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Mar 17, 2018 at 01:21:08AM +0000, Andrey Pronin wrote:
>    If the TSS starts retrying commands itself, then it's more than just
>    handling TPM_RC_RETRY.
>    There is also even more cryptic TPM_RC_YIELDED, which allows (suggests?)
>    retrying, and TPM_RC_NV_RATE, which covers one of the few legitimate and
>    easily explainable reasons why a command can fail now but succeed later.
>    And what about TPM_RC_MEMORY, TPM_RC_NV_UNAVAILABLE and such?
>    Though quite exotic, they are all warnings, and all indicate a possibly
>    temporary lack of access/resources. Unlike TPM_RC_*_HANDLES, CONTEXT_GAP
>    etc, they don't require RM to do anything with objects and handles to
>    recover, and may succeed if simply retried after a delay.
>    Shall these retries be also handled in tpm_transmit_cmd() or left up to
>    the caller to take care of? And how are they different from TPM_RC_RETRY
>    case, if the latter?
>    If you are interested in the actual in-kernel use of the commands that
>    can face such codes, look no further than tpm2_load_context().
>    The referenceA implementation may return TPM_RC_NV* fromA TPM2_ContextLoad
>    since it callsA NvIsAvailable().
>    --
>    Andrey

Hey, thanks for this feedback. It changed my point of view.

tpm_transmit_cmd() should be able to handle exactly the subset that in-kernel
clients of the TPM need, not more or less.

I do no want TPM_RC_RETRY logic at this point to tpm_transmit() path. We can
consider that later (maybe). It is at least too late to consider it in 4.17
timeline.

/Jarkko
