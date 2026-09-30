Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139BD3C457D;
	Wed, 30 Sep 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795768; cv=none; b=OWA+GHf2Rwrgt+I7+VXLWcA4qK5FghM8OI9YajVA0EuRByos+EWSUYV+oEOw4Qk+bxnNNI3jM32SIfdjpc6MCtmksTjQzBS3EH6U2J5RAHbW9uD9vVY6qNYmD6zuOY3YLN3F/EQ5eiYx4VCoi3zd4hpV0/TlJFfL22dENyJkDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795768; c=relaxed/simple;
	bh=NZ5wwC5Jlg0IpJyLFNo4+HGeXNndofreykcdAtV6ZL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVJGHq+8ZI4v+FujjlDGIvJ+if3xF90YbXeao6U8b/TFHqXm0kruG4WX2iJ0p48oDT8GDHN47Lvefzm3MsNetEM1ZtyfBSy0z48P9W8zZI9ZexZNez8DfIYtHHDRnsBvtLYilgix/TXdG+xK/XaSc+y26gWCT1m2uShvjzqs5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AQv07yeW; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AQv07yeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790795767; x=1822331767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRrrQnuUVcuozrp3PeKrAq/l0kufNg6YIsMfYm1mJhU=;
  b=AQv07yeW6azkSi5KXwcd3eEAdJyeVEpH0RlIBiNfhnzhHGV0d8mVOktW
   WWr0O/CcQs+82f7qwTe7ojSZyW/AugrZq61T8HbwGBXnmwLCfhH1oBgOw
   5Ej6ThHYZgDaCqTasIpVL6Vpqor6nXvUqKFtWV8wKtYchQxeQ8LoESCK4
   vdkoTLBF0VCT+GEbZc9oYXe7raYGVU3cxw+e5ckdXymY8Ik1JKdwKtsig
   /n7K52GqeLO6ufXfswmxkmSDYB/CUaQuoV9RIihoc9AZ0FMWzDVyxJTFc
   sjJLNbyj15uNxY8mRNuBLcJLh39NE8EKpyZvqdV/GPmimzw1zEN6PDnlV
   w==;
X-CSE-ConnectionGUID: d3JOrCyNSaq7eoCyWoOIVw==
X-CSE-MsgGUID: kFdaw8MiTva0/sJF4Y1vog==
X-IronPort-AV: E=Sophos;i="6.27,133,1787011200"; 
   d="scan'208";a="29932371"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 19:16:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:8284]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.213:2525] with esmtp (Farcaster)
 id c29106ad-99f3-4f2e-bd33-0a8b56f7bf1f; Wed, 30 Sep 2026 19:16:02 +0000 (UTC)
X-Farcaster-Flow-ID: c29106ad-99f3-4f2e-bd33-0a8b56f7bf1f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 19:16:02 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 19:16:02 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <leitao@debian.org>, <graf@amazon.de>, <gunnarku@amazon.com>,
	<jgg@ziepe.ca>, <joshlev@amazon.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<peterhuewe@gmx.de>, <surenkj@amazon.com>
Subject: Re: [PATCH 2/2] tpm_crb: Raise timeouts for Amazon NitroTPM
Date: Wed, 30 Sep 2026 19:15:59 +0000
Message-ID: <20260930191559.83568-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arw6GJymRFjesinz@kernel.org>
References: <arw6GJymRFjesinz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Sep 30, 2026 at 01:22:16AM +0300, Jarkko Sakkinen wrote:
> See my suggestion for 1/2.
>
> I.e. we need two patches:
>
> 1. One that makes all duration assignments indirect lookups to
>    chip->duration in the main TPM driver.
> 2. This patch should then update that array.

Makes sense. Thanks. I will rework it and send v2 after testing.

Thanks,
Surendran
