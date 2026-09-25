Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4B4B1CE7;
	Fri, 25 Sep 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347377; cv=none; b=Y+kXeq6Vy7nUzvlkL5rw/FcqdKnAXaQonELXDGMFQ7adGN12xFeT1lkwjnpyuS8c+GnM7hg8Ja7/JUumfd0OYna44uxnSFpO2N1PqBJSwWjbV1xeYeJoTrngafazpZwwfUBsGf7+RqlR7BA+KW0tBPlZd5EVEkXcthF5Z9ccYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347377; c=relaxed/simple;
	bh=qXDFdfbLPdju22SNkq8jMdXp89yToNzi8U8KDgQjDYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNLAiyX3anELOeiOQxWm4diovq7hoHeifHmwFbzvkyxwjUZgZVCpR/hz0u9qIDZpvgl0jcIrYMBECmlS10aj1bsandYY+X/GlDdjV62BKAu20FlOIvycriEoJyYs6OO4Qe7L18hLXqXV+cjqVcJt1PXdnyixF/ybAwuYf1V4CY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTvnBFyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTvnBFyr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 592AC1F00893;
	Fri, 25 Sep 2026 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347361;
	bh=XpmntfHqapA5n2tDlDs8XMOp6Qt664pexsdC2Qv/1oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTvnBFyrEfWRRNXGqoUypjwJFRlfuNU+bap7NotSUdjfejcnPM0+BrzKIfByinkTM
	 csPrsKtZtdQ+y09cVjzxZ/7sL43YhdTjmViSk2q2MLJE5XwxDokXTxTJNBMWOzcXkf
	 4Fxib3yk/VsL0eHJ+7yybdWxyh4aAab4Db+iFB3piHGP1IsGDmZkc/wvIfG1dkkX1p
	 WlSkqNFiRBM69dznDH01cmcsv3suMzUiuxMuhy2Xx5wX8edgwLS/j1NwI2tLZiFsMs
	 72i2aBkrvvb9BvuPXpbvEqfjvZm2aaC7HwqIbDzadO8mz0IItMsFVgOWocmFrQ3IYP
	 e2BTiO0iLet/g==
Date: Fri, 25 Sep 2026 17:42:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Delton Ding <dsh0416@gmail.com>
Cc: f13208471983@163.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <araIXvVos0eH2pMs@kernel.org>
References: <CA+mXNo2bBZg69RkKYauV_+K5zp=1kuHm1xLPwD6_ihZ_MzL0SQ@mail.gmail.com>
 <araEOkjz1f_vnl3A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <araEOkjz1f_vnl3A@kernel.org>

On Fri, Sep 25, 2026 at 05:25:02PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 20, 2026 at 02:33:12PM +0800, Delton Ding wrote:
> > Hi Jarkko and MicroFish,
> > 
> > I'm following up on this discussion:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2652132.html
> > 
> > I would like to add a Fujitsu/Intel platform with what appears to be a
> > related NVS resource reservation failure. I have not tested the proposed
> > patch; this is an additional hardware report.
> > 
> > Hardware and software:
> > 
> >   System: FUJITSU FMVU14003
> >   Board: FJNB2B5
> >   CPU: Intel Core i5-7300U (family 6, model 142, stepping 9)
> >   BIOS: Version 1.33, 11/25/2025
> >   OS: NixOS 26.05
> >   Running kernel: 7.2.5 (NixOS build)
> >   /proc/sys/kernel/tainted: 0
> > 
> > On this machine, the TPM2 table specifies StartMethod 2 (ACPI Start).
> > The control area, rather than the MMIO range reported by _CRS, lies
> > inside ACPI NVS:
> > 
> >   TPM2 table (length 52, revision 3, checksum valid):
> >     ControlAddress: 0x000000008ff6e000
> >     StartMethod:    2
> > 
> >   Relevant /proc/iomem entries:
> >     8d77f000-8ff7efff : ACPI Non-volatile Storage
> >     fed40000-fed44fff : MSFT0101:00
> > 
> >   The TPM SSDT declares _CRS with base 0xfed40000 and length 0x5000.
> >   It also contains:
> > 
> >     OperationRegion (TPMR, SystemMemory, 0xFED40000, 0x5000)
> >     OperationRegion (TNVS, SystemMemory, 0x8FF6F000, 0x27)
> >     OperationRegion (CONA, SystemMemory, 0x8FF6E000, 0x30)
> > 
> > The kernel reports:
> > 
> >   tpm_crb_acpi MSFT0101:00: error -EBUSY: can't request region for
> > resource [mem 0x8ff6e000-0x8ff6e02f]
> >   tpm_crb_acpi MSFT0101:00: probe with driver tpm_crb_acpi failed with error -16
> >   ima: No TPM chip found, activating TPM-bypass!
> > 
> > Neither /dev/tpm0 nor /dev/tpmrm0 exists, and both /sys/class/tpm and
> > /sys/class/tpmrm are empty. The ACPI device has status 15 and an existing
> > platform physical_node, so platform device creation itself succeeded.
> > 
> > Based on the ACPI tables and source inspection, this appears to reach the
> > iores == NULL path in crb_map_res() when crb_map_io() first maps the
> > 48-byte control area. That area lies outside _CRS but within the NVS
> > reservation. This is an inference from the tables and error range;
> > I have not instrumented the driver to trace the call path.
> > 
> > Earlier boot logs show the same error and address on BIOS 1.10, 1.30
> > with kernel 7.2.6. I do not have a known-good Linux kernel on this machine,
> > so I am not reporting this as a confirmed regression. The TPM works in
> > Windows on the same machine; its TPM firmware has also been updated.
> > The vendor of the TPM is infineon, but the exact TPM firmware revision
> > has not been collected here.
> > 
> > The missing devices cause systemd 260.2 to wait 90 seconds in the initrd
> > and another 90 seconds after switching to the real root. We have prepared
> > systemd.tpm2_wait=0 as a local workaround for the boot delay; it does not
> > restore the TPM device.
> > 
> > Does this look like another instance of the NVS mapping issue, and is
> > there a preferred revised patch or targeted diagnostic for this ACPI
> > StartMethod 2 layout? I can provide the raw TPM2 table and TPM SSDT,
> > including its disassembly, if useful.
> > 
> > Best Regards,
> > Delton Ding
> 
> Yes it does.
> 
> I need to revisit this properly. Thanks for reminding.

I gave updated feedback.

Br, Jarkko
