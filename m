Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbdJYW0h (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 18:26:37 -0400
Date: Thu, 26 Oct 2017 00:26:10 +0200
In-Reply-To: <20171025185349.ocptudim3g35j6im@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com> <CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com> <20171025185349.ocptudim3g35j6im@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: Fixing CVE-2017-15361
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>
CC: linux-integrity <linux-integrity@vger.kernel.org>,
        Kari Hiitola <kari@varaani.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>
From: Peter Huewe <peterhuewe@gmx.de>
Message-ID: <F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



Am 25. Oktober 2017 20:53:49 MESZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:
>> On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>> > I'm implementing a fix for CVE-2017-15361 that simply blacklists
>> > vulnerable FW versions. I think this is the only responsible action
>from
>> > my side that I can do.
>> 
>> I'm not sure this is ideal - do Infineon have any Linux tooling for
>> performing firmware updates, and if so will that continue working if
>> the device is blacklisted? It's also a poor user experience to have
>> systems using TPM-backed disk encryption keys suddenly rendered
>> unbootable, and making it as easy as possible for people to do an
>> upgrade and then re-seal secrets with new keys feels like the correct
>> approach.
>
>I talked today with Alexander Steffen in the KS unconference and we
>concluded that this would be a terrible idea.
>
>Alexander stated the following things about FW updates (Alexander,
>please correct me if I state something incorrectly or if you have
>something to add):
>
>* FW update can be constructed either in a way that the keys in the
>  NVRAM are not cleared or in a way that they are cleared.
>* FW update cannot be directly applied to the TPM but must come as
>  part of the firmware update from the vendor.
>
>I proposed the following as an alternative:
>
>* Print a message to the klog (which log level would be appropriate?).
Info?
Maybe warn, definitely not err

>* Possibly sleep for few seconds. Is this a good idea?
Helps how?

>
>While writing this email yet another alternative popped into my mind:
>what if we allow only in-kernel use but disallow the use of /dev/tpm0?
>You could still use trusted keys.
>
No, same terrible idea since you block the upgrade path.
Upgrade tools work from userspace via the kernel driver. 
So /dev/tpm0 is necessary.

>Here are all the ideas that I have and I am open for better
>alternatives.
>
>/Jarkko

-- 
Sent from my mobile
