Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:51547 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdJXQOb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 12:14:31 -0400
MIME-Version: 1.0
In-Reply-To: <20171024161118.GA348@obsidianresearch.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
 <cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com> <20171023163139.GA17394@obsidianresearch.com>
 <20171024154440.3jeupmus43jcgbbz@linux.intel.com> <CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
 <20171024155526.GA32250@obsidianresearch.com> <CANc+2y6-P9MvjbL18h02SPwNMPyk4_cPFfL6LKHDXiKSHfv00A@mail.gmail.com>
 <20171024161118.GA348@obsidianresearch.com>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 24 Oct 2017 21:44:30 +0530
Message-ID: <CANc+2y4VYWUON2Uo5M7SyyxtrMPiyY1Ln0WEkFLzKsHJ0v_keA@mail.gmail.com>
Subject: Re: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
 in-kernel API
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE IMA"
        <linux-ima-user@lists.sourceforge.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Matt Mackall <mpm@selenic.com>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE IMA"
        <linux-ima-devel@lists.sourceforge.net>,
        David Safford <safford@us.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 24 October 2017 at 21:41, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Oct 24, 2017 at 09:37:33PM +0530, PrasannaKumar Muralidharan wrote:
>> Hi Jason,
>>
>> On 24 October 2017 at 21:25, Jason Gunthorpe
>> <jgunthorpe@obsidianresearch.com> wrote:
>> > On Tue, Oct 24, 2017 at 09:21:15PM +0530, PrasannaKumar Muralidharan wrote:
>> >
>> >> Please check the RFC [1]. It does use chip id. The rfc has issues and
>> >> has to be fixed but still there could be users of the API.
>> >>
>> >> 1. https://www.spinics.net/lists/linux-crypto/msg28282.html
>> >
>> > That patch isn't safe at all. You need to store a kref to th chip in
>> > the hwrng, not parse a string.
>>
>> The drivers/char/hw_random/tpm-rng.c module does not store the chip
>> reference so I guess the usage is safe.
>
> It is using the default TPM, it is always safe to use the default tpm.
>
>> The RFC is just a sample use case of the API.
>
> Well, a wrong example not to be emulated, and I think, further shows
> how Jarkko's direction is the right one.

I am wondering why it is wrong. Isn't the chip id valid till it is
unregistered? If so the rfc is correct. Please explain, may be I am
missing something.

Thanks,
PrasannaKumar
