Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdLLVRo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Dec 2017 16:17:44 -0500
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        jarkko.sakkinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, james.l.morris@oracle.com,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
From: James Ettle <james@ettle.org.uk>
Message-ID: <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
Date: Tue, 12 Dec 2017 21:17:27 +0000
MIME-Version: 1.0
In-Reply-To: <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

OK, I built a kernel 4.14.5 from vanilla kernel.org sources using the Fedora .config (couldn't get the Fedora package to build).

I see no difference with both [0, 1] patches applied and the tpm modules loaded -- no keyboard or touchpad.

[Note: I'm not *consciously* using the TPM for anything, but /dev/tpm0 is present and have never initialised it. I don't know if anything in Fedora uses it by default if present.]

Regards,
James.


On 12/12/17 11:38, Javier Martinez Canillas wrote:
> Hello James,
> 
> On 12/11/2017 08:37 PM, James Ettle wrote:
>> Hello,
>>
>> [First: Apologies if cross-posting from Kernel.org BZ is bad form; my distro BZ advised I post this to your mailing list as well.]
>>
>> Situation: enabling TPM on a Clevo W510LU with an Intel N3160 CPU breaks PS/2 keyboard and mouse. They just don't respond until after a suspend/resume cycle, and after that they later stop after a while.
>>
>> I have confirmed this by blacklisting tpm modules. I noticed this first with kernel 4.13, and have bisected it down to:
>>
>> 5e572cab92f0bb56ca1e6e5ee4d807663a7ccbad is the first bad commit
>> commit 5e572cab92f0bb56ca1e6e5ee4d807663a7ccbad
>> Author: Azhar Shaikh <azhar.shaikh@intel.com>
>> Date:   Sun Jun 18 19:17:59 2017 -0700
>>
>>     tpm: Enable CLKRUN protocol for Braswell systems
>>     
>>     To overcome a hardware limitation on Intel Braswell systems,
>>     disable CLKRUN protocol during TPM transactions and re-enable
>>     once the transaction is completed.
>>     
>>     Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
>>     Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>     Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>     Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>     Signed-off-by: James Morris <james.l.morris@oracle.com>
>>
>> :040000 040000 5437c91886cb62c497255f2c60dbedd7268ab50d 1863a1738ded35a817aad52f9f2b451bd43623d7 M	drivers
>>
>> Currently in Kernel.org bugzilla 197287.
>>
>> Please let me know if you need any further info.
>>
> 
> I don't have access to a Braswell machine to reproduce this. I tried to do it
> on different Intel systems by modifying is_bsw() to always return true, but
> that didn't work either. They work correctly even when CLKRUN_EN is toggled.
> 
> I'm not familiar with LPC so please let me know if my assumptions are wrong,
> but I find suspicious that a driver for a single device attached to the bus
> can control the CLKRUN# signal which AFAIU may be needed for other devices.
> 
> So that would explain why the mentioned commit causes issues for PS/2 mouse
> and keyboards, since these are attached to the LPC bus and may rely on the
> CLKRUN# signal for proper operation.
> 
> I see that the following [0,1] patches for the tpm_tis driver landed a few
> days ago, they change how the CLKRUN protocol is enabled/disabled. Instead
> of doing it per each TPM transaction, it does it once for the duration of
> a TPM command.
> 
> Not sure if that will make things better or worse for you, but it would be
> good to try in case it makes a difference.
> 
> [0]: http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/667dcc75be864ff4c17cf58891853b7393bba3e2
> [1]: http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/db3248e8a036c39141c8f7e9f1cf5c5ae6815f76
> 
>> Many thanks,
>> James.
>>
> 
> Best regards,
> 
