Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88B342509;
	Fri, 18 Sep 2026 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695978; cv=none; b=sjHSm7N+d4MOrOzGlv3W3T1b28p/bh8KLHeIKCfqUcKxtRdNKZSG0GrR12YUAHirw64K+zIZzfxWlj+EMju/0NxaRblnsBNRw4nONzGroqkXXDcMB/opSCtLaZNW8VM0VOLKQG7XAIQq0O86A7tihoX7jkAXJJeAThr+3s7JIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695978; c=relaxed/simple;
	bh=bJFvNAg7H5agM1HactVxJzTKNHcBmhLKpanpE3FgISU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb2/xDpwts3zJS9J4e9T/80vSUUnUTW0rjBsVlDpqG/zHpzYtFSqxvzN02QsZdy6CjUnUOIO51vkV9WIMnXe7p7eC4lRPHmkkv8ETwodsiimye2Er/0uru/Net9laZ3w8hqol3gSQDti4l3NVLmVtNGQn1YWvDE52fUtXjXKCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpWJjZvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpWJjZvg"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 23E541F000FF;
	Fri, 18 Sep 2026 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695969;
	bh=2u3meNWxQYQ1Mt8YuVLeCNZ0cRyM5LGDc5fnxMCWsPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpWJjZvgev0voVijt5EhAzd26FhX3J3ELiKBsFwqM4I/TDe+RnQYO9DBdMx/Fkm95
	 IJfCB0pnIxrQ2ZK1sgzd7QCtdBb0WdXtppnwsHOMBERVPd8Ch1ql3r+exPKrbhyEAf
	 w6+98Hk4TMi+0AbTv0t3p7wuigvzFf7h3GkC+T4MQDzq9jgGU7D4LB1TmgFPfoqzUz
	 YoGOroCCccBPRGvWgIOub8fSH2m9C1e8kpDJ1AE1gUqApDGMeegX6ys61G+ArQSQUT
	 kQFxzQJC7ev4cq5GO4xURz4EbpCjMWg55/z2Ru1N6G3y9pAHCwZa0hy3j/snJHK7B8
	 Co/rNZL9zzzWg==
Date: Fri, 18 Sep 2026 04:46:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
Message-ID: <aqyX3lJ1eNBmzbSP@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>

On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> is enumerated as a TEE-bus device, allowing a client driver to bind to
> it via its generated UUID.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c        | 4 +++-
>  drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 4212572ff54b..aca4e8c6e37b 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -753,7 +753,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>  
>  static const struct qtee_service qtee_services[] = {
>  	{ "qcom.tz.uefisecapp",
> -	   QCOMTEE_UEFI_SEC_UID }
> +	   QCOMTEE_UEFI_SEC_UID },
> +	{ "qcom.tz.tpm",
> +	   QCOMTEE_TPM_UID }
>  };
>  
>  static void qtee_release_service(struct device *dev)
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index ecaf8db67d45..87f1c257a877 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			81
> +
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> 
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
