Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124165226AA;
	Tue, 29 Sep 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688125; cv=none; b=n5yAz0Op8Z96jZmGY+OAQmWUiFU0WL4onxX0v3kxYlb7hVzyBgNLz+mVysqTPW3D0fqRNaFkGjZ7I4nC9yGqxX0HQmthSl0hk7qPmKMHoOF6LQFHTwnG9dla23LnoGBRbVz6K1CPC+K/qHuz2GTcLtOwrJiPOCdxZWFMeHZ5ALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688125; c=relaxed/simple;
	bh=jofquaWAYODr/UgreamCLltZG/YeYsMeiMAfxsINRmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWWR99trgv5kGliuJmnAD7aScNFtwyNBH+gpQNMA+O9g8seLbJAlxAyss0kGkZdaLz6LzORO6j/tljRr1wpIAjdpnIxfVYA0Avn7MWm2K8tjEv/dqwfkQJekz4epm6aMzW0ho3iTwRtNv+bFjtxV2TCO98ZAY/lX4ccK4oEzjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bHnt/LS/; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bHnt/LS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790688124; x=1822224124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NB7hpKyiD3BFL2XDrDPPY5lgZEdsfSIldEvfHJXPBOM=;
  b=bHnt/LS/NnG5KXZ75mHa7SY5+c/AtizI0XO6AV5ZMYs2Gb/ORIKElA/5
   WUavnywp44sgNy5vGA0qSuRmrtRIs6W5ZsjTe+TQk8OCfQTU+dixc4c+J
   tXT7f2qVg3RQ9raxvAOPzI8YN3Q/F8xpv5CJRUxB81/MZObEd3K/b+5nd
   ZCtoSNQmdEkHrLjy6K5QAIeh6xIyagoMWTCXlixhF8kO1naWeAKecLNs2
   QnQBS3U9s4eFdrLln6JOF15bX6E6RprmEpwwvodP6+xp39OqoCwHTkU8O
   63X8UFrqT1B8tKWp6MXEf4pbdQDJrXsd2u6R7yXoeHR4U118ErPbGguUK
   Q==;
X-CSE-ConnectionGUID: syAV1fRlQK2P5eFpXG4Gbw==
X-CSE-MsgGUID: 8v0jxBA0SAK2WQitTAlqwg==
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="29920886"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 13:22:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:19224]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.34:2525] with esmtp (Farcaster)
 id c090e9e5-78ba-4c90-8429-056fade416b7; Tue, 29 Sep 2026 13:22:01 +0000 (UTC)
X-Farcaster-Flow-ID: c090e9e5-78ba-4c90-8429-056fade416b7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 29 Sep 2026 13:22:00 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 29 Sep 2026 13:22:00 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<peterhuewe@gmx.de>, <surenkj@amazon.com>
Subject: Re: [PATCH 1/2] tpm: Add per-chip timeout for transient unavailability
Date: Tue, 29 Sep 2026 13:21:56 +0000
Message-ID: <20260929132156.52496-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arabPv2YCddSMu_b@kernel.org>
References: <arabPv2YCddSMu_b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, Sep 25, 2026, Jarkko Sakkinen wrote:
> On Wed, Sep 23, 2026 at 02:28:33PM +0000, Surendran Kanagaraj wrote:
> > +	unsigned int busy_timeout_ms;
>
> So I think this is a wrong solution.
>
> Instead this should be tpm_crb internal and you should simply patch
> chip->duration[]. See tpm_tis_core for example.

Thanks for the review. Agreed that this belongs in tpm_crb.

TPM2 doesn't read chip->duration[] today. Commit 207696b17f38
("tpm: use a map for tpm2_calc_ordinal_duration()") removed the
ordinal to class lookup so patching the array would mean bringing
that back. Something like:

1. tpm2_get_timeouts() fills chip->duration[] with the TPM2 defaults
   and calls ->update_durations() the same way tpm1_get_timeouts()
   does. tpm_tis_update_durations() only handles 1.x, so I would make
   it return early on TPM2.

2. For the command durations, bring back the class lookup, so
   tpm2_calc_ordinal_duration() returns chip->duration[class] like
   tpm1_calc_ordinal_duration() does. SELF_TEST (3000 ms) and
   VERIFY_SIGNATURE (30000 ms) need special care since they don't
   fit the old classes.

3. tpm_transmit() takes the TPM2_RC_RETRY cap from
   chip->duration[TPM_LONG] instead of TPM2_DURATION_LONG.
   tpm2_get_timeouts() sets it to TPM2_DURATION_LONG, so other chips
   keep the same 2s.

4. tpm_crb implements ->update_durations() and raises the values to
   30s for NitroTPM.

Does this match what you had in mind?

Thanks,
Surendran
