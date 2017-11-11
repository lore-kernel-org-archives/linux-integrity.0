Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbdKKTM7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Nov 2017 14:12:59 -0500
Date: Sat, 11 Nov 2017 12:12:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Laurent Bigonville <bigon@debian.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171111191257.owuqtgzie3ostsab@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20171024135123.uqail7olnespun4k@linux.intel.com>
 <20171024145706.na56ff34w5agzo2t@rhwork>
 <20171024160725.r6kj452jdzpkbb6o@linux.intel.com>
 <8f4df9a9-c8cd-832f-4c3f-5305fabab7a8@debian.org>
 <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171111154516.GI17451@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat Nov 11 17, Jason Gunthorpe wrote:
>On Fri, Nov 10, 2017 at 01:53:00PM -0700, Jerry Snitselaar wrote:
>
>> I wonder if it is possible that the release locality from the probe
>> isn't completing on the chip until after the request/check that
>> happens at the beginning of the tpm_get_timeouts.  Perhaps we need
>> something like wait_for_tpm_stat for the access register, and
>> verifying that locality was released before returning out of
>> release_locality?
>
>This is not a bad guess.. Adding a largish delay after
>release_locality might be interesting too.
>
>Are we sure our tis request/release process is even right? Another

At this point, no? :) The tpm1.2 and tpm2.0 tis devices I have
access to seem to behave properly, and the traces look like I'd
expect, but that doesn't prove anything.

I think the check_locality code is okay since it is looking at the
access register for the desired locality and seeing if the active
locality and valid register bits are set. According to the fifo
interface locality usage per register chart, the access register
should always return correct values unlike the status register.

For request_locality, currently it sets the request use bit in the
access register, and then does check_locality potentially up until
timeout a. Looking at the spec, it could take longer than timeout a
if there is another active locality. It can take up until timeout a
from the point where that locality relinquishes the tpm. So that
could possibly be improved.

Before the release_locality code would only actually release the
locality if the request use bit was set. So after it grabbed the
locality during probe it probably never released it. The idea with the
new code was to release it when it was no longer needed so another
requester would be able to take the tpm without having to wait for it
to be released. With the old code I think it would have to wait either
until the next time release_locality was called, or attempt to seize
the tpm with the seize bit in the access register. I need to read
through the spec some more, but does the tpm ever force a change when
the request use bit is set, or does it leave it up to the software
to deal with it and only gets involved in the case where the seize
bit has been set?

/me goes back to reading specs

>options is that the 'check if already in locality' doesn't work on
>this chip, or isn't coded right...
>
>Jason
