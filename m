Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434441;
	b=Fs2H1XuqKyCYQUz3P9VUkVf0vx8TVOfqUQrqiUvdwfNrSTf1sS9C3D1faXIpEvGwPTpx
	 /BMOibwXZlecnoq6GpVzzRomwaMHEUNlveBJ1S/jV4H7VNmxTCHujP/rkvc1bWpJ4eSPn
	 mtnMa/RMQA+q/onKLzH8p51glFxRFFYCVFJFGbGuRsKyi+Qx97QzfsdmjmaBli3PqZtGx
	 qzc2kqu6GygvfngukCstlzoYFkOPbtiP9GvAWUjzF7Rq8eXeCIRoNBsEkktE0QOAW8FpC
	 9l4ef7K5yC2CcII+lwKpMoV3NNrVctmU1H5eMZiIp81kU+LgG7B0E1z6rfqbxoWpv1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434441;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=o7FjhCPmXbZMctj//JJUrqZDv3+6C4QkSctbr92ltS4=;
	b=0i+K15gAEYl85N3NEws9BGgyZ9d5XC2JtIYDOewSK2xSeW7tbwkZ5x+ZKCdynW/+FbfO
	 YRRF0eWDCOYaH9BOHCrPoMmfaWJ2c6bxiwQb/qjJjJ4vvwp9niWraiJDtsRuJaUrRkOql
	 LZfKI3RT3o2T2wclNNRO0Abh7sD58XcKJc+5Ldt5hH0CS44BQoIapjTWsIa2Ucc4v+XHf
	 RqETZrGehI3gzamtvKmH+4knhUmKhLu+4mkaCb6Muwrfv7jrt8KJgBqVtUztYOt7H//ef
	 8fe8aR8DbVggymMWwxDGzXJZyQx5SniJYBXdPHbtrKFI5HUsIg5ycaUm8fLz0llFa8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=oH3p538Z;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030A60A3813;
	Mon, 19 Oct 2026 18:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6030A60A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=oH3p538Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792434441; x=1823970441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o7FjhCPmXbZMctj//JJUrqZDv3+6C4QkSctbr92ltS4=;
  b=oH3p538ZTD5/l7e77CmFIHq0F9dxPTTW4f9HVFOoch++Cq07C6vWAvj+
   St0rns20FgCGYE/DW3B6TQnY1Pwd3O/75oHZFWhPlfnaRTjxK74wvwhMB
   1LS9CUGHyeHo1dCEE6WspjoSp0l8BEVdqhnyGbQOtzNcFZrtnV9fCxF3h
   FWfVe0T7rzRXNDJESOxQ/Us+Rq2qY4359+RK4ganH4Yvo3qQmIHFg+dZ1
   6WGZioofTGbp3ATKANujTU+O6/dWStSx8nqWf8iR4Xbg6xbTSspupKH5D
   1qb52nab9Qm9wExMdj6PLYj6oDVIYz71ua/dVSEy/hJ6Er8cFTx6e1kNY
   A==;
X-CSE-ConnectionGUID: gSdzwmxRTyquCVYkuPh3sA==
X-CSE-MsgGUID: Jy32Wv5ETNCvryrbhGyOag==
X-IronPort-AV: E=Sophos;i="6.27,167,1787011200"; 
   d="scan'208";a="31587261"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 18:27:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:15353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.105:2525] with esmtp (Farcaster)
 id 2998b543-fa1d-4238-a539-40ba3ca3ede5; Mon, 19 Oct 2026 18:27:17 +0000 (UTC)
X-Farcaster-Flow-ID: 2998b543-fa1d-4238-a539-40ba3ca3ede5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 19 Oct 2026 18:27:17 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Mon, 19 Oct 2026 18:27:16 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <leitao@debian.org>,
	<nh-open-source@amazon.com>, <graf@amazon.de>, <gunnarku@amazon.com>,
	<joshlev@amazon.com>
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Date: Mon, 19 Oct 2026 18:27:13 +0000
Message-ID: <20261019182713.57308-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <atLD-d1v1B8ARv7x@kernel.org>
References: <atLD-d1v1B8ARv7x@kernel.org>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, Oct 17, 2026 at 03:40:25AM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 17, 2026 at 03:31:32AM +0300, Jarkko Sakkinen wrote:
> > Yeah so this needs a bit more redesign and while it is a possible
> > way to address all these issues I don't believe it is best possible
> > way imaginable to do something that lasts long-term.
> >
> > I don't want to go into concrete proposals because then I would have
> > to really engineer the whole change while at it because I would
> > likely try a number of approaches out. I.e. just a bit more effort
> > and innovation please.
>
> I can give this:
>
> 1. Map the whole flow how we fluctuate values of durations.
> 2. Think that if you were starting from zero how would you design a
>    unified and coherent flow. This includes all the callbacks and both TPM
>    1.x and TPM 2.0.
> 3. Redo the flow based on that premise.
>
> I.e., break more things with consideration and if it goes over the
> top then we attenuate the changes where needed.

Thanks for the pointers Jarkko. Will work out a design and send a
proposal.

Surendran
