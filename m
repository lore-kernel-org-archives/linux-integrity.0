Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E2392C48;
	Wed, 19 Aug 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787099880; cv=none; b=UKzn32HOMM+13YQopuVlNwKyD7OTdxGNcgI/sEQJNXYC7HMOrRIJIezrYBQ63buXzmkjIaPog2k7ky8FMf6yBwXHPIQXhD6sUuDe5DytkerPtxpubmwO2mjlLxRB6xup+CFl5Cfz3MQhzUIx/hO02LJ4hH30PCkN72kGlVlwu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787099880; c=relaxed/simple;
	bh=A9aL/41tDIYuO5i2otbvG8MpNVC7Q0uIYH3rIhqvrpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDep6P3awsF4RMh+q6I0SWj3ina3bQc7mAUCVZwP2h0xtDWDR1GlwYzwlE6Mbmaj2vHBvK/YmImSB4Q3ow7/AO5W4kT9c9CK6faEk9conkRvyLLdjwbjAkB0AAlyqVGQx4+fNHz7oGB1Vop3I7sZIOCRfS6V9JfmQE2g+xjqnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLxsmtbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLxsmtbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15541F000E9;
	Wed, 19 Aug 2026 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787099876;
	bh=iNo9aoTHDq7oyXFNEsJHQYnmFax+aZDuLzxF0xUGe7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SLxsmtbnksfna8uFwhYS14yjG5YQoAfVvLZI10nG7pVoqlhvWibdVB1YMFzPZftzH
	 We1DZyTzs1UdGsru/zLhrUR03uSs4eBX/Zjm3ZwBIWYvjFcC/zvwToKOb86PdsvVpa
	 O/fabHdXOMWmZTT8AAgU9jdYnOfPDr7ayC8flkNraBSl7p2myQ1DLPSOfUZ9YvymnF
	 e7F6V5XdAv9MIkkYF1tRz0FMrI6uNtJyPtgDpXpLefsqFtTooLoqt/8O4fFmPhjAG5
	 WzvxI/UznqmWJYoViry4OQW6vNtK7g1odfHpT3eq7N+1c1B9ifPR0Dyp7iSBAT3Eda
	 vclTlYODiZYHA==
Date: Tue, 18 Aug 2026 17:37:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Julien <julien82453@gmail.com>, jarkko@kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
Message-ID: <20260819003752.GA3063251@ax162>
References: <12955541.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12955541.O9o76ZdvQC@rafael.j.wysocki>

Hi Rafael,

On Fri, Aug 07, 2026 at 12:22:37PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> If acpi_dev_get_resources() returns overlapping I/O or memory resources,
> the subsequent registration of a platform device will fail with -EBUSY
> due to a resource conflict.  This is reported to happen on Acer Aspire
> ES1-572 [1].
> 
> Avoid that by adjusting resources returned by acpi_dev_get_resources()
> to eliminate partial overlaps between them.
> 
> This has not been regarded as necessary before because putting
> overlapping resources into the _CRS of one device is really pointless,
> but now that the issue has been reported to actually happen in the
> field, it needs to be done.
> 
> Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
> Reported-by: Julien <julien82453@gmail.com>
> Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I bisected the following kernel message that I see on one of my aarch64
test machines to this change in -next as commit f234fdaae1ca ("ACPI:
scan: Avoid registering platform devices with resource overlaps"):

  arm-cmn ARMHC600:00: probe with driver arm-cmn failed with error -22

Is this expected? If not, what information would be helpful for debugging this?

  # bad: [e6664f2b33db9b6811eb4cec109f06cb2b4f458d] Add linux-next specific files for 20260817
  # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
  git bisect start 'e6664f2b33db9b6811eb4cec109f06cb2b4f458d' '8d3ae59288f1e7d58d76558a6ee96d533bc5019f'
  # bad: [86de7a3c48ad4465719822b6bfa176c136302e77] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
  git bisect bad 86de7a3c48ad4465719822b6bfa176c136302e77
  # good: [984aee09cb35477fd7a27fa151e9f8c5a8cb99f9] Merge branch 'xtensa-for-next' of https://github.com/jcmvbkbc/linux-xtensa.git
  git bisect good 984aee09cb35477fd7a27fa151e9f8c5a8cb99f9
  # bad: [d353ba3f585141b91427fb87023e19c1f9ec85cd] Merge branch 'linux-next' of https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
  git bisect bad d353ba3f585141b91427fb87023e19c1f9ec85cd
  # good: [8bb759cc24c375a265eb6bf2f7c90eb2be20f535] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
  git bisect good 8bb759cc24c375a265eb6bf2f7c90eb2be20f535
  # good: [cdcbf4b274cf62bb9c9f589309315870ddf7250f] Merge branch 'docs-next' of git://git.lwn.net/linux.git
  git bisect good cdcbf4b274cf62bb9c9f589309315870ddf7250f
  # good: [edd0dd59aca038b7f32cf893170928d4a3b2297e] platform: int3472: discrete: Support multiple HIDs per GPIO map entry
  git bisect good edd0dd59aca038b7f32cf893170928d4a3b2297e
  # bad: [cb0428d1dfe236fe8ac926d120a0eb47cdca532e] Merge branch 'pm' into linux-next
  git bisect bad cb0428d1dfe236fe8ac926d120a0eb47cdca532e
  # good: [0c4067b3ff3c8b46076001449f566c4a4f58ede4] Merge branch 'pm-cpuidle'
  git bisect good 0c4067b3ff3c8b46076001449f566c4a4f58ede4
  # good: [02859a576afde166daceffdfb8eefc540fbfff9b] Merge branch 'acpi-irqchip'
  git bisect good 02859a576afde166daceffdfb8eefc540fbfff9b
  # bad: [79ba234b396b0fdcb3a82dd8aa872348f4069aae] Merge branch 'acpi-video'
  git bisect bad 79ba234b396b0fdcb3a82dd8aa872348f4069aae
  # good: [b0572550d83d84fa4d7e9088164ac528c5d82996] Merge back ACPI video bus driver changes for 7.3
  git bisect good b0572550d83d84fa4d7e9088164ac528c5d82996
  # good: [e61487226b7df39e5f4683b036ee6aa7a5039d7b] ACPI: APEI: Handle repeated SEA error storms
  git bisect good e61487226b7df39e5f4683b036ee6aa7a5039d7b
  # bad: [79a0aabd5d800a428ebd412ac1a996a686b53c34] Merge branches 'acpi-scan', 'acpi-pci', 'acpi-tad' and 'acpi-apei'
  git bisect bad 79a0aabd5d800a428ebd412ac1a996a686b53c34
  # good: [a3df8bbe0a704fa5c1609b9666b594f350558fe0] ACPI: TAD: Add locking around AML evaluations
  git bisect good a3df8bbe0a704fa5c1609b9666b594f350558fe0
  # good: [fa608d2875b57fac792a9e1c11aa1da91737f04a] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host bridges without _OSC
  git bisect good fa608d2875b57fac792a9e1c11aa1da91737f04a
  # bad: [f234fdaae1cad8c39265e7ca0a14633076ec7154] ACPI: scan: Avoid registering platform devices with resource overlaps
  git bisect bad f234fdaae1cad8c39265e7ca0a14633076ec7154
  # first 'bad' commit: [f234fdaae1cad8c39265e7ca0a14633076ec7154] ACPI: scan: Avoid registering platform devices with resource overlaps

-- 
Cheers,
Nathan
