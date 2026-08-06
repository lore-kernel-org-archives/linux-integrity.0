Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B42436361
	for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010108; cv=pass; b=LnhMgOaBIhObBHIhecHG3dutwEU4Mw34zCl6hDtm1sXCdirixSzS4Y1SGfjbonZxwNYAqQUUya8jMVwys7j8RZzSXT9qe+fSG7It1gzx97bWllycnNMNba1V1JdyTlIIxNaArByN0gsl5Wdc7u91xWkgq+f6R+4ofu9y2s7Jm6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010108; c=relaxed/simple;
	bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my3uE9bziN3Kk48i44Z9szL++MXlecP3vnIHFOnjh5y7yDQnpfLOdV+rsom1UktA6IDGtQyESQIJlAXwPF+bp8DmuZXmQNfXalgL+ur8KMoSjo1uiv7sONicEVQCJ3Cyfn9b3v4muu4iS2c5WsWbfJt9UErD1mtyVVRGa3raSwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwqO0iw6; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwqO0iw6"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6682259cb3dso1400374d50.1
        for <linux-integrity@vger.kernel.org>; Thu, 06 Aug 2026 02:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786010106; cv=none;
        d=google.com; s=arc-20260327;
        b=VAFVtsnKZve3HNwzlh5OPCDTbE5pZ29Mt0QJaslH2g1AQyVawzNJla2mbtsQPEtw4O
         XiyxPPnCydkZux9WOxxTYTO2RdzgMFPzLB9CGxuUdTM9Kcs7Vg9FU3oo36TXdmE5qaue
         GTlGGd28AL+vW3Qm3F6+jw0svwF1CQDdyzZhWh+YVmmPFS4DANtgs+xtnQvXhdYe3DiG
         yuUNS9Fytq5H5c1Kaf67IsJYqV0eqzZGq2tQWWzfMzprDPXdhyWYq/zxOqTd65rLGPG4
         NTOpUr2dMiLHG8Gta9S4CwMs9ZyquRy8xZnXdL7CvHkLzZbRyCMbF6jXi+QSMnG1cAcg
         yt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        fh=XYx0/+koA5Kl8Q/0xr9hUJbhwzmrrcNFtudf4YQewow=;
        b=MQgjSdzlFYxPsKe5fSIuh72+/+9+xHhM9Fgowfu4YAu3xrA9kQXJqCAj6/c/0dfa/K
         iNYB0xkyfEYDqgCgb5xbMk2X86PRnspHYJekcRtofZff5vd9FqxXi42Ebrhomw9reqTq
         Ea+1xpbwaWxKGocfohE5jv23GUp97BbKxplconYgkvNOKyJk7R2NrlZgd+6vhNz3i8mZ
         VNodHGSaWGTkdhiu+RgowS41mgo9xFScCD9jP7Mc/9d8AkW8NNR1pSkHGIH4W6+qtYYE
         dxhvzzxjlGiBMLf29rSDNz92QlxLTojfPoY2wVMG/Kib9SXS5dXUcRiOB8/BGPMl1XOB
         B+Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786010106; x=1786614906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        b=PwqO0iw6b6mUSTq5Ob4Oag4vKZjUltAV+05UqIPYGIoayxRy3bBZTX092lRhOTZeU5
         g3UuEUuQCt5svZOqwDzijyiX1uBax+xyVWNcH9MiVEavm++DMOalhuzO6lDtnmTFoZJ8
         3rHHmG9NBR+JKXe65CpuRnr2HSC7y/hCsQ7aXAWmARvv5Q+p6wGqiODqBfnaLMYsJWlB
         dfyx9cawQSukH7r0B02+J3gm0bhB56NN+swW3NdpNZ+15qyJVutLboQ8wsd29EyH1Cfq
         RJBUql8CeIU7D/+APZRRbNHRUTf7y59WO+JQIkMpFxD1hjX2SB6Xxa6sf9Lpt0Gi7WNm
         L5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010106; x=1786614906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        b=qUca8qtgy0RnC3REHu0T7EQYlmMmo7WZHuCdPnqecWA3p61yidNHMXoiQuQSaCmVCt
         Y7JQFtVM8iIJyKcwkwVKcb7+HTqxrc2e8/IS1aldr610yIkp6gK+8PUZVB/huSl1mD9/
         DBK6qGO1suGmZAf9E+hAubtXuMAoWKq2rY9d20K1IHT16eAVyx9XwqtwtAkjvx7dOpY1
         Am8PlEf9CJGvULlZyWFlb3gAopfEhVlNHqFZQqoTv9WZvQ1z/wdxAy+eCrT0G/HKFPkh
         G8Rb80hTPMXaEkRD+q/bKHYhBmqLfeEawZ83AqjltWVbW5lSlArOJ6ghjBzZHlVtbH2y
         /zzw==
X-Forwarded-Encrypted: i=1; AHgh+RpIHA2iAKLbo+p0OoVihuOYt1KiovCU8L00gz4biJ8j3LKKOYtlVfEfQa7sjjhWLKi+vt6MOFrr8hV+PSK91Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IKnedmfCX4wqL0SDFQI79hPXCeLlmqgieGQuuI3pfKEJsO2V
	SXizJ4oG+kYs/KVyUi8eg07vq+hyw/NO6YX5+++1OO8PTNC0W1v3VZLEdKuhMZpM0gxfwUJA/cv
	qBtsvQE8Zbowu48gEen0jHOcIQxpbG7s=
X-Gm-Gg: AR+sD12hi75uwiSIOGBFIaoU8/eAOgDhFu8wBdPOn6ScwLgYhq4e9JFnOhOIRQT3tkA
	BhyatQPSpnaEJPplDa1W80rnSJyv8LF7YIsZDKfcbXFktu24r2944O4coZGvTqmaSuw20yWPC7w
	04OPODxCea1MaYHk8w4ZcPIbhPeMvtHle4hEh4m17U/q0V8uYolJzB+Oyz15juXV/V0DOL5ZYjp
	qGVOHPEFDLBWnlZHonpQ9baxEFsz8CPZJiMRZa16jtGmLP4FnAXKiqVhc4lQ7TOCZSdGeQroEZQ
	FriOUs/6XctszfzN1krQiuKJIJy0x7G7GimUvt5CTs+Vwhl48Gu8J8Lve8f3WFkJHzHuikFrzbi
	hvBUlL0pWpW8=
X-Received: by 2002:a05:690e:b8d:b0:667:c8ae:f683 with SMTP id
 956f58d0204a3-66abad23602mr1541113d50.4.1786010105998; Thu, 06 Aug 2026
 02:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
From: Julien <julien82453@gmail.com>
Date: Thu, 6 Aug 2026 11:54:54 +0200
X-Gm-Features: AUfX_mxsuSxYb4bRTLw_auynOoK9idt7FQzZIelPKJrVZG-Vnf3CPDnTHMYa3ew
Message-ID: <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please try the attached patch and let me know how it goes.
>
> It applies on top of the current mainline, but it may be adjusted to
> older kernels, so please let me know if you need that.

Thanks. The patch seems to be working. /dev/tpm0 and /dev/tpmrm0 are
back and a command like tpm2_get_random 16 succeeds.

> I think that these messages have been present in the kernel logs for
> quite some time, but previously they were not connected to any
> functional issues.

You are right that the messages were already present before. I see
them in the commit before "tpm_crb: Convert ACPI driver to a platform
one".

Here is what the logs say now:
acpi MSFT0101:00: Adjusting resource [mem 0xfed4000-0xfed40fff] to
[mem 0xfed40040-0xfed4103f]
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

The second message was already there before too.

I'm sorry for sending multiple times the same email. I'm still learning.

On Wed, Aug 5, 2026 at 6:01=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Aug 4, 2026 at 9:08=E2=80=AFPM Wysocki, Rafael J
> <rafael.j.wysocki@intel.com> wrote:
> >
> > Hi,
> >
> > On 8/2/2026 2:54 PM, Julien wrote:
> > > Hello,
> > >
> > > Please keep in mind this is my first time reporting a Linux kernel
> > > regression.
> > >
> > > Since commit 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platfor=
m
> > > one"), my TPM device is no longer available. Both /dev/tpm0 and
> > > /dev/tpmrm0 are missing.
> > >
> > > Log messages:
> > > platform MSFT0101:00: failed to claim resource 1: [mem
> > > 0xfed40000-0xfed40fff]
> > > acpi MSFT0101:00: platform device creation failed: -16
> > >
> > So there's no platform device for the driver to bind to.
> >
> > I think that these messages have been present in the kernel logs for
> > quite some time, but previously they were not connected to any
> > functional issues.
> >
> >
> > > I added some debug logging:
> > > ACPI resourcet[0] =3D [mem 0xfed40040-0xfed4103f flags 0x200]
> > > ACPI resourcet[1] =3D [mem 0xfed40000-0xfed40fff flags 0x200]
> > >
> > > I think the failure happens in kernel/resource.c: __insert_resource()
> > > because of the two memory regions overlapping.
> > >
> > This is quite plausible, but if that's the case, it should be fixable.
> >
> > Let me figure out something.
>
> Please try the attached patch and let me know how it goes.
>
> It applies on top of the current mainline, but it may be adjusted to
> older kernels, so please let me know if you need that.
