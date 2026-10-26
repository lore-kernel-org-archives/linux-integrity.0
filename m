Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024921;
	b=VCUCL3LlHuLzOvCNkhiSLY4WzqQC6JhUIZngjWDk3TF1m/nfRHaxxwouR3uxHVsiQVtT
	 NCQTr1vosy5UY2SSAn+j1YOH+dfwVAoPWQhaOGsjuYPW394s7ye3SXUGSxujSK+KUQfWn
	 y8Yz6XS092Uvr9lsM1D9GNEq4W96IW4XhqYTZZk0Ggr66wKIYpfsD9kTzpAb+EVi7Qa00
	 8puSgZhhfmQLY+yNORmKvuk9OAdmGBTjW37jfXurzUvjeoFkvLKJ1RhJWqwil3Dhcofgv
	 edVSi+zLtYOZKFMxeV16GNjZ5VueAAKVu6lohhKSI4GRQC3uTRxYc+cPSY1djUvTEVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S27QzKMcYR9G8Z3dEod1U+E+8QpI3/ATLwAMINQQlkc=;
	b=1iAYsfbtZvfr+RB3qP/hrecaaLSR8aHeWUp5RHaw1zWlAZBJ5ZEzTn/bnVDNjKixCfik
	 dItjRR5rObsvcbqAJ8qVFDX8RPL81nyXIuToIYDNVA3pKRrRGvM46r01cMk4ApsQvAuDD
	 OupdpNwo+AlO2U7+h/YYxphJ41xxtbXMP86MYWY4gnY2pR4ZHi1GUHg4Olro3GcZ134Yy
	 HIlUtYKKAu/34yVmNuKXnPZWGrf0irBkA0bb8AZEYrCVRLyzZzp01LUNC88Nerw2EQmuK
	 6V1jIGAsxU97NTC/FTlCADNICDqpEjIsiq43iLQI7p8lUxroKkyvjFCxQek4/U3NvfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fp6NuUFP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s19Gc6uY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA545606A31E
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 14:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA545606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fp6NuUFP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s19Gc6uY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793024919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S27QzKMcYR9G8Z3dEod1U+E+8QpI3/ATLwAMINQQlkc=;
	b=Fp6NuUFPyaw2UQ2llu6VouoBzr10ovta9gi+RLzykxHorzLNNlwNX+z49KL0dRiZgaiXyM
	7H2J+z3jOr3lwS0gpdz9RnnTIBdWjiSzFoEZlf/ClBXsivtKJuzH9HSR0wbMEMST/p3//j
	VuBsO+z3wwfHZxGlWNG36COASNl3Adg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-JtVAhwEsP2ahSxk2Eu8Xuw-1; Mon, 26 Oct 2026 10:28:38 -0400
X-MC-Unique: JtVAhwEsP2ahSxk2Eu8Xuw-1
X-Mimecast-MFC-AGG-ID: JtVAhwEsP2ahSxk2Eu8Xuw_1793024917
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so8972140eec.1
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793024917; x=1793629717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S27QzKMcYR9G8Z3dEod1U+E+8QpI3/ATLwAMINQQlkc=;
        b=s19Gc6uYHWb+eFLtQB/iS8KUrhlZDPxIWEQtaPTybmZ7tNSoSobMXTxnXVfj7WlJyj
         Q95mEIQlRSmS49cOd6QeTM5LaBpewKlIdVxGv5/lPSBFpPBNdPETs4soJozqrRpTCoLK
         YqM9Le3NOad7ADwR0bwvFVJuxV00XoSTr922XX9aiw5osLSu3ihZf0o1EZxaJfkzY9wi
         QBsg+a74R/BW4zKqfLTssbt48SzLkXwrGq/14eRdI3kjlfC72acnoMZeNvbmSTjlZNcz
         zJCvwrqaL83RbTRA8vD2tD+zZAREbSSYgPqa8GGe1o3QQzb63ssUNdmiXqhTt7FG/zAQ
         ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024917; x=1793629717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S27QzKMcYR9G8Z3dEod1U+E+8QpI3/ATLwAMINQQlkc=;
        b=CXrFZOQIeP+DFsKs8QxMiMFgA/Aw5JIgBeJzDP6kzIcmaxkm/SL8r4W61YJMRyhFt5
         7wb+FUfaeDNWgMslKb3zdwoluOcc/w81kSlh9nTQAUVbey9ZEeWjElYGAy6STpmZT+Ep
         yDUxcRc3i2YA5CnyK0qCg769MdyQQgaCKpbU0AmHRlB0bcJJewmkldlqyg/sKQZ74r2X
         ig04NW8PvN7epXXMj/e2Y3g0Bhk/PD8C7dL4nO8hluSH8AJsh5vHPQUuUs910KfzDVEu
         tysr//0JvWjWH58QOOUUdIIBsh8Vgp6Y2pG9B3xh4242iVcXU1rYAfiT62obA+XRU8DU
         tVVg==
X-Forwarded-Encrypted: i=1; AKwUvBwu4t0zkAyjog2gX+CxFtQFn44AMiVyOrGwM/2yCBu3zxS279dhLnxdNJPmaAaT2IZGk2lDQlBZrdh/qwvQoQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBngzsTzLOgEIzb13HO8FT+ghgWCHHjjuNO0k8vjSO9TT0whCY
	moIYOHqryjYyr9mpYVzizYJZ6a8MQf4ttgCOy9MV+SX3GljwBNZ/4HLERVUZrlb6sL2TPPA/33n
	wVuRxbJvGpBUFSXyGzawoNfyLKhM25EpxCDyu2h9S36Nozq28mtDcTdrguCrb30p1YNq1AV0CTm
	/x6g==
X-Gm-Gg: AYBFou0K3ke+tz7ZO4jSmkxFUhoKadd5mcxe2ElK34mbmiDnlDXUhTXFd0C7Q3XCoH7
	j3JQtiL1KLxcWHXKSx5TIRdnkig08arK84/ALmn2JtXP/nJQMs0yHtjBW6GzhVbXSAqsFCNhYa4
	5HuKmKxckch6prDLNNS7sq/381rlmgZiHIpQiBBfPwoyXJ26KMbWfjOOYjDOBhc6Q3Co1l2V9dw
	Kist9M5Jv30Wr4KOECScZzfMB0QpQndx+AVA3AxZHePpZFP9iQo6nm5bKZ7aWkLCO2dF4xvKYfF
	V9FlwgvIdQEixcDYCYifdcNEYzyf2SQWOUl8zfdQanTs2JBuxVsoiKP14SFxMENGHw==
X-Received: by 2002:a05:7301:6f09:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-369e84e382dmr10158562eec.22.1793024916381;
        Mon, 26 Oct 2026 07:28:36 -0700 (PDT)
X-Received: by 2002:a05:7301:6f09:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-369e84e382dmr10158525eec.22.1793024915537;
        Mon, 26 Oct 2026 07:28:35 -0700 (PDT)
Received: from fedora ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee71f5sm33500881eec.28.2026.10.26.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:28:35 -0700 (PDT)
Date: Mon, 26 Oct 2026 19:58:28 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 2/6] tpm_crb: Split start method into a separate header
Message-ID: <at9jjLN9I5XsRPZT@fedora>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-3-armenon@redhat.com>
 <at5suDJyVOusvc3R@kernel.org>
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
In-Reply-To: <at5suDJyVOusvc3R@kernel.org>

Hi Jarkko,
Thanks for the review.

On Sun, Oct 25, 2026 at 10:55:20PM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 26, 2026 at 01:48:54AM +0530, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > The current implementation handles different platform start methods
> > (ACPI, ARM SMC, and ARM FFA) directly within crb_send().
> > Move this logic into a new helper function, tpm_crb_start(). This is a
> > pure refactor with no functional changes intended.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index d76f9e30f036..9a2f512b4ae3 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -446,6 +446,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
> >  }
> >  #endif
> >  
> > +static int tpm_crb_start(struct tpm_chip *chip)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	int rc = 0;
> 
> After declarations thre should be empty line. checkpatch.pl should
> complain about this.
> 
> > +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> 
> I probably did not spot this last time but:
> 
> 	/*
> 	 * ...
> 
> https://docs.kernel.org/process/coding-style.html

I will amend the commit. Thanks.

> 
> > +	 * report only ACPI start but in practice seems to require both
> > +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > +	 */
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > +	    !strcmp(priv->hid, "MSFT0101"))
> > +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > +		rc = crb_do_acpi_start(chip);
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > +	}
> > +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > +	}
> > +	return rc;
> > +}
> > +
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > @@ -471,29 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	/* Make sure that cmd is populated before issuing start. */
> >  	wmb();
> >  
> > -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> > -	 * report only ACPI start but in practice seems to require both
> > -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > -	 */
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > -	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > -	    !strcmp(priv->hid, "MSFT0101"))
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -
> > -	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > -	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > -		rc = crb_do_acpi_start(chip);
> > -
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > -	}
> > -
> > -	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > -	}
> > -
> > +	rc = tpm_crb_start(chip);
> >  	if (rc)
> >  		return rc;
> >  
> > -- 
> > 2.54.0
> > 
> 
> Br, Jarkko
> 

Regards,
Arun Menon

