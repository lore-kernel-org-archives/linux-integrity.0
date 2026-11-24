Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540945;
	b=d8T7jZXy8NN1LST7WO3d7wb4l8fLuboVFhuntbakvgexxByRfRZw1rL+ZTSmtUWF0OZJ
	 fW6c51MUe/2hJfAhOMFHbj4P36m7rlFMMeoDjbTtD/d+IwdnR8aSwE4FpHOHwqEfASKzt
	 wEDh1IAlifMS4i1eQEpZt+GsxS3bpAvMNft1gkQlX374vjxQFaFdhOa/2iwN16LD9ZYgC
	 JuI9UyMbZsEv18crkVwvLX72HhSJpd0hKL8ZaWE9xjQPvBJOyizaAex1zYWIdZs2/fwmZ
	 A1LOWoe92bOjBGQLCnmIsnmBuGoNRO2a4eOK+L7RVNJqZAWs5J47/wu8jfU1AMQxwww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540945;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bg96bcIoLUpym4kMkN2iL5dtz01BBEGXK3L6/FYNr1I=;
	b=4w0EmwvpIJ4xVE4owRrqfFgZLdMQPXkfRS1gSZdnFkgVQFbO8w7U0L0Cvd+mNtQ4zjqD
	 HEAJ4At5AhPZV0dDdZmvEj/TRbUirtnueGOHJZuhffbP+AWtV68rcUcMtp4S646vBz1a6
	 mvRMq3nQilzvW//C2vaa64kZXkNMtf2HaBcPk9uXOxek+PGAsItFP+eTNwkmEX16ZkH+v
	 XmYLhE9o/6IRUKGRnpUxNWRFve+NesbRYv0xprb3TlvbgRdwMmhR1KwNAKXWrcFt/NuqN
	 4/+eh8UBib90j82SGcAzB+mvyTieGFI2doZn1OdXhSujMczb2g1lQzAT96H0k5nilWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i29aFu6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D1BC2606A32A;
	Tue, 24 Nov 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i29aFu6s
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C97171F000C6;
	Tue, 24 Nov 2026 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540945;
	bh=Bg96bcIoLUpym4kMkN2iL5dtz01BBEGXK3L6/FYNr1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i29aFu6sxk0J3WlIOlcRsr44EaiBDbNCcP7ooRU6O2TESDhVaXjCHfyFhDUc3qNy6
	 fdyBnvEcBdyNbEhG9c3CdU88+Z+5q1IzGlnCuse9mqQzL7ontGRuIbxUPSEVOXf24t
	 5ejNamidSMDBfQvg+JmA03IqPjHR0ElDHGGE8JG0hZzyotDsVH3AldS4WdDqp290nD
	 KNzj16D10t6TdwWKa4vFO5HnmNFTF2er56xyhOLCNif6KtJLDBP/927TgyfwicSAvf
	 Y2I2CRtkH/jMgKczl1zJioKxIzgVl9ILKCsOmQRwAPJ6YWJpx+93A2+7wX0L65blRU
	 xJisv62tHDw0A==
Date: Tue, 24 Nov 2026 19:22:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awXHzblUfp05jZSQ@kernel.org>
References: <20261124142432.368943-1-rmustafin@cloudlinux.com>
 <20261124142432.368943-2-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261124142432.368943-2-rmustafin@cloudlinux.com>

On Tue, Nov 24, 2026 at 09:24:31PM +0700, Rustam Mustafin wrote:
> Assisted-by: Claude:claude-opus-5-5

Drop this and send one more.

Br, Jarkko
