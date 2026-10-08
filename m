Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD842050;
	Thu,  8 Oct 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481662; cv=none; b=V5896eiUc4yqF9uptbb7+Cb4YGL1WVcmknrBQxsgWladliVGwqV8Pmj/EMvSSF3G4AHtKHVr/c27C3LT2ixFBt2Hw5lNcRbT9+fzHbvbhiBt/CbO+HT2Dr4z3XGujDonpP26ymwvxI9nZ1TMnhRmCpqJz2ki09yZY6LDc2qJHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481662; c=relaxed/simple;
	bh=pdTvypLT1m8Y+ufsEsWDzDcq8EIHFcp+T6yUCAp5awU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/lKhDST4OTiDDDLi+5ne3x23S5TYsC9qBChX1di9Gx1CZU+getKDdJOBFsCUB+D5yse9C951pk23g0GjMMJWXD+0ojD4X3bFSoRRbBQj7jbPXQrlSjbBpVsHAYJOIl0pzDSqJLJ9X+81znmepwhzXTQBFWt+uO/M1cmqwSHz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krccfK65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krccfK65"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DB6411F000FF;
	Thu,  8 Oct 2026 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481661;
	bh=afccM4hIGLMqj1Jjr44D2tefDjrWBLZ5kMYBvu0gVn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=krccfK65szplIpY99fzBqCIHNSPC89znc4AVpUXiWCbKGldi3GFULoy05S3bRuDPu
	 qN/6gSu2J4V8+iqkUnHdFeCqNLs5STj3BGbThIJxZRtVYLTlGFTxgOfCJkkbt8T/cr
	 7I4ZYVmD+Ua9z3bB5SkKH3ZC8A9hhK9gyTL2tEW0i4+49yeuG/3kf6iKx+kxpHtNlk
	 XlDVacx0xKAgudOHg2ZCMcRY1Wk89meGhV4ti+n6U0+eZqF0q91eE3WBwp4kwG2VMs
	 cmRLhpWE0SIwFMVrtXp88I/YHCyPq0RpQRNIbvUI32fvIsPjHDjEpWAM5Za+QPuR7X
	 XwtZJifRn+c+Q==
Date: Thu, 8 Oct 2026 20:47:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sean Meadows <Hellfire@unspacy.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Message-ID: <asfXObGNaZ9Z8CwN@kernel.org>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>

On Wed, Oct 07, 2026 at 12:27:01PM -0400, Sean Meadows wrote:
> On 9/29/26 18:25, Jarkko Sakkinen wrote:
> > There's a commit with title "tpm: Call cmd_ready/go_idle for each command
> > transmission", which is strongest contender to make a difference to this
> > long running issue.
> > 
> > I.e. I think it will improve firmware behavior given full release of
> > resources per TPM command.
> > 
> > I'm including it to v7.4 pull request.
> > 
> > Br, Jarkko
> 
> Hi Jarkko,
> 
> I have to break some bad news.
> 
> Testing Mr. Alves’s patch first led to a failure at the 60-hour mark.
> 
> Mario’s patch—"tpm: Call cmd_ready/go_idle for each command
> transmission"—failed at 55 hours.
> 
> To give additional details: with Alves’ patch, I ported it forward and
> tested it on kernel 7.2.7.
> 
> With Mario’s patch, I downloaded the 7.3-rc5 mainline tree from Linus,
> git-grabbed your tree to get the TPM patches, and then cherry-picked
> Mario’s commit. It was applied and built without issue. If being cherry-
> picked onto 7.3-rc5 left it deficient in some way, please let me know.
> 
> I then proceeded to run 7.2.8 with my new USB3 debug cable.
> 
> I initiated an S3 sleep after a fresh power-on to get a baseline. I have
> complete logs saved, but I’ll simplify here to keep the message short
> and succinct.
> 
> 1. systemd-logind[483]: Lid closed.
> 2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
> 3. systemd-logind[483]: The system will suspend now!
> 4. Kernel enters device suspend phase | driver callbacks | many lines of
> confirmation as drivers and hardware transitioned
> 
> 45 hours later, I tested the next S3 sleep and the following occurred:
> 
> 1. systemd-logind[483]: Lid closed.
> 2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
> 3. Deadlock | USB3 DbC link drops immediately
> 
> I don’t know what all can be captured through this debug cable, and this
> next thought might be nonsensical as a result. Would you benefit from me
> installing Windows and snooping on what the Microsoft TPM driver is
> doing to prevent this deadlock?
> 
> Thank you for your time and patience,

The patch I pointed out this in bugzilla but the patch I had in mind is:

"tpm: Call cmd_ready/go_idle for each command transmission"

Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=9154aa6c4b789d23e59d599c330cab2c4e915401

The reason is that the commit message highlight a bit similar issues as
reported in the bug.

Note commit IDs do change in my master branch so best is to look it up from: 

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

Right another reason is that then the driver always the TPM in the state
as it is when the driver starts.

I'm not sure about Windows but neither disregard it as sometimes we do
pick behavior basing it on how Window does it. I'd still try Mario's
patch at first.

> 
> Sean

Br, Jarkko
