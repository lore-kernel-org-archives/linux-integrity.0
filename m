Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119309;
	b=ufleHN7FHK1/5yVZWkJC4slKrsYJToIX2zdN7nyd3WY+/olDaUAhbm8ROCIxc5V2HdB2
	 12I3T6gXTVy+Hkwse0xgZpx6R8PRZ4oXcReQC4pCnTCvKl367KGrK44TLu2l+DgwAgN2+
	 iRfqr3XQXQB4AGlSC/hQKqQWW4GuVWD8xh2prjXu5HdfNglcD5aTzyapcMeOc6g7KNgb1
	 NJfVoftstZUAlJh8NeP9ybJj6+uysI0F/GyelHOvxHB5RFyrqn7wTbx58tZzNSptOgKN7
	 YeqiA4NGOwX/wME2Ji0qIkA93KxCV0TUPvSFHF14v+T+LRtYEATYddoczgImH2sj7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119309;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HvamKg69m8EuO3o+qYD0z47GTCOTQLf+wfkXOWv8Fvo=;
	b=j8Irs3b4vNjG80Wsbj0nr2+q6BQIZt+KDMVF74XSwxi1oUzqOTZNPa2GWTTRbYox/Ksu
	 tBKYvsC7PIRuAoz4VeDF1sXP1Y9dXZCPOUJtMDK5UHO/XsO/JZff7LC/yM41jzmuU1Sm5
	 eCrdOzRWU1xRx8B2nJzVuehInjqMuOkbejzf18ev9TcI7iFl/p4xDzuEsw4GgupIJ8zRx
	 3nic6BDXUljMlcUImfR929aUzLWHrlfj/YqXsrpJ9VeoobSgOgAk/83E8h50LT35jChWT
	 u2Dvy85miOrFo4s1lK56t/TzdbAaR1idTV4MCDTwD+r+BigOoylBPArB+hGYj6dRfzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XUK/fNMZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C9E8D606A325;
	Thu, 19 Nov 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUK/fNMZ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B8E8F1F000D2;
	Thu, 19 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119309;
	bh=HvamKg69m8EuO3o+qYD0z47GTCOTQLf+wfkXOWv8Fvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XUK/fNMZmkPb7w1gBF+xCyIII4cjcYpw//PSIKQePeEJyJ9nLLYCek9lfwW9K6EN9
	 kmLFldH6AGXBpta0+Wpc7gHmyIfvdhA+O8aATeaLPkMQZgatpLSsGU1/kDDQFh4Xct
	 7YXdLmJPc2Khp1O9/kRNMD6d2mbYXyv2I8D7ZA0pvX4xxa/sus0drmCBzTRjf6uTBT
	 NslglZWR9FmC++W+quXJ8Ckb0DzAm5yPI9RQPYpsHF/u9QLupzNhAAqcItJmolda/b
	 0+7UvCujopttFf7a6A3Thgc7zL8OgbeaSJ/DhxG99pH3muj8IBpzeDK1zpuszp5uEY
	 hvELhFIVDrByQ==
Date: Thu, 19 Nov 2026 22:15:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Wong Steve <shyckless@gmail.com>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, sstabellini@kernel.org,
	linux-integrity@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
Message-ID: <av9YyWpbdnIF67Hl@kernel.org>
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org>
 <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
 <av8kIqYC04D5QdXf@kernel.org>
 <3b37565a-4dd7-454d-99b7-108b8e4e7133@suse.com>
 <CA+X8Sdj4KRfJagaKHkcXrv370Si_WktanBqRN-SrB7qOMH=FAg@mail.gmail.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X8Sdj4KRfJagaKHkcXrv370Si_WktanBqRN-SrB7qOMH=FAg@mail.gmail.com>

On Fri, Nov 20, 2026 at 03:31:53AM +0800, Wong Steve wrote:
> Hi Juergen, Jarkko,
> 
> Thanks Juergen, that explains why nobody has run into it: with the
> stubdom backend the frontend never sees Closing or Closed, so this
> path is only reached with a backend that does close. I agree the
> normal state machine should stay.
> 
> So with today's backend this is latent. Jarkko, if you prefer, I can
> send a v2 that says so in the commit message and drops the
> Cc: stable.
> 
> Thanks,
> Suyuan

Given the feedback, go ahead.

Br, Jarkko
