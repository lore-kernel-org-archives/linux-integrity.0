Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568970;
	b=Zyhw7kZa/o5cNUx7vGJNIWhRUEkdy+fFRAkxrftdMKsXlozPRzxq+7KZhpFF4Ju1R9/+
	 0QFhc9PmiunKUY4yYB2By24kKNB1V9JNc/PXcZVndw703D80OLIgtOCiOYifQEpb/bB1c
	 zaFaFLD2TrDtAJVLWwdrPmnkowVXJf0xejJ5Gb5ucaxyFKXwSPD+9C6yqCiQLzhKtlfHY
	 PAFLCSQpVU52Fb4r7bU4gL5qgtZAZAtwAju0+rA+z9reBEqaRtq/BmrrGBD3t0P1hRrzq
	 IOXQ5pHRV7r9FevGM9U4veHnK3vlPatpQCa9nACL3cZcWEF1IEBuk7K70MO8cX0rLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568970;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mw9ALp5m6wk+v40aZBRs95cwBAwuR1QaIazcbE7LyXQ=;
	b=xPDdJsEQ/V0Yo9UHHI5nBvw5+odlz8yW+pgxXZG8ekmqYeCLPgPKKemilCpy9rsrPWtM
	 mL7Y5zq/98yABdb4QJzKqdyTw/0x+EXrHwA2khSVYuqsyoeSp7BVEz3PMeafa4sgEzw1Y
	 pw0TbZaBLijojI1kIrd+9VdcDGzZIkKmw1ham2Sdeg4mPMga/2w5rAoci2zStBR8V4g2M
	 U1J3yJ01nrR3DRI/I/YEMiaiAi/nM9NNDzrdKEU0Du6/aXL495SjVs0jnH9c70985YL0i
	 AUNypS28FRnVkYEOf/NLcnS+4fFvWkNrheE7XqvFsPPy8kSd2DcJGnJcGcijaoadg/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTpDnlQO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0B9F2606A31A;
	Wed, 21 Oct 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTpDnlQO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 086E41F000C9;
	Wed, 21 Oct 2026 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792568969;
	bh=Mw9ALp5m6wk+v40aZBRs95cwBAwuR1QaIazcbE7LyXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTpDnlQOpJ5O/IXlzsIQN/HhAQvO4OdgtMBaN6SEtfIfE1hth364NrneDgPzjmPDj
	 JpCJ2l1A2vjS86ClRaG79NTWDYxEKx01PxJRrDR6/+Gu0fbVwK+QlWw3Z7MX+yxNFf
	 s1gew//0fW9SahPGm3lipgOyxGZDA91358P3XTKyTGHY9WMDrJjHCLLVZ1ETap5/4C
	 XEthzrj2YmVP05kACZxHr0uEaxpK8tMEXtn6VVqqH439EnKWmLPOssbrprGYdScp/I
	 Fh9rVEYIoK/ZrGVV+j8Q6ixWQsoZVOIVIhZmu4jlPGBycL/9PC8SERkoiUmzTtH+nM
	 WIj5MHMcTo2Ww==
Date: Wed, 21 Oct 2026 10:49:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Jens Wiklander <jenswi@kernel.org>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <athuhfkfGPZp_YXT@kernel.org>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
 <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
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
In-Reply-To: <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>

On Wed, Oct 21, 2026 at 11:21:33AM +0530, Kuldeep Singh wrote:
> > Applying this pulls tons of TEE patches:
> > 
> > Applying: tee: qcomtee: Track the object invocation context
> > Applying: tee: Add kernel client object invoke helper
> > Applying: tee: qcomtee: Allow object invokes from kernel clients
> > Applying: tee: Export uuidv5 generation for TEE backends
> > Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
> > Applying: firmware: qcom: Add support for TEE based EFI-var client driver
> > Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
> > Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
> > Applying: tpm: Introduce Qualcomm TPM driver
> > Applying: MAINTAINERS: Add Qualcomm TPM driver entry
> 
> Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
> cover letter too and this series can only be merged once Jens can pick
> dependent series[1] in linux-next.
> 
> Since, v7.4 merge window going to start soon so i doubt Jens can pick
> for v7.4.
> 
> Jens, Any plan/timeline you are aiming to pick series[1]?
> I see it's mostly reviewed with no other relevant feedback to be addressed.

Maybe it is better to pick also TPM patches through your tree when
you choose to so that this will go in-sync.

> 
> [1]
> https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
> 
> -- 
> Regards
> Kuldeep

Br, Jarkko
