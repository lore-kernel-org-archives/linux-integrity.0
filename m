Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416A47FB1A
	for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558130; cv=pass; b=NjCSknDz+xnH8usXyASF/FnZn6r29qzIrS7GYDnbl8SfSU5TtHHC4Z7d2VWt5ji8HsYRJOgTKe2wcxJSKthFVUmxPgUGZ2KWhJWeTM1QO/bPM45UMiORhqe1taGwRvBz2XkxZ9YL34oXGNOWfscbC5+c1KDeNOvBXFgLaeeRw+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558130; c=relaxed/simple;
	bh=tDAznMRjGGoRXEXLcatNnbfYk03GES+TYl5AHVXiJEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNbOLRrl0SWyTBMoqWYclMnhUbHfVHvwjTOLq3zHXQI4mZ+Sf2KpYPWS1ezZAe4JydsIgAkRKGZr9qsFP3g5Rq7sQOVGN5/wi99sjEdHr3ipbgiBAuecCDBnQ81oABy9EnPjT/T112GhNsGrliwNXpn8oWJ8TJMgaclBpGyuIvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJEgvF31; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJEgvF31"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e8fa1b8d6so16541917b3.1
        for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2026 11:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786558128; cv=none;
        d=google.com; s=arc-20260327;
        b=V+ubn8Vfv6hv2mkVatKEB5c+5apPiabcp4L1xyi6kPhjkmHbLTUR7NdGS9x8I7TH7/
         9vBW8vrDnxg27F3H1HnT/PM1KZKm0xNCU+U8sQZHKCkpONnj05r9FBt8aw/dOmmtlS1d
         SnrchFFff9OX+2KK0wiPavM/FoRTrXtjmXNF+bQHZqRk70Qklp8OEUN1+ado+r5zq3sc
         xtIup2mLHpfFf9/QlvltP4nR42teZ79pP63nVFp0qivU+8+MxhJXeRqUU1UHnXfFM0m2
         +PEV2e77pAvH4G/XWdhmRYH3+y9azM9R4sTCSHqVmUMI/MGVXMYs78bNar1GbwufEwBG
         qUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tDAznMRjGGoRXEXLcatNnbfYk03GES+TYl5AHVXiJEA=;
        fh=XMB1QIjKOpgtvevR52EzYSRtkTjkAhQMB1g3tCygbFA=;
        b=pHpee2RE3pqPkrWp2uDq5n+ApTl/V9Q4vJ+0LrZCLwvPAvfKH5m/EeWZqYnMH4P6aA
         mtjzBkAEM1/UNxQLfS0i/9ajUg1DB9ZnVfT9uwjnvJ1lOU1QeTtDWQARq6PiJN3XCsPN
         tvvdVSDZ1nLB95B9j6O89jaL7yyk/S2xymbYDChgzg7T/qMCmGtFjzKGjcs1oyQsiVWF
         A6WcGV7VNUAyA78liGmG8C7YwNYVvo/y8oyOPc3n5akvNIeywa5R78u5CYIAzFz6sK20
         pvmaIw37fgbillAHBs/49TY+LpZpkVzGIFjIIa/X1/p7MVAPJtuGuHdE77/4pGY7y8zC
         /WHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786558128; x=1787162928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDAznMRjGGoRXEXLcatNnbfYk03GES+TYl5AHVXiJEA=;
        b=KJEgvF3130CxkEaEvL0JCZGXDXwecDmTIFc5PBPPOu77PTdsXQvoHx+1UwHg2HCY5j
         /3XWkH6k60IoBjUeoMQWmmZXAOhERl3toQ9upcMaWIjoGkJHPu7kktDFVmII7Fm1cRiZ
         U75TgF0/j80/v5bolvdIoSbqEzwnp8QAueQwRuw6h0QMK4IfXb41r23Xyh5AugtC2j0W
         g1mH5XYX4uKwE9voSGosdXwXjgQaqSCMXdYpapwkHalfe1FSP2fj133hWt9M/o7OpScw
         v9AtlO0OSNpiA1TZgC+ECQvEiu3KSRFNY6+4s60hOJBLko6/ub9t8Neux+uwoTC12nvx
         jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558128; x=1787162928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDAznMRjGGoRXEXLcatNnbfYk03GES+TYl5AHVXiJEA=;
        b=cSwWnS5xyF2YvUa32bptEjl4Yke9vKVI+5Y4Yr9LVSXAvAd8eAl+8OHJjfZEocNLBd
         PAazokAQKsPL1fAy3EPKM5np+T/FEWhbFF5sesRGZd3uQrFN9BUNOKy2RuhbGmhul+F4
         CI4rxZgfUZQzR6B67JOEAg8HqQZNABa9jBuilu6+cApZvEVdQJcaNcVFqzZ8j0USZApA
         lMRj4ZmMQV/3Jj80RmSiRG8N6KqFCNcQNhDctY6LjZ507mt+afMEBDRyi3rgxDVU5C0k
         YI4cEceZP+x32Aqiy802yYgX07cT/tKWoZnjanNGXM5uPxqQnS/3u6QooYriNJp2DqzH
         bH3g==
X-Gm-Message-State: AOJu0Yy1CjmVqdatzkvfaOuQCyU/pEIB/03nX44EMQSi/iJSDLQdnDkK
	lfywlSsrObQVOLdtcKTVjMqo2/sjNhwN/ohKeokcPKBA9l5VYAUsHbLSVog7Q6Aom6cVXSKbwbF
	/cEVk9AEWHzxM2O7JrGs1RQ0mvJYubLY=
X-Gm-Gg: AR+sD10lpfqNSW6RIhAl/Fr8SPloV4q4Uxq5OK5D3I/WWATnBDl7wGWTcxCl627cOcd
	p8yYRL3OnbLoogOtMFSBkWhaU6OkmAr9phs+ZFrGxbDD7ydgiW70fgduJ5Nw7DReY7dOI00QTzL
	CkaZaY5p2LnUwgK2x+sAykS/CgFOtPZYjL78g+Pp06of/bQCXUb8FYCZFnHWdz87C2modTlfXtv
	NOQKwTQNOx1SJrbcoHLvT4hHsP5WXlc69bNzNHdY7Eqc37afCNd4xeCfhnLn6EVRkS9Ft2pNVlv
	wRa2+SB7f3uAV+wW6IlydLI7XKxoo8DMEs8OBK7iXLrpaUV+pynb6vDua5o4Hx6qOAczT+GkYDZ
	p
X-Received: by 2002:a05:690c:f08:b0:80d:c24f:b790 with SMTP id
 00721157ae682-83103c1b43amr32915937b3.5.1786558127896; Wed, 12 Aug 2026
 11:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <annvXXwcLfD2NQDU@kernel.org>
In-Reply-To: <annvXXwcLfD2NQDU@kernel.org>
From: Julien <julien82453@gmail.com>
Date: Wed, 12 Aug 2026 20:08:35 +0200
X-Gm-Features: AUfX_mwsjbdH1Tfa1xTcWeM-qjIO-NMhf6HDOGI-dyH3wm8OSe-uzSuRj50grMw
Message-ID: <CAJOGg3yt-0NxFtD1JHEuVwKhuMDBVDc3wyV-p+ZGkk_C_WU=Fw@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, regressions@lists.linux.dev, 
	rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:33=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> I'm coming from holidays and catching up with matters.
>
> Is the issue still valid?
>
> And don't worry about be first timer if you have actual problems.
>
> BR, Jarkko

Yes it was still in the mainline kernel I tested a week ago.
