Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10813 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbeFTApf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jun 2018 20:45:35 -0400
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        James.Bottomley@HansenPartnership.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
 <20180619131046.GC5609@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
Date: Tue, 19 Jun 2018 17:45:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180619131046.GC5609@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/19/2018 06:10 AM, Jarkko Sakkinen wrote:
> On Tue, Jun 12, 2018 at 10:58:26AM -0700, Tadeusz Struk wrote:
>> The TCG SAPI specification [1] defines a set of functions, which allows
>> applications to use the TPM device in either blocking or non-blocking fashion.
>> Each command defined by the specification has a corresponding
>> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
>> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
>> mode of operation. Currently the TPM driver supports only blocking calls,
>> which doesn't allow asynchronous IO operations.
>> This patch changes it and adds support for nonblocking write and a new poll
>> function to enable applications, which want to take advantage of this feature.
>> The new functionality can be tested using standard TPM tools implemented
>> in [2], together with modified TCTI from [3].
>>
>> [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
>> [2] https://github.com/tpm2-software/tpm2-tools
>> [3] https://github.com/tstruk/tpm2-tss/tree/async
> 
> For me the value is still a bit questionable. The benchmark looks a bit
> flakky to give much figures how this would work with real world workloads.
> 
> I read James response and I also have to question why not just a worker
> thread in user space? TPM does only one command at a time anyways.
> 
> Cannot take this in before I know that user space will (1) adapt to
> this and (2) gain value compared to a worker thread.
> 
Hi Jarkko,
Thanks for reviewing the patch.
There are applications/frameworks where a worker thread is not an option.
Take for example the IoT use-cases and frameworks like IoT.js, or "Node.js for IoT".
They are all single threaded, event-driven frameworks, using non-blocking I/O as the base of their processing model.
Similarly embedded applications, which are basically just a single threaded event loop, quite often don't use threads because of resources constrains.

If your concern is that user space will not adopt to this, I can say that TSS library [1] is currently blocked on this feature, and we can not enable some of the use-cases mentioned above because of this.

Thanks,
Tadeusz

[1] https://github.com/tpm2-software/tpm2-tss
