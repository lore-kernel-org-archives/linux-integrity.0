Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09089340401
	for <linux-integrity@vger.kernel.org>; Sun,  6 Sep 2026 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719511; cv=pass; b=B9jPImMN0HNrMZJgC3dtBz5EqOSKENKLryOxM6P+B9jdlJJ0rHexhfqibCMvVWZ1khNRFYZeh5DkWb/D/t35bxKf3c4hMLW8sAEcsgLTLOBBRsBPRvxTmr8OGjY676f8/zqvoTEHH2USHya6xgk3mW56QPH1QHXaYXovbnJymbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719511; c=relaxed/simple;
	bh=pvvJqd7Euafnh/j2/YsbTiW/PcrYqSgdLGzLkgxVrCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edlaATZfoywp0MxO7EdGyO8lrqYbR9WIUciEvYtiHhZCQniyw1ZZaF9okTqZ5D/lJN6G4NbziCC9Ak58fKbp5DIaxV3HeWd2xdwEQU//2z+5n+IgXOytDkIgiyNrW8Q+snifm863wCctWQMJijZcncHlNeiHWjLZTKW76R79NUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evd1MPP2; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evd1MPP2"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-864cd11a932so36017637b3.0
        for <linux-integrity@vger.kernel.org>; Sun, 06 Sep 2026 11:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788719509; cv=none;
        d=google.com; s=arc-20260327;
        b=XVVc4CtKkAfZdmDVfOEvjCu7WOq7qAUJIgbvEqHlvreVH81baZUyLwbbGJUQYowmyY
         PQDU2yMjyaWvZDz2z6FXqOiZad89PyfuvqdyiTfDEjO3xS5xcy85hoUlwHjdz7/dimQx
         /wEpm+dkNwbg8QJdUWdgFG/EH3LWEz0MSJnuSjCgkhcd3SY/rQAOUKj66RxxmjkPRtk8
         bdu7YK859kyg6TixMTngwWJ8aZLZupvxW9jQNNX/RrXPK/yom8EaHSR4YHSTrs7GBuar
         N7U70pfEdg/MeXQIbRUqMijrNf9xU6LX/vczv02rDEr0Gfdgu0MItYZUPnjdgtrJMuyr
         +oFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        fh=26LXIURsD8V5Xn0gVOAOz4IAZmFc+ExMVz5d9IUlozs=;
        b=bjSe/8cpPkn0bFd5ui9mSJwl5/K65QF2KueneR7cHy577QbKeuZ88rsmAVE77WR74a
         HS8hOqPLXuYMoK4kisH/ByEWz+w6N2FPyf2lIU+Eb7/46nF0jUZZAz+AsZra8QQUTh07
         nlp2TuVav4XIL31xxiOiVFolFHXE7rRi+xcftejRc53ix3PZolGtfukInxFGZG0XWP65
         rcdLYrd0te5wIUcafey2n28w8FLUBaqpFWmpPZ07yJWBpX8Zuv/F+yiDgflhT6XaO964
         MTeihc8SgvvHxRqlvYnVdSq1PfjJEEEnk+0Up5SJOrvDceRoFDKfn1CUDI3vADlDy0Ei
         T7DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719509; x=1789324309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        b=Evd1MPP2ae9RI8xQA/e4mGF7AG0IOTfrpmqWKNKTPZCFpMP1iagR2rLpyDykWRpdL1
         0BXcOJRac/vAIRNq4hYL95a/jACbSDRyza/flWGaM0PjaCpXOSTBjBZKQxDihp2TabKn
         9pTMrKSFHnuiYFB21Z7jC9HpHkVjKSrkc9pyGLNb2y7Q3emyER7+gY/AbNB5jo2OeCzT
         9JZK1xhUryo2gELVDELa+x9KwW4SDD1wcA9Nej2R9kNMG2h5bzFJp1AUpnDnTF7mM7Ma
         x4zbMLCa7qADhqMxxMLXeKSUyYfcfWpLlEucO2lfmwN8KS3GVxugpLZPYBYgOAg63TjR
         rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719509; x=1789324309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQkeSwtedLp1iDq5m8KD8XHS3VYT5RaCWuCgQNld12s=;
        b=qLIEV9zNjpcNxg2tnxQ/4WoLkg8nigYsf/jRfNFygOjGnULMQIZyqWGMemsIdhFFAP
         GLRXkIWtiQxHCVSIcp6UwrTr37uuMYY+OXEolfMse11rULBAbVBii3dBVsc1T+oQ84GK
         Can+tc8pQGuJem1WHK+ev+g30+OiD43Y+zO1e66RoxKvrF47tCnBtOmkABqwJQimprkW
         hlaKnK8ukndOPon3N+ChJOL8nUGQSGB8TRNPuqTZlejjx9PZqrHMiwROzFunlxSJ+U9X
         bFhDUEgLPX7kU8SMZ2x8QdY1sVl4L5uxhKhqrpn0iZyHlc2L/kBfH+f05omXCctNEcIV
         eyZg==
X-Forwarded-Encrypted: i=1; AKwUvBxLR9LCSdKNkStYkrmND35iHiFtlkyIbg2srYL0wDzdFylEaYANs+sAwp1TvLSYSKf5SEOUDWe5qfLQ+luxnyU=@vger.kernel.org
X-Gm-Message-State: AFuF++mMxkY+a8wadyscUyMH2vQ2fUxYZfpHnXLUo89ONI9BdyDlAlog
	fqo//5Ob81sOPK9G2K5aXJnkm9fuPeuQ5fT3kRFQppgcbPuUT+JcBYn+wIxjWu53RAPk54mJPSM
	OvlwRgo0gPTh6+Y6lGEo8aSkLXbOGtpQ=
X-Gm-Gg: AYBFou3M4lzkiWaP62/O8i5z8eiSR+bINlSMqrmOJCaGRGLCA1FI1rBxEwfVlCUQD9o
	DxO3+Rk+16A7iUv7d/RPGwwv6FnFIZd3/tKsicIoS/IoU7gw4qq6xZCf0QfeueUbdkLcJy2p5Fv
	Sit+XaziKmxMT9Mn7m1HU7d4DJazBKnVhAZopxNtmfoql0WshnCXPRfnlUBmAMrEAjQ3j2a3bNP
	HB+ehPvU3+9YYClW9s09D5H4qimDFeTt2qaJDpQUPT3BQzqjxGoVTJ5Xhf1uNg/9j8SK9gC/VMe
	3RvfvMqYMiZjKpBXQauQRnHFm87wZs0oj6UAi0UT0aqAlCBSb8sNtPA+/TfWngKmqkVIC5h4vBz
	ON8I=
X-Received: by 2002:a05:690e:43cd:b0:66f:c1bc:403a with SMTP id
 956f58d0204a3-66fc1bc490emr1136508d50.27.1788719508881; Sun, 06 Sep 2026
 11:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955564.O9o76ZdvQC@rafael.j.wysocki> <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>
 <apbPV_tsyYVzvEVt@kernel.org>
In-Reply-To: <apbPV_tsyYVzvEVt@kernel.org>
From: Julien <julien82453@gmail.com>
Date: Sun, 6 Sep 2026 20:31:38 +0200
X-Gm-Features: AcwNN1XY9sFlhyINrgcYqoQq92RQCKR2qxwUOv8SXLhPuRgwGnTe1uxZUxAdUfE
Message-ID: <CAJOGg3z22-G_+izney69i3AhesqwX-u0Coj74zXSjb-RzSCdvw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap completely
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-integrity@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 3:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Sat, Aug 29, 2026 at 12:43:30AM +0200, Julien wrote:
> > On Thu, Aug 20, 2026 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> > > with resource overlaps") attempted to avoid platform device registrat=
ion
> > > errors due to overlaps of resources of the same type returned by the
> > > same _CRS object in the ACPI tables.  It did that by combining two or
> > > more overlapping resources into one, but it went too far and also
> > > caused resources that overlap completely to be combined which broke
> > > the arm-cmn driver that expects two MMIO resources to be present for
> > > each device it binds to and it expects those two resources to overlap
> > > completely.
> > >
> > > Address this issue by adding checks for completely overlapping
> > > resources to acpi_platform_adjust_resources() and add a comment
> > > explaining what is done there.
> > >
> > > Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices =
with resource overlaps")
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > > Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@a=
x162/
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * It is better to check for complete overlaps both ways as suggest=
ed
> > >      by Sashiko.
> > >
> > > @Julien: I would appreciate testing this on the machine that needed
> > > commit f234fdaae1ca.
> > >
> > > ---
> > >  drivers/acpi/acpi_platform.c |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > --- a/drivers/acpi/acpi_platform.c
> > > +++ b/drivers/acpi/acpi_platform.c
> > > @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
> > >         for (i =3D 0; i < count; ) {
> > >                 struct resource *res =3D &resources[i];
> > >
> > > -               if (resource_type(new_res) !=3D resource_type(res) ||
> > > +               /*
> > > +                * Look for overlaps of resources of the same type th=
at would
> > > +                * cause resource insertion to fail down the road.
> > > +                */
> > > +               if (__resource_contains_unbound(res, new_res) ||
> > > +                   __resource_contains_unbound(new_res, res) ||
> > > +                   resource_type(new_res) !=3D resource_type(res) ||
> > >                     !resource_union(new_res, res, new_res)) {
> > >                         i++;
> > >                         continue;
> > >
> > >
> > >
> >
> > I have tested this on commit 1b78070aaef6. It seems the patch is
> > already included in it.
> >
> > TPM device still works. Here are the logs.
> > acpi MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded due to overlap
> > tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
> >
> > If in the future if I need to make tests again, should I do them on
> > the Linus Torvalds' branch?
>
> What was the hardware where this happens?
>
> Sorry, if I've ignored it (if it was mentioned previously).
>
> BR, Jarkko

It is the Acer Aspire ES1-572. I reported it here
https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe=
4EiurZf3kPU5A5Bw@mail.gmail.com/.
