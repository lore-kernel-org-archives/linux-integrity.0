Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962046;
	b=MhzrYQSH2jeWgwd/fqFdRh8yL6G7PqmkVX9y/3qaSRlPKv+MW4UXJjRScVgOdVXIisbC
	 Hp4Siy2O4mvvX/y6LDHY2QwDF2TlOlG7EW+5gSoQLVadie81LXvqS4QjNQFJtkx4Hq0Jv
	 1vxRNXfQ0qonB/FzXIepvLpb7i8Rcr67wdSeWVnuTjCkvbje72c7294RA/C8qNTBSrGWy
	 RU9vtHVTDNqCztUxhLUFihwRKiDhT5JkFbP4ViLblpNkQQTe8AgeMdwaNVOyY4RbjPbEg
	 GkQvwEAjI/HfIWYEflgL7a+tD/1Xz6c7L52zO5nwvtOlSyPtz+TtyCgux0p9wf0wWhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962046;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m3NtOvcBCMbA6Zc5m/TBtRq9kmoFMiGoQdHmr/dAtvE=;
	b=zS3eYh956NEYk0Ij635mhrEeMJYy+8bK6mzrHlx6R249y6nTnZoSE0D5dChhRIPoVdxC
	 f6DbLc7oAe3vzBlHMJpNgVBC8VAAFOapRT4i8PQac3eQ8gCZFe/YvHg1xucXdn59cb/0e
	 HwwTz10CFDWjA85D40Wb6bJsfRXiZVuX/OKywP4dJNHZWETav573/RujDncca84SM9Yy8
	 L/rw44zU5a3mIX+PQjTK9gEU8tmlGGNgVsJzK6tk6Sum4rkDpbvBvRQghtGZ3LhyPr5cN
	 CU5ijRmDqIcSpRflD9Cnrd4imKsKaQaM39IaPrWLSxFADtvVgeiY1o0AUCVsNxe/SKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js3oeayX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 35BA4606A31A;
	Sun, 25 Oct 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js3oeayX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 499281F01828;
	Sun, 25 Oct 2026 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792962045;
	bh=m3NtOvcBCMbA6Zc5m/TBtRq9kmoFMiGoQdHmr/dAtvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Js3oeayXqDSPHIab9szvocd1/Bt7KBtOGK4uf6JAH+b47Yk6Q+4uouayEYIZ/jLgr
	 IHMWnbqcVsTB0NP+Cqpma6fdTPzlk7eD6UtJg3NwWuyM9OtvpqdxHfRPNAHIN3PB32
	 3ac5nODi/5Ct2+fsG2llQrS7wulKxUC/IzISHOU15aGbznbp94IUaoLf3IQWrCbni2
	 tXz5ySDkPWfPdBpgeGQLHagWOBTfOeHMA9CN9jFppNJen8QdQqqOXoWT1zWoIbdRai
	 lsNZUukRRMlMYeW8W/sHLq7k+LZFVJvaDdk2wJGuWejO0gcWYz909Ilcwda+DpWxRV
	 Ss7YMnwD5M9GQ==
Date: Sun, 25 Oct 2026 23:00:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <at5t-u3h1sHGJFmk@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-6-armenon@redhat.com>
 <at5tmTYX7ZjO_Q2m@kernel.org>
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
In-Reply-To: <at5tmTYX7ZjO_Q2m@kernel.org>

On Sun, Oct 25, 2026 at 10:59:09PM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 26, 2026 at 01:48:57AM +0530, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > The size of the command is checked against TPM_BUFSIZE early on before
> > even sending it to the backend. We therefore need to increase the
> > TPM_BUFSIZE to allow support for larger commands.
> > 
> > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > also order-1 safe.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> 
> In what timeline? Or is it out of spectrum timeline?

"For now" part concerns me and I'm not educated enough on topic to
know better.

Br, Jarkko
