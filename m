Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f179.google.com ([209.85.166.179]:38499 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJMAt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 20:49:28 -0400
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
Message-ID: <8059e3db-ee39-d5a4-b8b4-1cb2c69bf82e@gmail.com>
Date: Fri, 12 Oct 2018 12:15:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Nick,

>> Refer to
>> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
>> for details.
> 
>   Can you cite the relevant section?
> 

Just pick any section that describes a TPM command.  I randomly used 
Section 10.3 for TPM Unbind.  See the 'Incoming operands and sizes' table.

Regards,
-Denis
