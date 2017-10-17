Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:52722 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764008AbdJQUFA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 16:05:00 -0400
Subject: Re: char/tpm: Improve a size determination in nine functions
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <1508268493.4513.39.camel@linux.vnet.ibm.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <0c0adf54-ecaa-0a46-d4d0-1cd9718de913@users.sourceforge.net>
Date: Tue, 17 Oct 2017 22:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <1508268493.4513.39.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> Do you find my wording "This issue was detected by using the
>> Coccinelle software." insufficient?
> 
> The question is not whether it is insufficient, but whether it is appropriate.

I am curious on how our corresponding discussion will evolve further.


> Detecting Coccinelle issues is one step.  The next step is deciding
> what to do with them.

Will the clarification achieve any more useful results?


> Up to now, these messages have been sent out as informational, not as patches.

I sent some update suggestions as patches also in this series (as usual).


> Before sending patches to change existing code, address the "problem"
> so that it doesn't continue to happen.

It might be very challenging to achieve such a goal.


> Only afterwards is it appropriate to discuss what to do with existing code.

I would prefer to get corresponding improvements in both areas in parallel
(if it is generally possible).

Regards,
Markus
