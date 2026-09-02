Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9356403AF0
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339285; cv=none; b=TPwoRJ9WixWX2bmG2LdczbpAYNqaTYr1mxLIVO26a+DGDKmDTOc7dqOZeQloOkmE7zpqVcHNrvApYc0p0+POarFWqOaSFs+20fqtJUW803q1CH7eUgZ3+sSniqcGSDkRC7OYjxqDPXQxDK6TT/f6uJtJZSuHk9BhrttyY57BuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339285; c=relaxed/simple;
	bh=nIXVnKbBj8zZwIDuenenyH9ClZG5pn8VoZ0dv8TSNFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D25jNrZFQ0F/QVLfsZ24NMEnqX7sZJyIOCBrULnNYDT966XxK4FsU1IxBiumMCKILAWLeBTCtVNxaKGn2/+Ij+GIMNqDzlB2PX2WIliU0xRbR39mULVEVDkMBHvVUQP22vVOuMEgwg20taRlinjPEtBIw3qu0a+/M1HbPSlD98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/pyv7wk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rJI2DOwP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/pyv7wk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rJI2DOwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788339282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRQq8UCK7e+Uk/6jVU/zKAFr+j2ENtH7XtBNjkClDck=;
	b=Y/pyv7wkE4A2tjD0oE7ZZ8hhYg7vqMQpV+DoBS+YhMsfX8YJGn0Y7vYq7PcU2YVdFL3HTz
	tn3Gi/fbnnxXU1+ifq9a4QR/79rp+lrN6pOsE4zQpGrNu7Lf1WsIOLqjfIhffeftIkBi+n
	kYKL6fK3hCZwLz+WFm3hL2S6vwvESN4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-rSiNh2LSPmaURIIQ9GdpuA-1; Wed, 02 Sept 2026 04:54:41 -0400
X-MC-Unique: rSiNh2LSPmaURIIQ9GdpuA-1
X-Mimecast-MFC-AGG-ID: rSiNh2LSPmaURIIQ9GdpuA_1788339280
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482f41ca436so772612f8f.1
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788339280; x=1788944080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lRQq8UCK7e+Uk/6jVU/zKAFr+j2ENtH7XtBNjkClDck=;
        b=rJI2DOwPOWYLUmSZo5iHTfR3Frvw7LUFCyFAMFing4zXL5ZqCeV64QRZzJOj2zZSFH
         fKSJh2RM6W0EmjQ1/Af4k5tupe5QkV0TQiOyKZp4iaJ35AMhW4xIN+iVCWfj0nwT1Do0
         x1a2sqivj4pakScnxBbefMsFwuil8QRVHopXMye++ij9/t1Mz+avjiSGxjDhtzY8zQix
         Iu8H4iGkQC/q2ECiVEOFEH1fBwfw/8vqtomZdtuRy50Oo+bijyg+VnkAGIT9Kt+qjyyV
         IzuYaEe0bdc7NrOCOK3qGdigs0S7yrlg1BiXMacZqdy47Bsmh5ybAVE+7uFNW13WYaiH
         FACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339280; x=1788944080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRQq8UCK7e+Uk/6jVU/zKAFr+j2ENtH7XtBNjkClDck=;
        b=UbGY4xtFNcq4PMRndawzdRZpJSrw8NjdPnFh7f+38Kd8FxPIsCdR2SOOcYBEEEx8RV
         Ei9xSeWdP3/YFqck+Wi3yOj3I7mW1diKRZe7F/YYhSptnLcebHZLUr1iWkq+YyZFt/nB
         mx9MgvVxiXu8l//afF1W1NvL6jyom0DEuVkezsYpd4O3U41hgYfy6xLDrgd59KaU3wUb
         h3g3+dU54gJBRKW4iIHVJxzcWXE0dllUFebNXl0CPtdoqSVgdxCwwmwDSChHXECvHUW4
         pro1zqsuiW3V40iaoVt/8Ra4ytwyvZJgHkgiWgiXd8lQNvbNa1KckVZehDvEYobipXxb
         6feA==
X-Gm-Message-State: AFuF++nl8f3wKt+D7IasQ4TyRGAdIs6rzHyl0OuuPTZK5s+nA51KRS8y
	IMYxjNbSPc6plKo4xqLt9gNjS2Fk6PhCVbOTBiH+h1FBqn/kg3cChUoXPz1kPCfWHGRpZ0QL9g0
	1RwqJ3IVQB7jzoy0jTTVBa67pXEUUgoUvUYbwOGDEQWRBaUQmca3nV1V6q/h9VNHu9+k5Fg==
X-Gm-Gg: AYBFou3W49SUCtyTARTnb/dCsGO6Mt2qg0FYSYYXuEd9l5OndMvqggtmq03c7My3h81
	o+JroU2d0D29ZrrFjBW1h7t+l/3MBA5CNHdJZmZ0iWoD7ZQukTOJ1PmHrq0lDZLQ+2/n7ai1SBP
	rwXxCLZb2ZE+pztGDtror5dBS4WRlSsjD9V2JeHMM9Z7+LDCzxFa1WNZIYX4SDbBSdn6IRwzvx2
	AgOWSit/4x2pSaqMLqYmXnw3pT9RrVgJNPwcvMI+iokPvHKDM8b2KbugX+H/1qt+3yQwttXUoHs
	NBdV9/4QXg88JpPwP03rIe89OUh7OliQMa0IC0P005ddXPmj568MsFmu5BjHM9eVWuB5s2+o1GO
	CP+CW7FrnksENWVHUpm72mpFY4pwQGYcfb4Uy9wNxbsm4hQ==
X-Received: by 2002:a05:6000:2210:b0:47f:ec8a:214f with SMTP id ffacd0b85a97d-48488f0f6c6mr5354732f8f.15.1788339279940;
        Wed, 02 Sep 2026 01:54:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2210:b0:47f:ec8a:214f with SMTP id ffacd0b85a97d-48488f0f6c6mr5354647f8f.15.1788339279412;
        Wed, 02 Sep 2026 01:54:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed38cfsm4515296f8f.19.2026.09.02.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:54:38 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:54:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Stuart Yoder <stuart.yoder@arm.com>, Chu Guangqing <chuguangqing@inspur.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <apfg2kg2jkmooZoq@sgarzare-redhat>
References: <20260901142955.187856-1-jarkko@kernel.org>
 <apb2LdIAqUHROYBt@sgarzare-redhat>
 <apcDfzVRBtwghIuN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <apcDfzVRBtwghIuN@kernel.org>

On Tue, Sep 01, 2026 at 07:55:27PM +0300, Jarkko Sakkinen wrote:
>On Tue, Sep 01, 2026 at 06:06:40PM +0200, Stefano Garzarella wrote:
>> On Tue, Sep 01, 2026 at 05:29:46PM +0300, Jarkko Sakkinen wrote:
>> > In all the pre-existing call sites both @iomem and @iobase_ptr are
>> > either NULL or non-NULL.
>>
>> I don't know this code, but I'm a bit worried about iobase_ptr and
>> *iobase_ptr. IIUC it is true that iobase_ptr and iores are either NULL or
>> non-NULL, but here we are removing the case where *iobase_ptr is NULL.
>>
>> Now looking at crb_map_io(), IIUC iobase_array is initialized with NULL
>> pointers and the code we are removing was the only one initializing those
>> pointers IIUC, or am I missing something?
>
>crb_map_io() sets both to non-NULL value, or leaves both as NULL.
>
>crb_map_pluton() explicitly calls both explicitly with NULL.
>
>If anything else will arrive too crb_map_res, that'd be unexpected
>input, which without this patch will go unnoticed and will lead to
>undefined behavior.

This is clear, and it's what is done in the first hunk, what is not 
clear to me is why removing the second hunk.

>
>Not sure what is the argument here really.

Sorry, I should have commented in the diff:

>diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>index ceb4100ba400..e7a61f36c58b 100644
>--- a/drivers/char/tpm/tpm_crb.c
>+++ b/drivers/char/tpm/tpm_crb.c
>@@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
> 	if (start != new_res.start)
> 		return IOMEM_ERR_PTR(-EINVAL);
>
>+	if ((iores == NULL) != (iobase_ptr == NULL))
>+		return IOMEM_ERR_PTR(-EINVAL);
>+

This makes sense to me.

> 	if (!iores)
> 		return devm_ioremap_resource(dev, &new_res);
>
>-	if (!*iobase_ptr) {
>-		*iobase_ptr = devm_ioremap_resource(dev, iores);
>-		if (IS_ERR(*iobase_ptr))
>-			return *iobase_ptr;
>-	}
>-

This is unclear to me, here we are checking if the value stored in 
iobase_ptr is NULL (so something different from the check we are adding 
above, but appropriate because it only makes sense when both are 
non-NULL). If the value stored in the pointer is NULL we are setting it.
Looking at the code, I can't see any other point where that values 
(iobase_array[]) are initialized, but again, I don't know this code, so 
I may missing something.

Stefano

> 	return *iobase_ptr + (new_res.start - iores->start);
> }

