Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E8371898;
	Fri, 25 Sep 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347569; cv=none; b=cOSlA1KBZwUocJciwSTFZCtoNU4YSeKfEp1eKbeqL0Xgv717YJckC60Pmbmz1tO3Rk4oaao8X+tLHHdgJ1WlGo/uuYq5q7z41BtRvEiB5tb023caZII1SN796vx8krSGlP7fYYTCNUuurXlYhw5Ug9gCXPmugiljlPumEqGfWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347569; c=relaxed/simple;
	bh=p0PFFd8yXsrlXtWAvwAzBFeHxCTI3rh2mZPNKGMNyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbePC953ASZngGF6JKbUa54jaSGfJVeY48J6/gUd5T4hw65yuk7pmkUj8Kp1LJcZYCjuUU8j00624CVrT+jevzYF2bNgoytqxjgoZztyPfiLF5ES62c1fr/skJ81v/UhoFSGT9fmNAoLYVRUrrRLbHSxDbjQ/17+ulycFgEWG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpZZ2kDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpZZ2kDJ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CA8A1F00898;
	Fri, 25 Sep 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347565;
	bh=H1vHhX67qXhb8YQtEjUFRBlito2qAR/0NOGcmGalPZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jpZZ2kDJ3MPp7sM2WVzltrEnf/B+tmv2NnkZyELjRTpbmHjy3w6N/gsTDkdg2zyCK
	 MLI8hHiEis1XBJyJSRRQt+lZdZaVBf2y1QQsJNl7ioz8T8CPki4H0awihS/w/LK/9y
	 vl3T3qOwN8hHs+FKNZVpNYFGe1iD0rn6Zf6l1EVpanJWHne2Jpbpn5OI8e/QGOCUoF
	 LJNilz1jR5PbtsPZbv5XdF+cKDImO9duT8xGOUVesEE4DlayCRoce5NwV+AM4oGhbj
	 AaGQ/dGEvDOnjN3Je0VJt8t2fJDxp3V8AMRLHs1gIFrxsZoZCuB5xiOZxCXRr/msKB
	 5VfSiIwSWuuow==
Date: Fri, 25 Sep 2026 17:46:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <araJKqHdeXstD7nR@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <aqyZtHynb2nuQT-P@kernel.org>
 <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 02:06:43PM +0530, Kuldeep Singh wrote:
> > Causes merge conflicts with my tree when applied with git am (actually
> > b4 shazam).
> 
> Jarkko, this series was sent based on tag next-20260828 after applying
> prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
> observed IIRC.
> 
> Kindly note for merge strategy, prerequisite series[1] will be merged
> via TEE tree and current series need patch 1-5(not patch6) only as
> prerequisite.
> 
> To merge TPM series, it's better to pick from your tree and TEE
> maintainer can ACK patch 1/2 for seamless integration?

So I'm just having trouble following so: what is the best option
for you? What do you want me to do? Which route you prefer?

> 
> [1]
> https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
> 
> -- 
> Regards
> Kuldeep
> 

Br, Jarkko
