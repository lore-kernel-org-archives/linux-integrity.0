Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536103812C2;
	Sun, 24 May 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664260; cv=none; b=qxQHQQ0SlfZ9dwGOSSXs/8ygaG7VdgalK/rAGw3kPL1eKXa9vmy6/4gIZworRBcpjddd7+lLiF8sy4+P3PHr0+Wg9lySRE9HW5yFZB7zoMUOuhpUzBzPXHryRguTdRJnQgDv9h79tfujs6IwakbLJNd4ZhxWVxMXJ276NCnt/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664260; c=relaxed/simple;
	bh=u+qyjJYn2A7iV4U2DGZL2fofcCfJjNSwpgoyP1g/zBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZjGnfyannjHxJ1sXKtU+lSGm56FaPIA0J7v6KuErWPKIEci7po7mjvRGiCnBv2JxWwPvAygTiupv7ExSxRYtL2py4oqfHN3XP9J5HaQJ99nmy2cVSpP4cvpYBlKaf3vfKMsxRPReerJUyQgC0uXv08B+wxNum8r7HPs17lW7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUzelaW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUzelaW+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 73DA51F000E9;
	Sun, 24 May 2026 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779664259;
	bh=TOO/PPBXUC59H8KNBz9LXB1WgHw21oBry3YqPF/2QMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUzelaW+B24vyB32XsCqDOx+DaM3NjF3s8lF2oZaH+78QrVMPfBuj7Uz/Ao+WmE1g
	 rvxVCf//G/3jHUur2cmrhtFh6nQNEF4eEXNsut/H9tYO5DnmlkfcM1yinRQ9MnEiMq
	 fiZOzVcjXD2HXDipAP1G6E2ZY3S6cEbdU9e03y4uhdtkHJsSYP0CX8yiqk9XZdoQQA
	 DhaSyVhi5kyQ1/sVCxicnKVkb91lB+unU85AcEp1oOTadlyyFW7R706NTDY6IKv27g
	 csOCb7p8ABcyrlZ0D9Nxh4/NFfeEOBWATuaE3bg5H1RLIrawVTuknZ4IntWVO7KQ46
	 SuYeCfsIfIi/A==
Date: Mon, 25 May 2026 02:10:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
Message-ID: <ahOFfhOFaaomv9lo@kernel.org>
References: <20260519060926.103727-1-jbroadus@gmail.com>
 <ag-ZuEt4uXnrO8AK@kernel.org>
 <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
 <ahBN9vCLmHLBqnch@kernel.org>
 <9553191e-b061-4fa1-a11c-5ad87cbf6862@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9553191e-b061-4fa1-a11c-5ad87cbf6862@gmail.com>

On Sat, May 23, 2026 at 06:39:52PM -0700, Jim Broadus wrote:
> Hi Jarkko. The current manufacturer_id is in tpm_tis_data, not tpm_chip. I
> think it makes sense to move the new did_vid to tpm_chip so it can be used
> in tpm-sysfs, but it would only be set (at least initially) for the tpm_tis
> driver. What do you think?

Oops. Sorry, I just described myself incorrectly.

What I actually meant was adding priv->did_vid.

Thanks for paying attention!

> 
> Thank you,
> Jim
> 
> On 5/22/26 5:37 AM, Jarkko Sakkinen wrote:
> > On Thu, May 21, 2026 at 11:03:29PM -0700, Jim Broadus wrote:
> > > Thank you Jarkko. I'll do that.
> > > 
> > > Jim
> > Yeah, in this form it is quite unsable e.g., for any Linux distribution,
> > and somewhat involved for the user :-)
> > 
> > Conditionally on is much better with appropriate detection. Also, this
> > way the change improves the code base a bit given that chip->did_vid is
> > much more applicable than chip->manufaturer_id.
> > 
> > BR, Jarkko

BR, Jarkko
