Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F923909C
	for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930356; cv=none; b=VrRfUIjbX42BmqMvLBTcCyjTjWVGgItoS0hfgV0JsLlvS6bmAkU7bQxUFNCTbzh+u+2Q+tYJRMpwPwZ4uE+gSf0FfiJQtYeqAXrKm+xgPXdiOpK5AAMi08T6LUs34Gk28Th0Jo1UhvOcWsflbiq26jpFOz+bzkaRyGU0cvCcQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930356; c=relaxed/simple;
	bh=MUIgpz4nKc1Ifj681lvMpsc1P9TZSam1taTTKIN85is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCSk4DsGFQMsKJDX5BFy3K5VcIyOrRwqewzcm/yNZx5V44Lepg8lFTONQIrPBItS6fnGLOCFA/sUTx76RB0hH9YV1cwnfR85ud60f8zFVUN20Ivod5+GM2fYtFmfxhAr5rUkQYP3SiEytthW4leuSxfcIP6UEZFGJFwo8JxUiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WLXSrAX3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WLXSrAX3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ef8255cccso8382887b3.0
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2026 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784930351; x=1785535151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WQ3cIAte29peloA7ilqteMd0LDA6wT2JHU11VjgfUo=;
        b=WLXSrAX31vIYde8AhuG+OTI1rqdKLnGJMMfYEVG5pmc+4UQ/pZoLokWQom0tebv69G
         zkapK0dvQOjrYDUzXCx6viwQjpuYizc3r1fsHWWbTcNOYpIxAsEC2LVEAEXxfI3T+t9F
         XyjVk5OkCIDBBav5XqqFkDNXprt06xHXdp5y6X8yR4KgjBBXkbi6/lBYmFYQTCwtyk9w
         qsHmGDNBLMVRGNrnXfp7D/qTPcLFYGf2BFZSJFgWvSg6hcHefCs8Li3U9TDoZKTkEkK9
         1XG7SjOI3m12ltS1updZyEqhDkU6MAVJ8sknQWsoHNJM2/4kvqOWEkgIqjGSyv7M3akh
         P9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930351; x=1785535151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WQ3cIAte29peloA7ilqteMd0LDA6wT2JHU11VjgfUo=;
        b=C1O+I9Hjxfwxwybmnu5b3zidk8Ax/1Zq5uaT8qye8tdtNqvmjFYtfL6dhsz76zWScg
         dGj97OeLE5/7eWqSoXqHIlUb6t2wIB8qEYoKuSpEhl2ylZp2ClCBbXodP+32rlxEWSDP
         +pbLR/C38WbV7nxwFYa4VKyw608Se16YIXJIxWU98x6ePiw/6ItbweXGDaXwLckAE68l
         CwoBS00riS0kRniGcXOpZRCW6f5SD7I/EODnVKeIY6rU4VQ18yrVAnX3jTG4/iEZVX5/
         qS/r8yT2ikYkyeGLTjus01frJhQo3yw6d0Nhe/GAEAYRlzwWmDPoTA3PRpfTs1sqeF1S
         fh5w==
X-Forwarded-Encrypted: i=1; AHgh+RpkYfvXpVBegEUHaWjW3gIxb6SYYRBJc4NbZlvLBrJvkTo87GPOb/aAdqqlJ+ANd8X7K7ZOeqlPjR23aivxzik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0oi9ZY3D+xA+M1yFheYVVim05LDLArLXVo5sec3N8FHdFQDZ
	f9vQzAgXG137tm59BXZ+nzWYmybnv4ePU4oGs6s6Z9j63GFhleOVITM6BANJ0LLrc9c=
X-Gm-Gg: AR+sD10H+vN/OoGcRTrL0w87RxXW23RHP+KcJOUsXQ+K0d1upqmDrIvlXGy+dX/BdPP
	bdIGye12lnhS0n69sBe80v4QtBr/sAjMaffq5mdeMhp1rAULh9RlwUv4KzIXPiyQ9AaErnn4waW
	Nz4q2GBGLrIPqbEbgqzxVBdYNwj75g1KBnRFXTLs8r0wHf2eAqVCx5h5X72KQx/VKPyChL6Y7yZ
	CrYcQ8XyMkMBw/qyZ56s1s46j3NbPyuOcMqHBZhLultuuc1/7vQX/UlyHN/zUA4nTm/f3EK9sIz
	d3HcvueBIKQsH8SfsnXWRkHXuJClXC9lI4M263+gtBFbJ3hRTbUbjsvMkpd96cmgDV5XXN9FFH6
	85/C7aqjfUIPepdEP0GIbnTWaE7PeNS7O0HjDE9fRkQDNxoWs8GcYgQuq
X-Received: by 2002:a05:690c:6d8b:b0:81e:d032:f3c8 with SMTP id 00721157ae682-81f69e2f265mr799977b3.37.1784930351217;
        Fri, 24 Jul 2026 14:59:11 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:5f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6592eb29sm5818427b3.43.2026.07.24.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:59:10 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:59:08 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] ima: Report errno for failed hash collection to audit
Message-ID: <lkr72ii6ids4d4izyh6ruqhuxigrvlxsimz4tjwcdhmvz2enhv@3dsebnfscrm4>
References: <20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com>
 <6e6642c14477e409ea34a6090a61cde7f00934fd.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6642c14477e409ea34a6090a61cde7f00934fd.camel@linux.ibm.com>

Hi Mimi,

On Fri, Jul 24, 2026 at 04:34:07PM -0400, Mimi Zohar wrote:
> Hi Frederick,
> 
> On Thu, 2026-07-16 at 14:10 -0500, Frederick Lawler wrote:
> > integrity_audit_msg() wraps integrity_audit_message() such that errno is
> > always set to zero. When debugging for failed hashes, it'd be nice to
> > understand the corresponding error code with the cause.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> This patch looks fine.  Any chance you have time to look at the remaining IMA
> calls to integrity_audit_msg() and fix them as well?

Not a problem.

Best,
Fred
