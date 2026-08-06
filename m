Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080803F39CB
	for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013148; cv=none; b=tG9ZaXaNz2kO3w92RpXVqJnt0iiUH9LuUNa8lsdOxf0H/yScxc2xJqz/mmFyS5X8BAZ0xuWURqPhR2AN9yFeX0EV8+sol5grDvO2mxt03iPq2nxS2pV4YDV8lxaQ1SZ66sPdjZ1Yzx+JnEWErd9GFPTpaAjAQZL3wwNE55E4Z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013148; c=relaxed/simple;
	bh=Yy9NN6StTUGCHmz91It6CZkJiBh8nVeLjzA8N8S+Juw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBvW6fA3Q6pgLHy+m+nAxTWtr8b27hSvpAm790o/5ODjJnOAIJqR0A4FiGAVhdtFNIbTIlq86JByXJHeoDDgQRKXfZm+dBSr7Dl+sLdMGoIf/iHofAfG7emGjSHijS9dx5ndasiy3kmmpD+8JZxntv6eIv4VWhVXTDb9ZJxUO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU4genYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU4genYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB951F00A3F
	for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2026 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013146;
	bh=djO7shqadaQTxX8yglnqE3eyXdYHTRIdQmx/SCl7J9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SU4genYlY4b1vqOUfl/h63DjrfHgHIx7rXo5Rh2EFO1Pq373Aulebw8j0qGNFifKZ
	 7gbk3aqd5dQ8Rb7ul5lAXbil2MfTzsnjkYaneLm3J33LZBTPW/WOdK1ctvBsLsTOAo
	 h+J+Y8c8JwRkTRHYYEvF2WaMCSCZOlRrPz5IVRvqOpfhh4rXqhll2MQRqluTM14sWZ
	 cKSjVlMI/6gy9k3BXu9gJda5hfWs6lIQXFFNoIvMwLMUF7DCbDGT4IO63Xq7fUmdiF
	 fAOutbaSTzEkgmXpXDMQWECCYVN8Nmnb1wmfEdSD/asbh+vMvx6RounbLId0pTlXkQ
	 eg4Rz799gUdQg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so917179e87.0
        for <linux-integrity@vger.kernel.org>; Thu, 06 Aug 2026 03:45:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqAmGBH6+p2x5GWLhcs2Dnzf/0RsDzDmorFBVf+SYx/kNmpXBeBF3AJ6B52F0xNBlMrZw/VfTl5eJm//7E11SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzermQbujean2xhloCZJQT/gSnN6CNeY+GIN87mGx0qsU7IORPb
	FBY4tIrf/+DyU1io+rT0VYuNWbKC72qMh9d1GJXyrS20LGFHBn96+1I95FtjgjOOOJS2PBDoLL6
	VChyynAbj1LBLO2tEueyuO+qjq6gCWUs=
X-Received: by 2002:a05:6512:344b:b0:5b0:1e26:7751 with SMTP id
 2adb3069b0e04-5b2fe77f226mr647282e87.8.1786013145235; Thu, 06 Aug 2026
 03:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
In-Reply-To: <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 12:45:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
X-Gm-Features: AUfX_mysbOj3-ytmwbj8ovVB7UBPb93RR777oXTytM1b6w815LEzfJ9MSkxI434
Message-ID: <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Julien <julien82453@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:55=E2=80=AFAM Julien <julien82453@gmail.com> wrot=
e:
>
> > Please try the attached patch and let me know how it goes.
> >
> > It applies on top of the current mainline, but it may be adjusted to
> > older kernels, so please let me know if you need that.
>
> Thanks. The patch seems to be working. /dev/tpm0 and /dev/tpmrm0 are
> back and a command like tpm2_get_random 16 succeeds.
>
> > I think that these messages have been present in the kernel logs for
> > quite some time, but previously they were not connected to any
> > functional issues.
>
> You are right that the messages were already present before. I see
> them in the commit before "tpm_crb: Convert ACPI driver to a platform
> one".
>
> Here is what the logs say now:
> acpi MSFT0101:00: Adjusting resource [mem 0xfed4000-0xfed40fff] to
> [mem 0xfed40040-0xfed4103f]
> tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
>
> The second message was already there before too.
>
> I'm sorry for sending multiple times the same email. I'm still learning.

No worries.  I sometimes do that too.
