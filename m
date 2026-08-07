Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11F4756D5
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106798; cv=none; b=MX8PpCg51PkZ6V9sYFnjlzrLKIMfUFTy8EtDhczmLETTARTrPJyragr4KVr3zhiP+ny2fcBdvgDMghjgCYzobsDieNNJfXBYBOrSe2q6650hUFZKk+/Lf8BuQiJiOYLIR/++NNeCw4og5onTo77NR7+YD8L1sMstLIukN75jnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106798; c=relaxed/simple;
	bh=F6Tctv836SPSJAwEgYMlIIQPj2TS9nWMi6OpfZuvdU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB7QQS9vKlHEyMGsV7D2JOmWZEiChkmNT7PA5RqfYooRrycO7BJ7tUX3UDhiltJMmdr4OAM1cyzBWPO3GJ/CL8gAGU8R7uGuhB0I3YNR+e2hYcuqu3SyPVSq/acHrOFKy+vfR6iMZWQzE8xNp0jMiQ1Z69SlnF1jN/th918jC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdAU17uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdAU17uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A491F00A3D
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106790;
	bh=F6Tctv836SPSJAwEgYMlIIQPj2TS9nWMi6OpfZuvdU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EdAU17uXm8PPadZQKYRg6ExbG2upgh08SODyrchVvupjZTGqr3QKmamsm3HdQ2bfq
	 aIgkadbs3KtdqaaipUEC5mW1WzonbfA9QWHFlVasiitd/AieTjHGwl6ZWsKRfIas2y
	 NG97z6/GfRo+UIIVCanNoZEgH3eyFMMJWUhZub+2Vu//V3qGn5Yo3EufuycWaVZB7I
	 SYoEJcWXPuUoVGgV4GI7FH7INKohur9LZsMkxO6lbKvRfFgqveP540zojw+2W95HB1
	 fmrcBsDyvJksTyIQhaksMcrITgOLYSNb17jtGwsYA46sUCXzroqMO0Ma3/P+EBosjf
	 HANzumM2fNIvg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so27920681fa.0
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 05:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBy6Smw5MftWGcukuh6HIARpk7L4IfY7OvbtMF43YMi5dTV2K3m7jn1WyMG1sxcG5Cf+cpsl1hEFv8re+S72k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmCo0WmaFFPIOR6Ut2P+WazXrDnoBabPqpQnx0sAqudedwywY
	vymQNBmWW0MaON1zEvPrkQAOvKAXfrvzinKgN+kgEDQN1+gd2NddAcDijwPdh+MLO8PspJD8aFI
	aYn7KP1fvDfRLzC795A14i23RML99lZE=
X-Received: by 2002:a05:6512:1589:b0:5b2:dba4:d8ca with SMTP id
 2adb3069b0e04-5b2f4cd2967mr3457887e87.41.1786106788983; Fri, 07 Aug 2026
 05:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
 <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
 <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
 <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com> <CAJOGg3wZvftfk-hZ_wXBYnXca9gf5ziSo0Uh1BouYvzoEyEVrg@mail.gmail.com>
In-Reply-To: <CAJOGg3wZvftfk-hZ_wXBYnXca9gf5ziSo0Uh1BouYvzoEyEVrg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 14:46:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrvdkjOm75CZSSZmK2ntaVvAN2ru=0yvgXV=twm8uFaA@mail.gmail.com>
X-Gm-Features: AUfX_mx_NcFjnZwHGAaFGsUuUkbvqRdwTWBA3hLkOGAfTvMjhaP2pYzqyuX1vlw
Message-ID: <CAJZ5v0jrvdkjOm75CZSSZmK2ntaVvAN2ru=0yvgXV=twm8uFaA@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Julien <julien82453@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:26=E2=80=AFPM Julien <julien82453@gmail.com> wrote=
:
>
> On Fri, Aug 7, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> > And there is a v3 already:
> >
> > https://lore.kernel.org/linux-acpi/12955541.O9o76ZdvQC@rafael.j.wysocki=
/
> >
> > so please test this one if possible.
> >
> > Thanks!
>
> Yes it still works.
>
> The logs:
> MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
> tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

Thanks for the confirmation!
