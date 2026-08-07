Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5F3AD525
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105610; cv=pass; b=muvHVAKdPMdkKfR3GUfO3W/Yw34jLTgEq9VJCGix20CLZ0tt86RkEgs8ApIhI66UbY4jJZubwaa94LyTYmnaBMBUElVEdGVm5QfXHaJm20cPimQvKbM3bSUQ4ri1KSzqjij0S+/6VQDuvUNrgg2OxwiL0Plag29UePzj1GzYhY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105610; c=relaxed/simple;
	bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnB4xXQXMusMTxDac8Mvl4l4cTGy6yuKOs6zNB8vsVgbpzXmEy93+VZKec0he/PQopIWaN9p9MNyUBToJKbXmSt/O3LF5X8WzSCqiuHw+2pKWVuPzFt7IMjwvV/Hazv2StjWUMBhCnnjEkaybXNUAlXKvghwNZjWS2J9ZpqM/XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8SWpZd7; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8SWpZd7"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-667bae10ba3so3863098d50.2
        for <linux-integrity@vger.kernel.org>; Fri, 07 Aug 2026 05:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105592; cv=none;
        d=google.com; s=arc-20260327;
        b=A60RPsOsoqjoLW8RaqxbvYiPWaYLps1aVCRjnKTeU9jlEoKgUWCfZO4G7MXYILj9CQ
         GZ8rROJEtDArycdfEYBKRsLj+gX71Y7UIrJxfWqrGNy2R7MIa3pdu6fJncnkvG9RoVCc
         /BmTHYWxGyMPDBwE6Zo646aSemOQ81HogdDqlOg3oX12z95U/wT04kHp9Z69heTeWE+o
         NGSXSB1FbPUApDbX2wYPa5KZfm8xAPCl/wvR0/Pkcc4FsStB5B5zs6BOJO3KBZT1TPNd
         TpDmdHOnu+DzXDPtZu7VEi4sNMneUEZk92hUk28kAB34bzE3ky4l0B3h/S5ClvEGyD1H
         6x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        fh=bnb66rLuR9xgJZwGVvtayClxiqDL1E06teQ36K7Cv9A=;
        b=PGZGgD3juIFTeHXjjTvW0IilsGMPh4oo4JaryFujXHEWQCb0Z2CpIAx4qQtBqsnM4b
         wWAd7C7cWAL1LQIed3WcZ+7i8WzxP4R9S5JzAkMyFdrzcQQDG5YYOip/wghYt2dlWLjK
         SR4e/5TWZH/xpFQgpJ0RhIpERxyic68nVYe6ar5GeLi+3A8b2+UXfwzHAMyabdtUtcys
         n9+TSUS4+q7uoEobNixMp2IJxgqwhh5rdGS2PFyIIaoJGFNDjtvH3aLqNNAF0Jfigf89
         0SrnjHZIC5wmp65ZFP6y1u0UGn/w2tphC5O//xia65ikLFnsiNmQWtSfd3nB2jnX30gm
         404w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105592; x=1786710392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        b=m8SWpZd7nhaIISJO3+HGxTjY61jsrv4O/x4AWRcsdOvIjXixCEMCDE2wOY/RX0Fs4w
         SJrAoeIpieFFspyLBBK+mOl/ldTnmqinaQRjoR6f7RS7MAPv8X49ezxb12DsyskJEBB/
         23b3T7nb8DffrMWmOYthFOerCmXKmmTIpLqPRpW+37B+NFvKMBdkpueo8424Q4/+L3Fw
         0ud7b9YJbQoWL6E8Un9UFwsooXH+vDDqORIp9bszbXBH+WBTK/1gvHkuvcnODUsUCj7M
         7SM30KNq3K46rp3VXdntQ02WpjeusDeb9SNzylxflie5a/BD5ZzoC7uOaIkAYqopq79s
         YX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105592; x=1786710392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        b=De11ksk4udiG2YZH0lsNDSCMxIqjU/TZjwfkyLRtzhHJy4x0zrgUnjnXcJ4S1vpmbk
         4d1qFfEycc0QfXy1rR5DdhGLI0B6lFEp2hL2d+L73rBhc74jgCFMP6IwGvm5Z8Na7dPV
         We/x4FXj9Z9SNdTfV7ubPSW9njsv8KhZdJMmktX5QaoLZvyKZRT3f4V6whxf7AVz52/O
         GcC+rfdB6izc9LbHcS91HTX7D7LXdIxLUXyl9gbJsgE2BuQ/4o263VVs5j1FgtkrqXRy
         3xJosXl/pjFPyBiwMSHsaLmwTYkoWctGNb+wvCMvP5GM+LI84XvmiKFDlNtpdjIX3VNe
         JAxQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmqHKPsgifhgACCCSOivDIc8bwb1r1GylOzjzvgA5KfbdtRejI4GEM45CvYLSBXeXTiAcSQvgaOqrznwaJQ2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc81Unf1dDYBUuoQBiXfovY2lgSG0y0JaGnq2LmM0YhMhYfB9Z
	XrZbR68YrBHOqv93vubrv4c6OgSpO1WHI60CKhxmKlI7j6sbrTe0vPR2Et5fvvi2AOYwnishC/2
	r9z+dN18quZCCYe9XVu5c1jkg8jNdi64=
X-Gm-Gg: AR+sD12eDplYCUeDmA33/Ri8JY2HZNxKP/0qpRIZbxwaLLk6gRZtr45Q+7dLU8NWVSQ
	dovTy0CVTswDOVVa3lbbigTrdDGxUqBNwrJTmABTz+dIIcYovcwQsSSNEfwUjbH8dem/3cKmcbf
	B/4EdJkpef5+obUdc4cyoU3wLpwMUAgHwUFFvESuT/kUJE/2/CDVjdpmajUe4aHpUddqQbCXKv5
	rVRgPtzzHflqJNxt+YFnSncqFvgxMiTul3aKZRlxoH5NQ8cOzTc0u8Glt9L7dMipLhWlqeWJ/rC
	m1TM9bdYErILqO2NO38eLIg88JUh8wmliKbHD+zCML+Wj6x8jjJuIvOlRShy0Mgp9JeSf20LK4s
	c5Lte1TkQjjU=
X-Received: by 2002:a05:690e:480d:b0:668:90cd:8aef with SMTP id
 956f58d0204a3-66acd2f1bf7mr1336478d50.25.1786105591669; Fri, 07 Aug 2026
 05:26:31 -0700 (PDT)
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
 <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com> <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
From: Julien <julien82453@gmail.com>
Date: Fri, 7 Aug 2026 14:26:20 +0200
X-Gm-Features: AUfX_mx9S7wOi18myqNhYzBSITOrslEjXCrKmoDPgcg1jNxB3zXGDhsWm_H5WQo
Message-ID: <CAJOGg3wZvftfk-hZ_wXBYnXca9gf5ziSo0Uh1BouYvzoEyEVrg@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
> And there is a v3 already:
>
> https://lore.kernel.org/linux-acpi/12955541.O9o76ZdvQC@rafael.j.wysocki/
>
> so please test this one if possible.
>
> Thanks!

Yes it still works.

The logs:
MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
