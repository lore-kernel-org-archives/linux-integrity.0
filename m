Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435877;
	b=dBmY9niqhfDRPyx1L3Y4lZgqzJvAFrbds8Z6mE6zPx0pZcDapuqwNYb33lR8ZZaktQtD
	 1Q2lInaG5us+B90Pd3CKTpzBh4ZY4cU7vHDhz6KOeMmLF1ybq9zPUWm05Cl9U0ryYQKxr
	 2klC39T/EyN33AbzgLUN/dFAst54o/xus+NsP0axTstpCwEgFpNCb0ct77/+rN/eXSt7W
	 0mq+C5T8tKJ+mh0Nszo1RJDVUQ6geyak9qSkKZOvHEozb5SP8B0zCJ3VN1mmdL3ijeNec
	 U4ZVCmYGe4mPzz4ePh4RyPYd3qHFrffWFfJl+Zbv8IeaKlptUbq5g99QQooM97YcRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3Eh7AtJFr/uR9z6jF6Gx5kvJFnPR9rDrn/UUs08sdns=;
	b=L5nDFKkr8VCvUnLDom5iFLcJ4Q8hhin//+D1ZdOiq5El1gbLthqAuLZcQ8Fio8/1ski4
	 dWXwVU1L/j7ik6TlypTSpIDz2G1BB9tS1iKlrGLOwMvsYEDYR5N5p4Sda3/jkZHIZ85uD
	 Ej99uX54V87QyDNA67DULT4LUu/kRr5JymcsFHjxItDPlmiSBjPjDQZcAAFHyUusG5KBr
	 SRC8/NkdDACfikJ5/dg0LGldhaNE7piJMdzuAZr0i5pi03mEM2cgI/kLh/oMtUPeHl8tz
	 vLrjA/4cvph7lwbo0SiHqKnaZemT2ss6jGFK3TwdKlNTXOMZWI/VUB8HlUep81PDFZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQamuCjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 68795606A31A;
	Mon, 23 Nov 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQamuCjA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2ACD51F000C4;
	Mon, 23 Nov 2026 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435876;
	bh=3Eh7AtJFr/uR9z6jF6Gx5kvJFnPR9rDrn/UUs08sdns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQamuCjAL00ho8wuAS/xxVYieoyQgKpz3vy0va43FUKk/hFwrbG6HzxETV4CPonrt
	 k6jRu1ZOOtEWQhRCEvXtWxedbA8rH8OmH5G9Y+BVpuIHAGJk91cXf0mLNnnojRcdUj
	 qSaXcxSIYXF49xIPCkBP8y3ijLUXYm9PmxXpVMjadfNtsJhik07hKDBj6ZsYokPsHx
	 Rcc4cnD2AigMAxeskn6n0WGYBuUUq0kFKMe8Dt6a6ijFzvVBvp9CvR9Yd4LBFa/l1R
	 qi5fkN6MIlAIbUe+StU8kBx84vegQRFf4wZ6C5FKplP1e/LEdlfU5TiCBE1BhkDXC4
	 kA0JmqcFgg8tQ==
Date: Mon, 23 Nov 2026 14:11:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 2/3] tpm: Introduce Qualcomm TPM driver
Message-ID: <awQtYP7tFjTN1Mm0@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
 <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>
 <awGtGoxtker8a9kG@kernel.org>
 <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>
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
In-Reply-To: <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>

On Mon, Nov 23, 2026 at 02:48:17PM +0530, Kuldeep Singh wrote:
> >> +module_tee_client_driver(tpm_qcom_driver);
> >> +
> >> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> >> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> > 
> > MODULE_AUTHOR() field is not that useful and nobody keeps it up to
> > date, so you never can rely on it. Not NAK, but just underlining
> > how litte it is worth :-)
> > 
> > Copyright and authorship is anyhow recorded by Git and
> > MAINTAINERS document.
> 
> Ahh, I noticed couple of other drivers doing it so took it as reference
> and adapted here. Seems MAINTAINERS is updated correctly so folks can
> rightly reach out to me for any dsicussion/issues later on.
> 
> Btw thanks for mentioning. Will keep a note for the next time!!

Yeah, there could not be more copyright- and authorship-focus project
than Linux. I mean even this discussion is recorded to lore, and can be
used against me in court ;-) Probably most corporate-safe project in the
world when you think of it.

Br, Jarkko
