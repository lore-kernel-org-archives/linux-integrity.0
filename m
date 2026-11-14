Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794647553;
	b=a5UdPPQLUz5lXjpJoSq4NEkHe1DWqfr0Ve7Oy7sY9AvfXWhe6/3+SjIEPUzJK2UFd7m/
	 iweROm5F63DRcWuIOm329k57TJEHEJQYlHEdcTeQDez+7wYVwgVYXoKzeVVal/l3dv4Ul
	 DKld0Saa5r7FAxIgn9EaiRmGdjSc+vZcvuPiDQnriym0yvsmm8H4QYgySAHuYkal5kU1W
	 3VDMJVYmwpDXW6PAKRYiMbsgCfrI9bKAFjRYVe8IB8RANJ1i6Jf3S8Zr5ltiHbw8cjcWF
	 IKyBO/nUG+ks/ZBRXnOFnrW0LV1I0jzSJsW4bphRx0qCRbEBrOfhEeLdcRAEYyyQR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647553;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ewPtHXrv7EUANlzuM5mAXHrHQ84ZayQ1dYeaX0xwzDM=;
	b=ZAODrCp2TxRgDZ5cKdrjt98ACGLygQhrmdKTBi0xG/42PhFgETpzWJqWhZCMcjybz4VF
	 e7su/dh3vbRRMy8uEfVvyQIRCulWU0oyPdPaRSXqDBobMoY/X18JbiEu9JEQ6MIbKTubI
	 YFKOdmAk3eIXk8OLswDC3m0LqZY2L1s6r8t9u/w1p6joWx4y5Z7jEYcCxYJ+cXtBh3cwV
	 58gYGn86iWwtQ7HJdvl+lWTtOZKfobcGe//Wnomg9E8F9YPGsX5Jlbnb9iGD4EpzQz50z
	 eHDTMDZ6r4iY0amQnQ6CMPYFcopDS7IjVRbEj40CUZ8WNoy9Wi0Ue6xb6uK0/6yXbBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=loAHwaBJ;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2A606A33A;
	Sat, 14 Nov 2026 09:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED2A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=loAHwaBJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794647552; x=1826183552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ewPtHXrv7EUANlzuM5mAXHrHQ84ZayQ1dYeaX0xwzDM=;
  b=loAHwaBJHr2XeOA0TtOzcyBzJLlXfgxj6uaa+1vbNAnoi80KwRuKk9Sn
   aaNg6KZrM2Dhw0Gx1SDd/ZrD2ILGZ072X7uM50REw6f9k2ur3hpGUF0n5
   UgFiGOxLzM7dMFWsQgyGUUMPlR73oiaWS3QFCyd5rZDM4FCuNLgcF3pQC
   RRSnG40RiiGZVU+lfXra+xFmDRgsLD/QCRzq3U3vIYkyIanUo3cEcU9hS
   3G6K1Dkam4fidI7krO3jy2vnnPgLuyITao7c3m+IMQo3KLhwFvi4y5CzI
   Yz4OiWlxVYEu/B68KOp2rccYNhzL/YfOBrUQBdywwzMVsI0qsyxaJqO1A
   Q==;
X-CSE-ConnectionGUID: CN5O7v6lQ22t9bOeqTC4UA==
X-CSE-MsgGUID: vd0zNEgXSrSDgAxymbcbtg==
X-IronPort-AV: E=Sophos;i="6.27,213,1787011200"; 
   d="scan'208";a="33904262"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 09:12:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:23248]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 2c4611d0-5f5e-43c3-8896-3f90b5ab17ff; Sat, 14 Nov 2026 09:12:29 +0000 (UTC)
X-Farcaster-Flow-ID: 2c4611d0-5f5e-43c3-8896-3f90b5ab17ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 14 Nov 2026 09:12:29 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 14 Nov 2026 09:12:29 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <corbet@lwn.net>, <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <leitao@debian.org>, <linux-doc@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <noodles@earth.li>, <peterhuewe@gmx.de>,
	<surenkj@amazon.com>
Subject: Re: [RFC PATCH v3 1/8] tpm: Add a single table for all TPM wait limits
Date: Sat, 14 Nov 2026 09:12:22 +0000
Message-ID: <20261114091222.32721-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <avdoybHEoRd0Fhie@kernel.org>
References: <20261112163846.97654-1-surenkj@amazon.com> <20261112163846.97654-2-surenkj@amazon.com> <avdoybHEoRd0Fhie@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Jarkko,
Thanks for the review.

On Fri, Nov 13, 2026 at 09:45:13PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 04:38:39PM +0000, Surendran Kanagaraj wrote:
> > The hook sets values with tpm_limits_driver_set() or from a quirk
> > table through tpm_limits_apply_quirks(). tpm_poll_timeout() waits on
>
> OK, but ...
>
> I.e. I'm not fully following what is the diffence between these call
> paths.

They are used from the same place. tpm_limits_update(), which is called
from tpm*_get_timeouts(), builds the table. The driver hook
->adjust_limits() runs from tpm_limits_update() and uses
tpm_limits_apply_quirks() to apply the quirks. tpm_limits_apply_quirks()
finds the matching quirk entry and calls tpm_limits_driver_set() to
update the limit.

tpm_limits_update(...)
{
    tpm_limits_stage_defaults(&p, family);
    if (reported)
        tpm_limits_stage_reported(&p, reported);
    if (chip->ops->adjust_limits)
        chip->ops->adjust_limits(chip, &p);
    tpm_limits_stage_validate(&p);
    tpm_limits_commit(chip, &p);
}

Hope this clarifies.

> > +/*
> > + * Handles time limits for a TPM chip.
>
> I'd extend this to just have brief description how this works. Just a
> high-level overview.

Ack. I will add a short overview in the next rev.

> > +static int tpm_poll(struct tpm_chip *chip, u32 timeout_us,
> > +		    enum tpm_limit limit,
> > +		    bool (*cond)(struct tpm_chip *chip, void *arg), void *arg)
> > [...]
> > +int tpm_poll_timeout(struct tpm_chip *chip, enum tpm_limit limit,
> > +		     bool (*cond)(struct tpm_chip *chip, void *arg), void *arg)
> > +{
> > +	if (WARN_ON_ONCE(limit >= TPM_NR_LIMITS))
> > +		return -EINVAL;
> > +
> > +	return tpm_poll(chip, tpm_limits_us(chip, limit), limit, cond, arg);
> > +}
> > +EXPORT_SYMBOL_GPL(tpm_poll_timeout);
> > [...]
> > +int tpm_poll_timeout_us(struct tpm_chip *chip, u32 timeout_us,
> > +			bool (*cond)(struct tpm_chip *chip, void *arg),
> > +			void *arg)
> > +{
> > +	return tpm_poll(chip, timeout_us, TPM_NR_LIMITS, cond, arg);
> > +}
>
> I did not check all the details but could this be reorganized into:
>
> 1. __tpm_poll(): the same as tpm_poll() but exported and defined in
>    drivers/char/tpm.h.
> 2. tpm_poll(): a single static inline function declared fully at
>    drivers/char/tpm.h
>
> __tpm_poll() would e.g., make a nicer trace point for a kprobe or
> kretprobe.

Good point. __tpm_poll() then becomes the single kprobe point. Will do
this in the next rev.

> > +/* per-device overrides based on id the driver defines e.g. DID/VID */
> > +struct tpm_limits_quirk {
> > +	u32 id;				/* driver-defined device identity */
> > +	u32 time_us[TPM_NR_LIMITS];	/* 0 leaves the limit alone */
> > +};
>
> I think it would make more sense to fully initialize the database per
> device, if that is possible.
>
> It is a non-concern if two TPM drivers do some redundant work, as it
> is not a real-world production use case :-)
>
> I'm just wondering if this quirk/entry division.
>
> I.e. in my world view chip owns its limits (not e.g., tpm2_space).

Makes sense. The quirk table is just a convenience, a common table fmt
for drivers, and the chip still owns the table. Without it the driver
calls tpm_limits_driver_set() for each limit it changes. I am happy to
drop it in the next rev.

Thanks,
Surendran
