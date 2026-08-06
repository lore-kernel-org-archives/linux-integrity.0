Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEF38AC75
	for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2026 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046296; cv=none; b=Fp6G4BKTkKvnGTG5xvA1u3a1lpg6xqoK2wvDOH7Nau0cnmNEIaPkxWr/dNk6aOEdY+T7/cOXwmhg+cCAwdWfM46hhma8UX6DhBwtN30H1pQOmyYXteMc2/5idcRuuyK6YTT1ZehxZ0O6/dN6vrHqi+20eGV2yUEnOvv57x5jE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046296; c=relaxed/simple;
	bh=cvrZjprSvVyAfeTRkM1rk0twwLPXWjPPevuKbkeA0fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2Zfg2qUdsZeoGnjdh1vKcD9zzbTkSp8tniNl/4S2VAjRxCfg1WYEbmFJyoWd5imRZ/6BiTc/OGhlVBvXjBNpHg1DfVrwGeb4fZSMSQBFmUNyVWJDqhc8ZHAvJ7qJtNbpdrbxh63B+juJJ8FEpC7QYboNUQOqhsJrsU1lToY65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHJU3FBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHJU3FBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA0F1F00A3F
	for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2026 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046295;
	bh=cvrZjprSvVyAfeTRkM1rk0twwLPXWjPPevuKbkeA0fI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oHJU3FBrEWgzEuRh+Sbjlz1LTofQ3qJN6bqZOy3/IoxrUoKEW1sPZygXGa9RuY6gP
	 mqYOt/c7NApGv3t7WClUKdzkwV0JXixu72wr6qyhVO7kWxVUxWrq5XEQijdcqHAOw1
	 cO1hGhLf6q69dwsgThmod4qeaxsdndORKiVNPMabnO/SCT23U2TYxNCfzcU/M2yGFa
	 V9XjCXtUOoR0O0sFHLj9pdnaM+xpcEY0pNQFqjFJEQAWrJ2SQyNsuTrCD36NyJ8O3x
	 qKbpGAtkOt0PG16Vazw7hG1PjBrcKFICphzkP4AZQajgVn3AtUiTM3LivZwyCf0cCA
	 DvsfIMR6pPnrA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2982329e87.2
        for <linux-integrity@vger.kernel.org>; Thu, 06 Aug 2026 12:58:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqyHgww9FmliRnyFx62Av0JcvguuNoBUU7UZSMO1Psw+4g+VLMeMEmGG/GYX71plocNXQIv3f9YcChB6DUrXmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5x4fvxQTGmLTlLx3YGW+aaPYC9SuGV3wnu9spOgllodPGBwR
	NuahwjOu8raDNqwfT0x5/+5bScYcF1FLq18cE9MEzAld/LJ2mc+dpfS3XS7IY3WPDUHEdZXU7/U
	45uXAzGyL/a6b38u17EyKVSMzfFwiCzI=
X-Received: by 2002:ac2:4423:0:b0:5ae:c926:fc18 with SMTP id
 2adb3069b0e04-5b2f4cbf05dmr1941060e87.38.1786046293666; Thu, 06 Aug 2026
 12:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com> <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 21:58:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
X-Gm-Features: AUfX_mxVKonPEmxE_6gVHTSbccc85x5H4GItoRc_G-pMzW1tYQCgFysLk2eR_Y4
Message-ID: <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Julien <julien82453@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 11:55=E2=80=AFAM Julien <julien82453@gmail.com> wr=
ote:
> >
> > > Please try the attached patch and let me know how it goes.
> > >
> > > It applies on top of the current mainline, but it may be adjusted to
> > > older kernels, so please let me know if you need that.
> >
> > Thanks. The patch seems to be working. /dev/tpm0 and /dev/tpmrm0 are
> > back and a command like tpm2_get_random 16 succeeds.

Please test the v2 of the patch at:

https://lore.kernel.org/linux-acpi/12954206.O9o76ZdvQC@rafael.j.wysocki/

The v1 had an issue pointed out by Sashiko.
