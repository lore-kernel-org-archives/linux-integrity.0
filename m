Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553388;
	b=V5STpDqnEfJNZ4Z7/io+omZdK6q3Fzy40mogspFNyrwrOyckQ2Y7pD8MovA/q5TCt0e2
	 LVVOUneBs1IYGueB+Yz2Y6newUjYaeagPIvVpU+YRCgWjU+GXwMjz56D1CrdhIdLAexh9
	 hRX6X4yaVNW+jnxJp/a4g1YCkK5VOg8JNyKM+tEDavKDOUedgUOGrJ/+iT+qhdXLuyL4J
	 VZLwGiS4YWsg7XnhwGDphGqjWW/cVDFk20BxUXb1yoydJ5aJKuq5AaCOlV1IP/mtoZOJX
	 LXedx8NY4AbAWrJah6W2F7HGX5eN4jczNiJW9lzpGtv60fPcj9Ui3Ux7aqGDMViaMqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553388;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=aZOxy3IDrLOi1f5Dp27umugLMwQwEKzdDvwJBP8P0fg=;
	b=d6jTICzEeHpjl0JIgLMjhqPv6bs/LH6RA8NpZ2i16fRxhCF0ZywpWoLJjWW7rSosabqs
	 a1p2iykIwBvpwrjUd1xzWTj2QIi49jg4o33SenwTHRh79ECTxdmj2eFMgWdEvnsNa/ACF
	 1iT6DKKnR882JcpIOmnkhBkg5RmYr/JvHiNTmbOVzyH81poUvizgAT7clu0ZtSs3zYYmG
	 cyd/OkT8rs8o4PdrwpeBaw3yzsPKJdPQuRUPCxPwYDjQyOD9efv4FRUsFCL2KCn0kLdfQ
	 ZtKwv4wuqr1OTS+NCAw5fiQXieXWiheFf32xnfaeI38kuHZJBWmbyqmWhK6aS0keDtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="SMUuO/7h";
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6B606A31E;
	Tue, 24 Nov 2026 20:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=SMUuO/7h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795553387; x=1827089387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZOxy3IDrLOi1f5Dp27umugLMwQwEKzdDvwJBP8P0fg=;
  b=SMUuO/7hyDGMjebWkVlFB9qja2A0+AoniVYOH0S+R8pvJzgzBWP18OtK
   zVjs587XAWwGKwQANswYzJcxROzbkaV4Y4EERBKXdbTuGqY0mPu33m7Zx
   irPpOF0MW53R9vfV7W1C8Fm0S+mAS6MVJz4OlvmwnvjD6TJ0Lx31d1XUE
   HTQqtDbHm43m4eF2PJvKTGYilcTleZbcqzLwwdfxrkC1WfNQWuR6WCPoV
   iiZ+i6bA/ga3uT8ugeZlgL2Piwj6N8QBy2OAzFyc+jTqSKkPr4pPcXNKO
   jHVHettnNJJupEjJ8Oqh828POT256+EjsGYpQQunw7fil23YdS3OIf9LP
   Q==;
X-CSE-ConnectionGUID: jm7m2KLtTyyolTeZiPjZXA==
X-CSE-MsgGUID: i0WwmFTtS5iYMjGreeTecw==
X-IronPort-AV: E=Sophos;i="6.27,231,1787011200"; 
   d="scan'208";a="34997886"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:49:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25607]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.12:2525] with esmtp (Farcaster)
 id fd423222-3303-469a-bd87-676a79badd10; Tue, 24 Nov 2026 20:49:44 +0000 (UTC)
X-Farcaster-Flow-ID: fd423222-3303-469a-bd87-676a79badd10
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Tue, 24 Nov 2026 20:49:44 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Tue, 24 Nov 2026 20:49:44 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <corbet@lwn.net>, <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <leitao@debian.org>, <linux-doc@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <noodles@earth.li>, <peterhuewe@gmx.de>,
	<rdunlap@infradead.org>, <skhan@linuxfoundation.org>, <surenkj@amazon.com>
Subject: Re: [RFC PATCH v4 4/8] tpm: Bound core and CRB waits by the limits table
Date: Tue, 24 Nov 2026 20:49:41 +0000
Message-ID: <20261124204941.18416-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awA7ns3kfuOBanxW@kernel.org>
References: <awA7ns3kfuOBanxW@kernel.org>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Jarkko,
Thanks for the review.

On Fri, Nov 20, 2026 at 02:22:54PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 18, 2026 at 07:38:48AM +0000, Surendran Kanagaraj wrote:
> > Polls in tpm_try_transmit() still use fixed 1 ms sleeps and
> > tpm_transmit() stops retrying once the next backoff would pass
> > TPM2_DURATION_LONG and tpm_crb always waits TPM2_TIMEOUT_C.
> > A value set through ->adjust_limits() reaches neither the retry
> > loop nor the crb waits.
> >
> > [...]
> > ---
> >  drivers/char/tpm/tpm-interface.c | 57 +++++++++++++-------------
> >  drivers/char/tpm/tpm-limits.c    | 19 +++++++++
> >  drivers/char/tpm/tpm.h           |  2 +-
> >  drivers/char/tpm/tpm_crb.c       | 70 +++++++++++++++++---------------
> >  4 files changed, 87 insertions(+), 61 deletions(-)
> >
> > [...]
>
> Is it possible to slice this to more intermediate steps, or not?

Yes. I will split the changes in the next rev:
- tpm_try_transmit() and tpm_transmit() changes to use the limits table
- tpm_crb driver waits to use the limits table

Thanks,
Surendran
