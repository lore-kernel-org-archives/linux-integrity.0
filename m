Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40560 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755292AbdLTS0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:26:06 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so11437548wmf.5
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:26:06 -0800 (PST)
Subject: Re: [PATCH 2/4] tpm: delete the TPM_TIS_CLK_ENABLE flag
To: Jason Gunthorpe <jgg@ziepe.ca>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-3-javierm@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828988730@ORSMSX109.amr.corp.intel.com>
 <20171220181005.GC22908@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <1cde2001-9ec0-02b3-42cc-11e931c0b22a@redhat.com>
Date: Wed, 20 Dec 2017 19:26:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171220181005.GC22908@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/20/2017 07:10 PM, Jason Gunthorpe wrote:
> On Wed, Dec 20, 2017 at 03:19:19PM +0000, Shaikh, Azhar wrote:
>>> This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
>>> systems, but the only way this can happen is if the code is not correct.
>>>
>>> So it's an unnecessary check that just makes the code harder to read.
>>
>> This code was implemented as a suggestion from Jason on the previous patches. 
>> https://www.spinics.net/lists/linux-integrity/msg00827.html
> 
> The concept was to be like ASSERT_RTNL, maybe it just needs a suitably
> named static inline to addrress Javier's readability concerns?
>

I really think is not worth it and pollutes all the tpm_tcg_{read,write}
functions with those is_bsw() and flags checks. Your example is different
since is a core API used by in lot of places in the kernel, but it's not
the case here.

But I don't have a strong opinion either, it was Jarkko who questioned
the value of the flag so I can drop this patch too if you disagree with
the change. I'm mostly interested in PATCH 4/4 that's the actual fix.
 
> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
