Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38E3B6354;
	Fri, 25 Sep 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346303; cv=none; b=dpi+eK6Xq8mUE19oZg+ET1hF/uFhx9MwZ9Ibj3aEmFfnje03awZJDP16pz8Tu+7PTpUERl/5yVB8PmGEpsQqCmE8sbMagNyALEIU2Wfu+qpQdHrP2iyFRVCLsfp7JTjvwxd8uT2kjLRG/2V9dEpQ7/wUxBM6JPPglsxtQLhEIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346303; c=relaxed/simple;
	bh=pXhSqihyKIhrGlI/g7JpN60mg7P6zkd6YEhrc0H8qmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb3HwSTCvt8pkpZjc5WAtYNYygfQsUt+JfL08CpOgeGx83WCV8rcr7nEAgdzEDO9OGUmG6UopLm+mPINp/gFCV/QxSVnuzaCJ5Re34bY4YVX/ghXI72AYsJJgge5HXDaWtuYyTLvFpBR7AuVi0L1Fg7uUMzeFoA7EHbcKOCo1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgtu+P2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgtu+P2Z"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 263161F000FF;
	Fri, 25 Sep 2026 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346301;
	bh=rvlxCQWiFsofw/X+q3JJnC3wVDxfV/pS+iCNTdegIuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgtu+P2ZUwI0mOcXbFEL62FxxreB0EMiSdeDQM28ZnvyWtrs7iCzwgpE0oZg2TLUz
	 fZ+XzLpuyrJWUNZ+GTnzjxeZC0gF2GXanKV4jAQehwhDHr2Jdcp5ne+VafKv49t31x
	 N6SHeJmI3vwdKIP4FnXvYnkvY92uxObqb0p/wlu0taAKq9Nsb+F5q/DwzARB9YKo8T
	 8oMw8LaU4TDw7ol1rM++ka2wudZQC30+m/D+Ne64CV14O9ggPtk57jfr/ZHopBJXZv
	 Ne15iPxaevyg+A9aGsSzG0LvwK+d8nuRINHgF0Dc4jXSadBbQvRh5a6j5cNvw6MtIh
	 aWuJNtSVfufVg==
Date: Fri, 25 Sep 2026 17:24:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Delton Ding <dsh0416@gmail.com>
Cc: f13208471983@163.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <araEOkjz1f_vnl3A@kernel.org>
References: <CA+mXNo2bBZg69RkKYauV_+K5zp=1kuHm1xLPwD6_ihZ_MzL0SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+mXNo2bBZg69RkKYauV_+K5zp=1kuHm1xLPwD6_ihZ_MzL0SQ@mail.gmail.com>

On Sun, Sep 20, 2026 at 02:33:12PM +0800, Delton Ding wrote:
> Hi Jarkko and MicroFish,
> 
> I'm following up on this discussion:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2652132.html
> 
> I would like to add a Fujitsu/Intel platform with what appears to be a
> related NVS resource reservation failure. I have not tested the proposed
> patch; this is an additional hardware report.
> 
> Hardware and software:
> 
>   System: FUJITSU FMVU14003
>   Board: FJNB2B5
>   CPU: Intel Core i5-7300U (family 6, model 142, stepping 9)
>   BIOS: Version 1.33, 11/25/2025
>   OS: NixOS 26.05
>   Running kernel: 7.2.5 (NixOS build)
>   /proc/sys/kernel/tainted: 0
> 
> On this machine, the TPM2 table specifies StartMethod 2 (ACPI Start).
> The control area, rather than the MMIO range reported by _CRS, lies
> inside ACPI NVS:
> 
>   TPM2 table (length 52, revision 3, checksum valid):
>     ControlAddress: 0x000000008ff6e000
>     StartMethod:    2
> 
>   Relevant /proc/iomem entries:
>     8d77f000-8ff7efff : ACPI Non-volatile Storage
>     fed40000-fed44fff : MSFT0101:00
> 
>   The TPM SSDT declares _CRS with base 0xfed40000 and length 0x5000.
>   It also contains:
> 
>     OperationRegion (TPMR, SystemMemory, 0xFED40000, 0x5000)
>     OperationRegion (TNVS, SystemMemory, 0x8FF6F000, 0x27)
>     OperationRegion (CONA, SystemMemory, 0x8FF6E000, 0x30)
> 
> The kernel reports:
> 
>   tpm_crb_acpi MSFT0101:00: error -EBUSY: can't request region for
> resource [mem 0x8ff6e000-0x8ff6e02f]
>   tpm_crb_acpi MSFT0101:00: probe with driver tpm_crb_acpi failed with error -16
>   ima: No TPM chip found, activating TPM-bypass!
> 
> Neither /dev/tpm0 nor /dev/tpmrm0 exists, and both /sys/class/tpm and
> /sys/class/tpmrm are empty. The ACPI device has status 15 and an existing
> platform physical_node, so platform device creation itself succeeded.
> 
> Based on the ACPI tables and source inspection, this appears to reach the
> iores == NULL path in crb_map_res() when crb_map_io() first maps the
> 48-byte control area. That area lies outside _CRS but within the NVS
> reservation. This is an inference from the tables and error range;
> I have not instrumented the driver to trace the call path.
> 
> Earlier boot logs show the same error and address on BIOS 1.10, 1.30
> with kernel 7.2.6. I do not have a known-good Linux kernel on this machine,
> so I am not reporting this as a confirmed regression. The TPM works in
> Windows on the same machine; its TPM firmware has also been updated.
> The vendor of the TPM is infineon, but the exact TPM firmware revision
> has not been collected here.
> 
> The missing devices cause systemd 260.2 to wait 90 seconds in the initrd
> and another 90 seconds after switching to the real root. We have prepared
> systemd.tpm2_wait=0 as a local workaround for the boot delay; it does not
> restore the TPM device.
> 
> Does this look like another instance of the NVS mapping issue, and is
> there a preferred revised patch or targeted diagnostic for this ACPI
> StartMethod 2 layout? I can provide the raw TPM2 table and TPM SSDT,
> including its disassembly, if useful.
> 
> Best Regards,
> Delton Ding

Yes it does.

I need to revisit this properly. Thanks for reminding.

Br, Jarkko
