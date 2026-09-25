Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552E4BD34B;
	Fri, 25 Sep 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348740; cv=none; b=rROTptzc/nYL3ysP1f+vU3rsNHWnTPSh5oxuZImhh4bTIBKF//kCG3t2/u0l6wROJIbtlwWrmwEucyejvP83AQVuUt4F8G7TD5LqG7vbA3ITiAYTHzDmhrOkizbsBKT7pwyXVwD1OsuYVfsSqUwji16lTdsOCRRtGQV0lsM6y0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348740; c=relaxed/simple;
	bh=Ez+PajV45ntCnBvpFQYVxb6qXBbrJ/8R8rOVSnv88lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3AXGjedOZOcQsiq7oYEcv/daysHXPwGqLVmUvROe5FfuCQemuM1x1VgT+4G1wwURBPoR0QDFXCmOrAKQm4Pcy39VU2reAMORPl6OjqvRNpN7/mqb18UG5K9uYgWMQN0X/QTyuzbQ/57Mzws5o8BUSj2REdPmzWD/DjX3UFQtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmc2i8w5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmc2i8w5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B420D1F000FF;
	Fri, 25 Sep 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348724;
	bh=ZS7d5mturpa1Uxy0hoSuU+tlY5LaNK+P84DFQE9LUM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zmc2i8w5iSEedzxTpw6gVE7g3DhZ8VcsGpI9gbNrJ3xjPwPSCAenpgeE06XR92Hrj
	 I0GV7+4djle5puKOxh1W+NCR6ZQikXl+8IxQrWtxPGGgwlqytO2j0IuekKn/XEcP6o
	 4MfnfCBHFvocoC2aUU4vOxwfFvqdnLUGwpHzWHWQDgAorUmi9cXcFMpXUAQ3+30Qvu
	 XZcmgMFBqiDzTq1gXPUCWvvlsvT3z/KVTSLaTba8Ni2KUIzELL3yoQU3WOvvPtM6Fw
	 t2QjqQYbAvDTMDkupGpAv94o6dnAlUgjJ/uNK5UcOJ30Ni1Q+pfN3AP/1pBerERQqQ
	 iM7ktLsdhfUdQ==
Date: Fri, 25 Sep 2026 18:05:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <araNsEodZ3NXf9qT@kernel.org>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>

On Tue, Sep 22, 2026 at 04:42:47AM -0400, Sean Meadows wrote:
> On 9/17/26 21:28, Jarkko Sakkinen wrote:
> > On Thu, Sep 10, 2026 at 02:45:43AM -0400, Sean Meadows wrote:
> > > Hello,
> > > 
> > > I am writing to report a reproducible power management bug where the
> > > system permanently hangs late in the ACPI S3 (sleep), S5 (shutdown), and
> > > soft reboot cycle.
> > > 
> > > The deadlock occurs at the absolute end of the platform teardown
> > > sequence; after the kernel has completely unmounted all local storage.
> > > Motherboard power rails remain fully active and fans spin continuously,
> > > requiring a physical power button reset. Because this happens post
> > > unmount and after the video terminates, standard runtime logs (pstore/
> > > dmesg) remain entirely empty.
> > > 
> > > While sleep and shutdown hang forever, the soft reboot path has multiple
> > > severe failure modes: hanging indefinitely, stalling for several minutes
> > > before completing, or forcing a hard reset that corrupts the subsequent POST
> > > phase. Standard kernel parameters like reboot=EFI, reboot=PCI, or cold boot
> > > do not mitigate the issue.
> > > 
> > > The deadlock does not happen immediately after a recent cold boot or
> > > reboot. The system must run for a number of hours before the condition
> > > occurs.
> > > 
> > > 1. Reproduction
> > > The failure state can be made consistently repeatable via kernel
> > > initialization parameters and modprobe.d blacklist:
> > > 
> > > - Test A (Fail State): Booting with standard parameters. Triggering an
> > > S3 sleep, S5 shutdown, or reboot results in a guaranteed, hardware freeze.
> > > 
> > > - Test B (Pass State): Booting with the command line parameter:
> > > ‘modprobe.blacklist=tpm_crb’ and modprobe.d conf with ‘blacklist tpm_crb’
> > > When the tpm_crb driver is completely prevented from initializing, the
> > > system executes S3 suspend, S5 shutdown, and reboot sequences flawlessly
> > > 100% of the time.
> > > 
> > > - Other end users suffering from this problem have found a repeatable
> > > fix by going into the UEFI and disabling the PTT. My particular system
> > > lacks that option.
> > > 
> > > 2. Supporting Data
> > > This bug appears to be unique to the Intel PTT controllers powering the
> > > 6th through 10th Generation Intel CPU families (Skylake through Comet
> > > Lake), spanning mobile, desktop, and HEDT platforms. The bulk of the
> > > data also implies that this isn’t isolated to a specific OEM.
> > > 
> > > - Bugzilla #217890:
> > >    chriscjsus: MSI GS40 6QE | Intel i7-6700HQ
> > >    mahasler: Intel NUC7i3BNB | Intel Core i3-7100U
> > >    Boris Carvajal: MSI Z370 Tomahawk | Intel i5-8400
> > >    Serhii Tsynailo: Intel i5-8250u laptop
> > >    Sergio: ASUS ZenBook UX310UQK | Intel i7-7500U
> > >    My System: ASUS ROG GL703VM | HM175 Chipset | Intel i7-7700HQ | MEI FW
> > > v11.9.1.3010 | Running Arch Linux vanilla stable kernel 7.2.4 (stock
> > > package)
> > > 
> > > - Community Threads:
> > >    Arch Forum (ID: 303082): Solved exclusively by disabling Intel PTT in
> > > BIOS (Gigabyte B460 | Intel 10th Gen)
> > >    Reddit (r/archlinux): Widespread tracking detailing identical S3/S5
> > > deadlocks (X299/Z370)
> > > 
> > > 3. Additional Details
> > > An unmerged diagnostic patch submitted by another user (Adam Alves,
> > > Patchwork ID: 20240307000331.14848-2-adamoa@gmail.com) previously
> > > presumed that this late freeze on certain motherboards occurs because
> > > the driver leaves the fTPM/PTT hardware interface in an unreleased, non-
> > > zero locality state upon teardown. The author suggested that the
> > > platform firmware's pre-OS and ACPI transition environments expect the
> > > TPM to be sitting strictly in Locality 0, causing the firmware to enter
> > > an infinite timeout wait-state when control is passed back to it.
> > > 
> > > I am not qualified to audit the driver. Whether this belongs in the DMI,
> > > is a mistake in the driver logic, or is a bug in the PTT I can’t answer.
> > > I can only point to the unfailing success of a growing number of public
> > > end users who can instantly fix the problem by disabling the PTT in
> > > firmware or blacklisting the TPM driver. I have included the ACPI
> > > team in this e-mail in the hopes that they can provide additional clarity.
> > > 
> > > I have never compiled a custom kernel before, but I am set up to
> > > reproduce this and am entirely willing to act as a tester for any
> > > diagnostic patches the maintainers would like to provide.
> > > 
> > > Thank you for your time and patience,
> > > Sean
> > 
> > Has this appeared within some timeframe or has been like this "forever"?
> > 
> > BR, Jarkko
> 
> Hi Jarkko,
> 
> Regarding whether this has been a bug forever, I suspect the answer is
> yes, though with a few caveats. My pacman.log shows I made the shift
> from Windows to Arch Linux in August 2022. Vaguely I recall reboots, S3,
> and S5 working initially, but I am an unreliable narrator after dealing
> with this issue for years - and the various technical threads I
> referenced do note regressions cropping up across the 6.x kernel series.
> 
> I also need to update my previous notes regarding blacklisting tpm_crb.
> It is not a complete fix; rather, it extends the timeframe of the
> failure from hours to days, but the deadlock will eventually happen
> anyway. That leaves the only foolproof fixes as running Windows or
> having a UEFI that allows disabling the PTT.
> 
> My working hypothesis is that these older PTT implementations require a
> specific state cleanup during OS teardown. Since the issue occurs even
> without the driver loaded, the problem isn't isolated to driver
> teardown; rather, it implies that background ACPI firmware routines
> interact with the PTT, gradually desynchronizing the hardware state until
> the final power-down handoff traps it.
> 
> My testing hasn't stopped. I am currently trying to modify my UEFI to
> force-disable the PTT, though customizing the ROM and flashing it with a
> CH341A programmer and micrograbbers is slow, tedious work. I am also
> hampered by the Asus UEFI being very fragile and the hidden TPM options
> tested so far turning out to be dead entries.
> 
> As I noted before, I am fully prepared to test patches or gather
> hardware data, though I suspect this laptop lacks any accessible serial
> debugging headers to catch logs post-unmount.
> 
> Thank you for your time and patience,

Thanks for providing the information.

Bugzilla bug under discussion: https://bugzilla.kernel.org/show_bug.cgi?id=217890

I also found fix attempt of which 3rd version somehow went past me:

https://lore.kernel.org/all/20240308145313.40932-1-adamoa@gmail.com/

Does this or disabling hwrng sort out the issue?

I got one other idea too with no empirical basis (just hypothesis):
perhaps release memory mapping on suspend could help firmware.

> 
> Sean

Br, Jarkko
