Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAD432311
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099548; cv=none; b=ERy+4IsB4XGeBERVkS5VEa7klmYb/ckgicSmseJuM6T4Tc/kn7cZYl91SlTT0TQ19gg6+/TZ7DK4oVn9D6/JK2fEFbF8kD3jXYCQ3pTZgOEfObNMIIUkREoroGckc142fm1iSpxHg43yRrwFNUoeVFixe1YmPEmjY2CJXrpInwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099548; c=relaxed/simple;
	bh=VBZac2SC1u2vRO+E4zkHrmlHYdaSFvvpY2HBEq5hh4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjB4Vd4ziOiert7Qm+dEBwix4ihgxaFmL+OaSd+574uiF30332Mq8qXGODbl6/Zxghz5j2hspRZa647e2yxbbzFBqyhpLvRYyYxnq2jUNw6XPPntiE3XHftwAMe+n9uDUjDZtYuptk0NRiN8uSlc7ya3wQftNpoRuJyqsLaZHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA6ojUPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA6ojUPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B911F00A3A
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786099546;
	bh=VBZac2SC1u2vRO+E4zkHrmlHYdaSFvvpY2HBEq5hh4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SA6ojUPfl526HnBNiwWWY2UJ0nVH9WzGAtCH7H9M+fJlnMNFsZFZjWQ/7cBx1vlE5
	 Jfayf3gxTblXz+eJ52VVja02PEDTQVMKbS1heNERSPpcOS+pA8QPnvTSCEQtTl9Cg6
	 AW31KiB0AYh5n+LLThoof5rDQWuKv6iRJeRYbw5WowILf8m4bvnK1dSv+qLBGs51Ge
	 PRzec0ruHCX7iEiwv9xPbtEJkkED5hhPz9JmqTHD/FuB9BBECiZhzAjwu2v1px7Dz5
	 QHovEK/6Kon0DP+VZq/bwm/YiU9kuvzSe4qawI9pt6DNM5GJvwYu/1iAqZayBKZ+xy
	 dzEgiIbqetDCA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9452244aso28070371fa.3
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 03:45:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8MujfRWgIHZy8KSS366wKGaQoxSuc4SJQ/tys9yFDLlUcXNIsPy97S5PX8neLklO0tGb2QIEWihH+tIEJYLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcnGfvGZuuO/YtPuvpp9GQPkApMOidk3v2Ue2h907Exm7KEny
	/1p9HWwU4zFEG//Mw8Oqu6MpV0KMj+stEsZ6Lp9KsXQsyUNQRCShhrdxzHU58EEmgPxAK62wHlU
	kYSeAXhd4Rk7lwXaka68lE78j6aywupI=
X-Received: by 2002:a2e:a901:0:b0:39c:828a:ec34 with SMTP id
 38308e7fff4ca-39fbb2571bemr24971391fa.17.1786099544551; Fri, 07 Aug 2026
 03:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
 <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com> <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 12:45:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
X-Gm-Features: AUfX_mwGobwH_Vd0GVJdlishRE0XEvO0Hm_QGJoSWSEjHKzMgcqYHjj1gCQdv4A
Message-ID: <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Julien <julien82453@gmail.com>
Cc: regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:58=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Thu, Aug 6, 2026 at 11:55=E2=80=AFAM Julien <julien82453@gmail.com> =
wrote:
> > >
> > > > Please try the attached patch and let me know how it goes.
> > > >
> > > > It applies on top of the current mainline, but it may be adjusted t=
o
> > > > older kernels, so please let me know if you need that.
> > >
> > > Thanks. The patch seems to be working. /dev/tpm0 and /dev/tpmrm0 are
> > > back and a command like tpm2_get_random 16 succeeds.
>
> Please test the v2 of the patch at:
>
> https://lore.kernel.org/linux-acpi/12954206.O9o76ZdvQC@rafael.j.wysocki/
>
> The v1 had an issue pointed out by Sashiko.

And there is a v3 already:

https://lore.kernel.org/linux-acpi/12955541.O9o76ZdvQC@rafael.j.wysocki/

so please test this one if possible.

Thanks!
