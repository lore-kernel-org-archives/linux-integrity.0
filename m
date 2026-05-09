Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CF239567;
	Sat,  9 May 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338466; cv=none; b=h7IRYRJTm5wHVQcerjKy93BHrWtRUGIcjFGJNxGJH1zCcbw4Vnc4DGpdPFKjS3Ef7LruBRT/6Rk/4xIuSDSyywiBtJBass9A9euD5BjXbKU6RIMk4pebz5pVYlrUC5x+vmhMSM4YmDsarDCe9nEIQkTGvH6mlcxW7znbKG6XADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338466; c=relaxed/simple;
	bh=xB3V5KcXXzXwF1rLAu6jbsABlM/MbOk6xgrndruslyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch2fuUdFHhd4udeYyw6zd57OLyL69+7ON/xoq1+3wirYmK2lnBGZokHzURlZgzmQkv42KWGrsfvzXWjrMYbggSbU57fcX5qAdGtwrds0og6pGG61bpCKe/qv0nz4+HVbLrnludk4Si0OcTmXFpL5EYKt7xkCdaSsVsuZd3/Owf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvcY3fbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvcY3fbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E15C2BCB2;
	Sat,  9 May 2026 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778338465;
	bh=xB3V5KcXXzXwF1rLAu6jbsABlM/MbOk6xgrndruslyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvcY3fbO4hXcd7AHRuDM2ga+bhTsX8hK5+oKqs0PAIgUAuhAY4Yfv9Y2qZHsjIfgo
	 Q8N6cN5SnpoDxHNevjx1kFZS1T+WjgYxIg+xn8uxxtMLPutfsjvM6yOEVYwzSSWi7i
	 ZI2sqyowC4rrOHqHo5uV4RePw4NSgx4GEb6Z5xVh39TmkIhp6j3tNfdJT8zmuyj7W+
	 S1Az9ORULTOyebS37yCFwbDz10OL3QR4Ih9Tke7zfLiMHOspubZPf2Q12u/B4pDLEg
	 ljllJGACcGNgRKDiZ+5MCrHHmjVqK3HgGPARdxgGF+3gzDErmB4RJbl2Im2McpUpmR
	 Az0Sah5AStSpw==
Date: Sat, 9 May 2026 17:54:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <af9KnU90yMf8MxnQ@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324181244.17741-5-armenon@redhat.com>

On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> The size of the command is checked against TPM_BUFSIZE early on before
> even sending it to the backend. We therefore need to increase the
> TPM_BUFSIZE to allow support for larger commands.
> 
> For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> also order-1 safe.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 87d68ddf270a7..26c3765fbd732 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -33,7 +33,7 @@
>  #endif
>  
>  #define TPM_MINOR		224	/* officially assigned */
> -#define TPM_BUFSIZE		4096
> +#define TPM_BUFSIZE		8192
>  #define TPM_NUM_DEVICES		65536
>  #define TPM_RETRY		50
>  
> -- 
> 2.53.0
> 

Shouldn't this prepend previous patch?

BR, Jarkko
