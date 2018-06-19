Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15438 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937703AbeFSNKw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jun 2018 09:10:52 -0400
Date: Tue, 19 Jun 2018 16:10:46 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
Message-ID: <20180619131046.GC5609@linux.intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jun 12, 2018 at 10:58:26AM -0700, Tadeusz Struk wrote:
> The TCG SAPI specification [1] defines a set of functions, which allows
> applications to use the TPM device in either blocking or non-blocking fashion.
> Each command defined by the specification has a corresponding
> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> mode of operation. Currently the TPM driver supports only blocking calls,
> which doesn't allow asynchronous IO operations.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this feature.
> The new functionality can be tested using standard TPM tools implemented
> in [2], together with modified TCTI from [3].
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
> [2] https://github.com/tpm2-software/tpm2-tools
> [3] https://github.com/tstruk/tpm2-tss/tree/async

For me the value is still a bit questionable. The benchmark looks a bit
flakky to give much figures how this would work with real world workloads.

I read James response and I also have to question why not just a worker
thread in user space? TPM does only one command at a time anyways.

Cannot take this in before I know that user space will (1) adapt to
this and (2) gain value compared to a worker thread.

/Jarkko
