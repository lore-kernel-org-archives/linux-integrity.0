Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A13839A9;
	Fri, 18 Sep 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694893; cv=none; b=hBZYBTWvG2GvPberVfZU2ky2W4b6apIiALhgrNYBmgi6HT4ytHW96W2ZIVEGwEKtfdOKdQ3wFNo7vKJ689XZgmKnmWzcxGS6D2Hyl1+/dQ6Egq5NGIMNvZwfGjeemTD2CLOYiO8nvSmFsUoFRaE8VdH8XlrqgMWITwblhr/V7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694893; c=relaxed/simple;
	bh=GgAZmgmQpSQCaYRytpAvepaHzxj/8+VNT3qaswZN4+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpxImw02NbCp1VSOLoViWBEv+3WbFIGXVwmdWoPKIgqj+7jH7DNwsHs08EFMYy/7Hd1eDLQ3pTffCTaSO4257WjXDpsQjtLudqTG6u6uObJcLp1f13+g6UVHfHdzLgUVEi3M0jFAsuNbrvY+5gk1nNKFkt6poyr8RkmyiAPE8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI0y3TNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI0y3TNG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 21CE01F000FF;
	Fri, 18 Sep 2026 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694891;
	bh=nF5U1y1muTP0LW49SJYENgz9dPB+9qce3Bdy11JKD0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nI0y3TNGLzZieCm7ebIAwEZM4n6utzderY9ypcb2BPm92KFszEcFQdfrgbRIIX2IB
	 TFEkGQyjyJK1icqau7KXwHIrAocUrdm1zN5U211ZcDx+irUaHgah3p6kU6MANvle+J
	 YRDKfCJ8EQ68kXtgTsnTlpkQLf+BGfWI+V6VdGRY7CgCf2qdcmj4EqZtW2MS0QH6Nd
	 c+dm1gJkgnfRKN9UHW2hR+bPQZtzpPngFBpkS2ApBAr+Z3HieMwEsCGx3Rq4LYSJdG
	 KkOgUQ3jb/TE4VRe/47HSPdLKmpeLUu+pO3G8JktDsSaGkobBSJNYRZbtOjVt3jFnc
	 VyF84sD+bmRfQ==
Date: Fri, 18 Sep 2026 04:28:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <aqyTpzk3jcarEMVS@kernel.org>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>

On Thu, Sep 10, 2026 at 02:45:43AM -0400, Sean Meadows wrote:
> Hello,
> 
> I am writing to report a reproducible power management bug where the
> system permanently hangs late in the ACPI S3 (sleep), S5 (shutdown), and
> soft reboot cycle.
> 
> The deadlock occurs at the absolute end of the platform teardown
> sequence; after the kernel has completely unmounted all local storage.
> Motherboard power rails remain fully active and fans spin continuously,
> requiring a physical power button reset. Because this happens post
> unmount and after the video terminates, standard runtime logs (pstore/
> dmesg) remain entirely empty.
> 
> While sleep and shutdown hang forever, the soft reboot path has multiple
> severe failure modes: hanging indefinitely, stalling for several minutes
> before completing, or forcing a hard reset that corrupts the subsequent POST
> phase. Standard kernel parameters like reboot=EFI, reboot=PCI, or cold boot
> do not mitigate the issue.
> 
> The deadlock does not happen immediately after a recent cold boot or
> reboot. The system must run for a number of hours before the condition
> occurs.
> 
> 1. Reproduction
> The failure state can be made consistently repeatable via kernel
> initialization parameters and modprobe.d blacklist:
> 
> - Test A (Fail State): Booting with standard parameters. Triggering an
> S3 sleep, S5 shutdown, or reboot results in a guaranteed, hardware freeze.
> 
> - Test B (Pass State): Booting with the command line parameter:
> ‘modprobe.blacklist=tpm_crb’ and modprobe.d conf with ‘blacklist tpm_crb’
> When the tpm_crb driver is completely prevented from initializing, the
> system executes S3 suspend, S5 shutdown, and reboot sequences flawlessly
> 100% of the time.
> 
> - Other end users suffering from this problem have found a repeatable
> fix by going into the UEFI and disabling the PTT. My particular system
> lacks that option.
> 
> 2. Supporting Data
> This bug appears to be unique to the Intel PTT controllers powering the
> 6th through 10th Generation Intel CPU families (Skylake through Comet
> Lake), spanning mobile, desktop, and HEDT platforms. The bulk of the
> data also implies that this isn’t isolated to a specific OEM.
> 
> - Bugzilla #217890:
>   chriscjsus: MSI GS40 6QE | Intel i7-6700HQ
>   mahasler: Intel NUC7i3BNB | Intel Core i3-7100U
>   Boris Carvajal: MSI Z370 Tomahawk | Intel i5-8400
>   Serhii Tsynailo: Intel i5-8250u laptop
>   Sergio: ASUS ZenBook UX310UQK | Intel i7-7500U
>   My System: ASUS ROG GL703VM | HM175 Chipset | Intel i7-7700HQ | MEI FW
> v11.9.1.3010 | Running Arch Linux vanilla stable kernel 7.2.4 (stock
> package)
> 
> - Community Threads:
>   Arch Forum (ID: 303082): Solved exclusively by disabling Intel PTT in
> BIOS (Gigabyte B460 | Intel 10th Gen)
>   Reddit (r/archlinux): Widespread tracking detailing identical S3/S5
> deadlocks (X299/Z370)
> 
> 3. Additional Details
> An unmerged diagnostic patch submitted by another user (Adam Alves,
> Patchwork ID: 20240307000331.14848-2-adamoa@gmail.com) previously
> presumed that this late freeze on certain motherboards occurs because
> the driver leaves the fTPM/PTT hardware interface in an unreleased, non-
> zero locality state upon teardown. The author suggested that the
> platform firmware's pre-OS and ACPI transition environments expect the
> TPM to be sitting strictly in Locality 0, causing the firmware to enter
> an infinite timeout wait-state when control is passed back to it.
> 
> I am not qualified to audit the driver. Whether this belongs in the DMI,
> is a mistake in the driver logic, or is a bug in the PTT I can’t answer.
> I can only point to the unfailing success of a growing number of public
> end users who can instantly fix the problem by disabling the PTT in
> firmware or blacklisting the TPM driver. I have included the ACPI
> team in this e-mail in the hopes that they can provide additional clarity.
> 
> I have never compiled a custom kernel before, but I am set up to
> reproduce this and am entirely willing to act as a tester for any
> diagnostic patches the maintainers would like to provide.
> 
> Thank you for your time and patience,
> Sean

Has this appeared within some timeframe or has been like this "forever"?

BR, Jarkko
