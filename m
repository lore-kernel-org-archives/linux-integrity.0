Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034122DECBD;
	Wed, 28 Jan 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642247; cv=none; b=AeeJ8t1Wb3k5cYQ4e25whegnxPdBetmz6xnS8uJqv+WQUoLGKSOTbxYA4HAOPxYpq9vJCyVyVip7b3oZFggF9W66TUeM/Hok9GBoyp1iHgAbn7kaufzZTA5wYX8BdF/sow0DWd1+hsNjWo52miDl3GvOABJui7I0M3MLpUaIdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642247; c=relaxed/simple;
	bh=qO7dfiw2GJNjPx3tSEUVxc4d77Lz9sPQeBV6GQPIP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB7I12Cqld8SeM8ZBPuhhPEUKJ0FFFOmxRczwRefc0REnd4cQv1CIgm6wRJGT5sHGJYyg5zvFWRMXmymn3WeDa/ORU3wJNWQBqr9+kpVEfUF28TGRBMHs7IX+as6qzyfZ5Z1O+y4CQKgN8eJIxl9cu83/ee+oYCLZUqxAAY0Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIDoSa7c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIDoSa7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04726C4CEF1;
	Wed, 28 Jan 2026 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769642246;
	bh=qO7dfiw2GJNjPx3tSEUVxc4d77Lz9sPQeBV6GQPIP9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIDoSa7cASX6RPExCNtkcPXgoxTt0cf6zPYA+pDe530YwjsuTbvw3GniO1mDbhVRX
	 VKbJiTjhYqwYFdjmUL3B2QBmeOlQOULoDa0poMsGwL07JLZr4fa7P+5rm0yLpo1mnE
	 xg0j/PECtvD+GzIiVGQQrr3+KJLSKVQcXkVfIRSW77Inc37aT0TB94IARhgs01OBgx
	 WGzXhqIAlMpkg4SvI8peSIFH/Gb+dvE3QCJ+dADlZleANV+OqbFlzWIrHuru9J0mTo
	 2mk7JVW+5RV2MH8DCCYaQV7HGcOjPSXyTTQzpoIuU/iVb7/Sqg0VK4mBOu24bgm8By
	 6oxUhWFVx8uHQ==
Date: Thu, 29 Jan 2026 01:17:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Message-ID: <aXqZAb1dfdoQkfls@kernel.org>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-10-bigeasy@linutronix.de>
 <aXZJuFXFvvfsW-Qb@kernel.org>
 <20260127154530.SPUEa63d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127154530.SPUEa63d@linutronix.de>

On Tue, Jan 27, 2026 at 04:45:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-25 18:50:00 [+0200], Jarkko Sakkinen wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Shoud I pick this? I did apply it to my master branch (not next).
> 
> I am about to prepare a v2 and if you take it I am going to drop it.
> Shouldn't you apply it, then I hope to route leftovers via the genirq
> tree.

Please route through genirq tree.

> 
> > BR, Jarkko
> 
> Sebastian

BR, Jarkko
