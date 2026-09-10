Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980434CCE;
	Thu, 10 Sep 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023323; cv=none; b=ibmdvrS7M06rWBoO67hi8G7VY60r4H7SSojDV2vPeIgc74DaPxQQoqy/mp6TN3U3i9jNhb3eZ8wnFxZxJQUAtlUWXxL7+1uOs99Kl6p5sIaggb6alHjjVRQdAA234brYDtGhvIn9DS+CGLqF6F0bp7P9FJmEpsqINzXR9SOVV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023323; c=relaxed/simple;
	bh=jj3z29Emallfy9K8rLv5NTGg0hJSm5DQQN0T91YQ7wk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Fg9lHI3qMwdUjmr2B/pus6R/kO5W9i36qvA4pc9i5K/FZQjspADC8MklLFGyXDVMas81LH0PsYjqmSyTr/ZWEGVUhq13W2mJsB1StHf3xugsyidhiSCEw352f+4KrITh8KA9L4EI1klEDuXvGIljJ12I+48Bw9y0dNtrUXlHWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id D6FC9160226;
	Thu, 10 Sep 2026 02:45:44 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id 78B511601F4;
	Thu, 10 Sep 2026 02:45:44 -0400 (EDT)
Message-ID: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
Date: Thu, 10 Sep 2026 02:45:43 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-integrity@vger.kernel.org
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org
From: Sean Meadows <Hellfire@unspacy.com>
Subject: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58

Hello,

I am writing to report a reproducible power management bug where the
system permanently hangs late in the ACPI S3 (sleep), S5 (shutdown), and
soft reboot cycle.

The deadlock occurs at the absolute end of the platform teardown
sequence; after the kernel has completely unmounted all local storage.
Motherboard power rails remain fully active and fans spin continuously,
requiring a physical power button reset. Because this happens post
unmount and after the video terminates, standard runtime logs (pstore/
dmesg) remain entirely empty.

While sleep and shutdown hang forever, the soft reboot path has multiple 
severe failure modes: hanging indefinitely, stalling for several minutes 
before completing, or forcing a hard reset that corrupts the subsequent 
POST phase. Standard kernel parameters like reboot=EFI, reboot=PCI, or 
cold boot do not mitigate the issue.

The deadlock does not happen immediately after a recent cold boot or
reboot. The system must run for a number of hours before the condition
occurs.

1. Reproduction
The failure state can be made consistently repeatable via kernel
initialization parameters and modprobe.d blacklist:

- Test A (Fail State): Booting with standard parameters. Triggering an
S3 sleep, S5 shutdown, or reboot results in a guaranteed, hardware freeze.

- Test B (Pass State): Booting with the command line parameter:
‘modprobe.blacklist=tpm_crb’ and modprobe.d conf with ‘blacklist tpm_crb’
When the tpm_crb driver is completely prevented from initializing, the
system executes S3 suspend, S5 shutdown, and reboot sequences flawlessly
100% of the time.

- Other end users suffering from this problem have found a repeatable
fix by going into the UEFI and disabling the PTT. My particular system
lacks that option.

2. Supporting Data
This bug appears to be unique to the Intel PTT controllers powering the
6th through 10th Generation Intel CPU families (Skylake through Comet
Lake), spanning mobile, desktop, and HEDT platforms. The bulk of the
data also implies that this isn’t isolated to a specific OEM.

- Bugzilla #217890:
   chriscjsus: MSI GS40 6QE | Intel i7-6700HQ
   mahasler: Intel NUC7i3BNB | Intel Core i3-7100U
   Boris Carvajal: MSI Z370 Tomahawk | Intel i5-8400
   Serhii Tsynailo: Intel i5-8250u laptop
   Sergio: ASUS ZenBook UX310UQK | Intel i7-7500U
   My System: ASUS ROG GL703VM | HM175 Chipset | Intel i7-7700HQ | MEI FW
v11.9.1.3010 | Running Arch Linux vanilla stable kernel 7.2.4 (stock
package)

- Community Threads:
   Arch Forum (ID: 303082): Solved exclusively by disabling Intel PTT in
BIOS (Gigabyte B460 | Intel 10th Gen)
   Reddit (r/archlinux): Widespread tracking detailing identical S3/S5
deadlocks (X299/Z370)

3. Additional Details
An unmerged diagnostic patch submitted by another user (Adam Alves,
Patchwork ID: 20240307000331.14848-2-adamoa@gmail.com) previously
presumed that this late freeze on certain motherboards occurs because
the driver leaves the fTPM/PTT hardware interface in an unreleased, non-
zero locality state upon teardown. The author suggested that the
platform firmware's pre-OS and ACPI transition environments expect the
TPM to be sitting strictly in Locality 0, causing the firmware to enter
an infinite timeout wait-state when control is passed back to it.

I am not qualified to audit the driver. Whether this belongs in the DMI,
is a mistake in the driver logic, or is a bug in the PTT I can’t answer.
I can only point to the unfailing success of a growing number of public
end users who can instantly fix the problem by disabling the PTT in
firmware or blacklisting the TPM driver. I have included the ACPI
team in this e-mail in the hopes that they can provide additional clarity.

I have never compiled a custom kernel before, but I am set up to
reproduce this and am entirely willing to act as a tester for any
diagnostic patches the maintainers would like to provide.

Thank you for your time and patience,
Sean
