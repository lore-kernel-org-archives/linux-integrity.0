Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0141A571;
	Tue, 22 Sep 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067022; cv=none; b=k37pwQfVtc0OYU20f70+5cK+Uly9x2NcxYoJkjBlZlFAqdny4eDCIjA2/x3MR+2KUgCVh+3uCyqpTLxOOTL7NpFS+RkZbTR3Ilk3/B3I6cbsVIirPBeg3rH9KoIVMD3sXAen7+Gz1veJkwo6A5GULpZm1drebpkLRNNIVxv5Hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067022; c=relaxed/simple;
	bh=wpvmLOaXYHQPVaAlU4cnQEsqRgkfN+9BTYHawKmnlJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8seuYyAFPd9WFIY+0yrUBL8Zj6tuJIzyJ7hxIqut3LueQTQoXCSBBTq1k8w4V3DCdVLlz5AE0cX+9BIUPqKwgBdvvvIoOKMXYcZoPOYEu/sopc1++/YzKbjF8GpZ+rzZLEnDUPsMNfUUPo8IX14K5T5+ucMhZWf/MJSbbU427Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id 1028A160226;
	Tue, 22 Sep 2026 04:42:49 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id A45371601FA;
	Tue, 22 Sep 2026 04:42:48 -0400 (EDT)
Message-ID: <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
Date: Tue, 22 Sep 2026 04:42:47 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
Content-Language: en-US
From: Sean Meadows <Hellfire@unspacy.com>
In-Reply-To: <aqyTpzk3jcarEMVS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58

On 9/17/26 21:28, Jarkko Sakkinen wrote:
> On Thu, Sep 10, 2026 at 02:45:43AM -0400, Sean Meadows wrote:
>> Hello,
>>
>> I am writing to report a reproducible power management bug where the
>> system permanently hangs late in the ACPI S3 (sleep), S5 (shutdown), and
>> soft reboot cycle.
>>
>> The deadlock occurs at the absolute end of the platform teardown
>> sequence; after the kernel has completely unmounted all local storage.
>> Motherboard power rails remain fully active and fans spin continuously,
>> requiring a physical power button reset. Because this happens post
>> unmount and after the video terminates, standard runtime logs (pstore/
>> dmesg) remain entirely empty.
>>
>> While sleep and shutdown hang forever, the soft reboot path has multiple
>> severe failure modes: hanging indefinitely, stalling for several minutes
>> before completing, or forcing a hard reset that corrupts the subsequent POST
>> phase. Standard kernel parameters like reboot=EFI, reboot=PCI, or cold boot
>> do not mitigate the issue.
>>
>> The deadlock does not happen immediately after a recent cold boot or
>> reboot. The system must run for a number of hours before the condition
>> occurs.
>>
>> 1. Reproduction
>> The failure state can be made consistently repeatable via kernel
>> initialization parameters and modprobe.d blacklist:
>>
>> - Test A (Fail State): Booting with standard parameters. Triggering an
>> S3 sleep, S5 shutdown, or reboot results in a guaranteed, hardware freeze.
>>
>> - Test B (Pass State): Booting with the command line parameter:
>> ‘modprobe.blacklist=tpm_crb’ and modprobe.d conf with ‘blacklist tpm_crb’
>> When the tpm_crb driver is completely prevented from initializing, the
>> system executes S3 suspend, S5 shutdown, and reboot sequences flawlessly
>> 100% of the time.
>>
>> - Other end users suffering from this problem have found a repeatable
>> fix by going into the UEFI and disabling the PTT. My particular system
>> lacks that option.
>>
>> 2. Supporting Data
>> This bug appears to be unique to the Intel PTT controllers powering the
>> 6th through 10th Generation Intel CPU families (Skylake through Comet
>> Lake), spanning mobile, desktop, and HEDT platforms. The bulk of the
>> data also implies that this isn’t isolated to a specific OEM.
>>
>> - Bugzilla #217890:
>>    chriscjsus: MSI GS40 6QE | Intel i7-6700HQ
>>    mahasler: Intel NUC7i3BNB | Intel Core i3-7100U
>>    Boris Carvajal: MSI Z370 Tomahawk | Intel i5-8400
>>    Serhii Tsynailo: Intel i5-8250u laptop
>>    Sergio: ASUS ZenBook UX310UQK | Intel i7-7500U
>>    My System: ASUS ROG GL703VM | HM175 Chipset | Intel i7-7700HQ | MEI FW
>> v11.9.1.3010 | Running Arch Linux vanilla stable kernel 7.2.4 (stock
>> package)
>>
>> - Community Threads:
>>    Arch Forum (ID: 303082): Solved exclusively by disabling Intel PTT in
>> BIOS (Gigabyte B460 | Intel 10th Gen)
>>    Reddit (r/archlinux): Widespread tracking detailing identical S3/S5
>> deadlocks (X299/Z370)
>>
>> 3. Additional Details
>> An unmerged diagnostic patch submitted by another user (Adam Alves,
>> Patchwork ID: 20240307000331.14848-2-adamoa@gmail.com) previously
>> presumed that this late freeze on certain motherboards occurs because
>> the driver leaves the fTPM/PTT hardware interface in an unreleased, non-
>> zero locality state upon teardown. The author suggested that the
>> platform firmware's pre-OS and ACPI transition environments expect the
>> TPM to be sitting strictly in Locality 0, causing the firmware to enter
>> an infinite timeout wait-state when control is passed back to it.
>>
>> I am not qualified to audit the driver. Whether this belongs in the DMI,
>> is a mistake in the driver logic, or is a bug in the PTT I can’t answer.
>> I can only point to the unfailing success of a growing number of public
>> end users who can instantly fix the problem by disabling the PTT in
>> firmware or blacklisting the TPM driver. I have included the ACPI
>> team in this e-mail in the hopes that they can provide additional clarity.
>>
>> I have never compiled a custom kernel before, but I am set up to
>> reproduce this and am entirely willing to act as a tester for any
>> diagnostic patches the maintainers would like to provide.
>>
>> Thank you for your time and patience,
>> Sean
> 
> Has this appeared within some timeframe or has been like this "forever"?
> 
> BR, Jarkko

Hi Jarkko,

Regarding whether this has been a bug forever, I suspect the answer is
yes, though with a few caveats. My pacman.log shows I made the shift
from Windows to Arch Linux in August 2022. Vaguely I recall reboots, S3,
and S5 working initially, but I am an unreliable narrator after dealing
with this issue for years - and the various technical threads I
referenced do note regressions cropping up across the 6.x kernel series.

I also need to update my previous notes regarding blacklisting tpm_crb.
It is not a complete fix; rather, it extends the timeframe of the
failure from hours to days, but the deadlock will eventually happen
anyway. That leaves the only foolproof fixes as running Windows or
having a UEFI that allows disabling the PTT.

My working hypothesis is that these older PTT implementations require a
specific state cleanup during OS teardown. Since the issue occurs even
without the driver loaded, the problem isn't isolated to driver
teardown; rather, it implies that background ACPI firmware routines
interact with the PTT, gradually desynchronizing the hardware state 
until the final power-down handoff traps it.

My testing hasn't stopped. I am currently trying to modify my UEFI to
force-disable the PTT, though customizing the ROM and flashing it with a
CH341A programmer and micrograbbers is slow, tedious work. I am also
hampered by the Asus UEFI being very fragile and the hidden TPM options
tested so far turning out to be dead entries.

As I noted before, I am fully prepared to test patches or gather
hardware data, though I suspect this laptop lacks any accessible serial
debugging headers to catch logs post-unmount.

Thank you for your time and patience,

Sean
