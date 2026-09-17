Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9664E73C1
	for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658263; cv=none; b=t6HlK6PHpeexm+GzRaBCLpCXulB1nVraTibPW8GXvrhwyfRDBYl597X2INk6o5PilPSSyInvGG4ludva3EqomnmPBoLXWlcwRqgf0w76XDCm+5gqAz8YlgzTCDKeFwGe6y+IwuRQedIC5OAiONYhDAzaIF37o3B7fkKqHr9cC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658263; c=relaxed/simple;
	bh=yokcjFoYaQjb2AXJXwiS2CgA9icNw4hd0m3OmDjYLh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX1cx6+R1jOaazU/2gcBlDW9golcPYPMlKoufn9iB2MnHkEAB5PliQpTRGokD/fVpgQ4JCGK/wajFKgD3gXw64Bdi3hC5a4whdsKH/k6edbm6WxoxdT605kq3jMPzIaoFguxVF+RB+OHxb76SHbJbHEckG5cR6QxeodhoC7gTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baYHiQhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baYHiQhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B01F008A0
	for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658230;
	bh=yokcjFoYaQjb2AXJXwiS2CgA9icNw4hd0m3OmDjYLh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=baYHiQhLKHIXv5JcbsYM8h8jWAIdy60s6NhCh0ZGU54W95BOiAuC94Ol2AcpHo47g
	 xOJkjhXStRdOshTWhG385se+mN0mwxSalEgzP9JG2PQIOLJ/oHEIVw0zHQeJ6cCyxv
	 qfvHypAZ4Aa+PBTDs1xGLwk8gxllOPs9TBclUTaLcaptPXVE/nH6o6dNw9fmKr/Ga+
	 euX0r0XKcn50B8jtWh1/A5rkcHzzpSCbjKD97mWUlLgkoyhoofyCpgqfsFLMmV7xqx
	 ARc5Jnmu7agtqFNmn3zlh9R+1V4XybdteMzm34GCd9fCbp5oeKdHFvfY4O6Spsy5NH
	 56pQ+Rtftr60g==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so1792385a12.0
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 08:17:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYPVN8SbPNQy6u43wtoalpVwkgTL8qlYshyp0i7ifT8FyZLSo8HxTNL7BpeM0waAvCUyfHlIGglF1T0KQANcQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ka3TqPu2++G0ELenzg/k4s/s/Nok9wR/jUY2907YjUtYqPibQ/
	iPVCwKcG21Vcb8Yagyro13QYZeMcOD40EYHQrpfQbhVclsaEPsstREsIEf8N3T3kehpV8SrnIET
	IKgj+UbnOxKs/a/m8NNPv/oAB6lThqQ==
X-Received: by 2002:a05:6402:460c:b0:6a6:8dd:c76b with SMTP id
 4fb4d7f45d1cf-6aa22247992mr11552271a12.1.1789658228391; Thu, 17 Sep 2026
 08:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917144134.459819-1-matyasdaniel006@gmail.com>
In-Reply-To: <20260917144134.459819-1-matyasdaniel006@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 17 Sep 2026 10:16:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLyPK2rJVAyzCtGtrBSTwOKRZ_EAmE1Xd++9DFaxrrmDw@mail.gmail.com>
X-Gm-Features: AcwNN1WrkKsI-hJClnXnbb72poP7rLqVHTc23ccK3T-HSnvYyjsVzuH4L2tWH2Y
Message-ID: <CAL_JsqLyPK2rJVAyzCtGtrBSTwOKRZ_EAmE1Xd++9DFaxrrmDw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Sen Wang <sen@ti.com>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Dharma Balasubiramani <dharma.b@microchip.com>, 
	Jeff LaBundy <jeff@labundy.com>, Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Atish Patra <atishp@rivosinc.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Dmitry Osipenko <digetx@gmail.com>, 
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>, Okan Sahin <Okan.Sahin@analog.com>, 
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Ricard Wanderlof <ricardw@axis.com>, patches@opensource.cirrus.com, 
	Lukas Wunner <lukas@wunner.de>, Eugen Hristev <ehristev@kernel.org>, mfd@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:41=E2=80=AFAM Daniel Matyas <matyasdaniel006@gmai=
l.com> wrote:
>
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>

That false positive is fixed in newer versions of yamllint since at
least a year and a half ago. There's also some other quoting checks
I'd like to turn on, but that bumps the minimum version since unknown
checks are an error in yamllint.

> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.

If we wanted to fix like this, we should probably just require block
style everywhere, but I don't think we should do that.

Rob
