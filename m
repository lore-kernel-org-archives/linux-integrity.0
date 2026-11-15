Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754850;
	b=xU9zeCPwTsAmqvXPRhwO0mS8YqqebY8KHWx9++JGX/15oCsIwisSe+SVHBng+XKdeOVz
	 zIsPM39liiFEfXOUq7zrxV+hYPCuY9pv8JZ4suMzwHz0A2BvN4GmUWPChCszrCiN3dRTE
	 aoyhRUI2qXESBk/G9UMuJHMGZASFDMFpaSuQNPbsc2QlkYYB6/mpdg1wVv6Dno9dHGLTR
	 0r0Zqu0CPa8+Q1zrJ4Aw3wncLm21JI3H9OJY9dxQZa6XCondiOhrRap2LcSH3k8EvD2gp
	 ISLzq/mB0c5HZOTd7kYzcTnlsiZHWN+SJCu/430ZMgkqKMG76BE5lmLUxAXlBKzStvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
	b=0d6DnBjU/M/vICcNRCktSaOln8GCpjt08L4sQPWEnMjxYJoPhqDI3OQ0rzC38tOz9C/9
	 bx4pm6CXj9+inWJyUSlmtRlVlIg0Ucy+4CXLGhhfTjU/kOY28nSBrsDiGdLRuawLAvmAx
	 SWcfScj5QzEggIxgdFUrDgcbo1KAY36BNZ95bbtOIhcT1xKPnoxoeOAr8pXlyNl0pwyGu
	 tOQN7k+IXcN7YsNY6N11lWPEnaBOTRUyhj3QtVh7YdEJPbsRFrCkW1f1F4CyTqGzM+DNq
	 dYcscooWcX+mcrmKCce/etQeWQiQYlgJaCiY2XXVTFRaNzEArIupX3EK/01RRXkFTQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D7606A329
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 15:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 459D7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4395d31228so439662666b.1
        for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754849; cv=none;
        d=google.com; s=arc-20260327;
        b=rgU+0Jj+lK0rxNXHkHqMMt0BxCp8aO1eOKySQwQ52eIkEe4F1A6UEJR11LkBuu6Di8
         8wCzLNhJ+6qOQvVm1x9xQQwmIBua0EC7IQD95VGK7ujcsN04CoYOE0po9+2KQcHIFLkJ
         TFhomfV0rh0FutHqEeVA78scKCXS7l/4UWvPumKedxCUEtfF1CTp3CcsuO52yYbQeJor
         G4/K2u7rIqwGtRHO7zubZwgrFOXVy7f0dXV3kqA5Q4O6ddxrqH5z5czxjuZ4wB9O5X5g
         8cymgv7NJaahO2WH1mkNPCz+I+RsHEwonA6u6iXEUkOTU+YurUdU2CGcBKfTRk4ZC7kp
         tM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        fh=fzokn+ZuqebSDkeXvU8AL0pQZagZZysaBHPSd9rn2Tk=;
        b=GQXgduZ2BwkjkmUc8W13fQw3SZLlCrp6wq+yZU7g3GjGT1wcolea2HYS0goJt/QBrO
         llOU62StuFdQ1k5V4E6oNDr0ZzNbypTq5kVoqAvPFfkIxvEyvKNihQXMio6a17nGH//8
         9aaUV1LqrJTvVgspCTqePZ5+ls3w9l2euuTVAXfK8S6ZLdpgFZKI6SO7HleZOjq+MOBF
         OnLCQakq8hCcjKDz2NXRCBdJCRybQAoJVpkhw15+nRdQUbWj82ovCk+WoRyogM11ZG/d
         QMLs0BXBBll68fm13ooBGTBtU1K5ldE52u/rNIOH+YNREdTOEN6uZTuFe0Os7K2BrIh6
         D1mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754849; x=1795359649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=SHyOkxQwYuLtL0+Qa53+jCNHfMYZrDoIhK10usTnr/SPlsQtxy3DYcaURrAaqZRP6p
         j9KX2LwDO7WvpxAFvRbeGvPMOpBnbsJEvuh/a+pWnWLMDcViXZq6b/VVaPZ68EhpaptP
         zHr4LucIEpdLZQDJogd72JZdMAkBHyXTxsReEVunL/+oJmqoO/hXoqxPt2Qr8UINUk8W
         PKisRAodcZl5vzpIsG78e9fRi2Mkv3dgu35W/QqWyi6fF9QsZX61BfySIbEHZ7oFXuQb
         7fuxV2YOwjcp9LUN7zRZYNpbm5Ey2kJzr2xgJrjMsYP1vCyRno2ESPfdF+IIuftfMTEI
         HtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754849; x=1795359649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=WfV5BpAgUg/TjXlga5s3LXRq2NC2dnDTTYqBLDDS7Q1UVnYTKuyu+DziY3HvH/SuuM
         fVefn/ndf/ogl2X08EPvpWMfaGXEbOJ2Ez1RD70p6xD/KbqEmupvkxYEhAyaFfjuSEPo
         iQUkeMY+VVGeRj1g727hc77L/qLoy4sCzyYAN/Nl8xxv2lnO2YFqPL7ymDcuEqGsOj2H
         /5Q+mcwZNn3mqOtlkftlcQ3mR2eC6wFvN16j7jifXV20PRRb5+mQF9zrbV124F/Z7Msp
         YgJg78S4Ve0Sb0Wk7Q0VIRHlrUSt9aywenpGovQkLawnouGBplusluFSdlGUzJcsLRIB
         EpRg==
X-Forwarded-Encrypted: i=1; AL+hErHOUW5OqRArPpYDSBR10IEkFgM25T1kfoHFfO/g70ftvHG901l77uIYyAkK7L/SRsIF2eoqhuHmS7OV0EAoja0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4iZjBm790eQrXG8gEDKNnOoNOeuEbilZ9hlmKXkA0LXEv5h2O
	EkuRmKmW2ewRgonkic/sBu0YDTOGD+rOEGh8384STPIWaLCbrrenb5r3AdmExGNEoBA23AeTcy0
	96FMWDR/wh6YDWcA8TYS09BRVZSO0dO0=
X-Gm-Gg: AYBFou2A3mAXsFBTFQfYCalaWkTXlySRybA523V00PYJbRmZN+cUZIQ5hM3Jl96vbCK
	cOatuziQlB7W0RfaWm4yyVgNuc0wSNi+Jafjq0vykKLLDczcEUP74MUOoaYolWorbzyk279jhsi
	OhFiJFrsu2uXtjkmylTwFV5nzO3lubq5uiFhhJEIBapYpg8R2ySdTS/V8y1WRKvJyzr7rquunjB
	DBtX77NW0dAoQybcUaGw5rG5HdbtnCestPVni0KCNCWE2Tli6awRgdjd/mgjPIFQZfnlwN+ImEQ
	GEpkdDQkSulpo8016h2CTMbchsBMQSuxs/0x1van13dSoQkb1n09Xi1SpMjRxqt61i6OT6QnN0c
	YvWjhGaBZf7nr8a5Mf2iIurGGDv5CugftkC8SKNDrtUwSH2fG1urBPDVKAKAjIbCUaZm02Q==
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c509612a23fmr694079266b.6.1794754848470; Sun, 15 Nov 2026
 07:00:48 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:00:36 +0100
X-Gm-Features: AclHuK_wHYShIpzO3KRe2QttGftKj9EtJqTGjYXExDCpgXdtVHvMQ3jGuPVE7gY
Message-ID: <CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+3775xA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and d_real_metadata_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).

About those promises...

>
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>
> No functional changes.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/dcache.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..674bc50b81827 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_DCACHE_H
>
>  #include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/math.h>
>  #include <linux/rculist.h>
> @@ -660,6 +661,49 @@ static inline struct inode *d_real_inode(const struc=
t dentry *dentry)
>         return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>  }
>
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return d_inode(=
).
> + *
> + * The union/overlay may have to look up the data first. This can sleep =
and it
> + * can fail, e.g., because the data is missing or because its verity dig=
est
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an ERR_PTR() i=
f it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(const struct dentry *dentr=
y)
> +{
> +       struct dentry *real;
> +
> +       /* This usage of d_real() results in const dentry */
> +       real =3D d_real((struct dentry *)dentry, D_REAL_DATA);
> +       if (IS_ERR(real))
> +               return ERR_CAST(real);
> +       return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return d_in=
ode().
> + *
> + * Unlike d_real_data_inode() this never has to look anything up and so =
it
> + * never fails.
> + *
> + * Return: The real inode hosting the metadata of @dentry.
> + */
> +static inline struct inode *d_real_metadata_inode(const struct dentry *d=
entry)
> +{
> +       /* This usage of d_real() results in const dentry */
> +       return d_inode(d_real((struct dentry *)dentry, D_REAL_METADATA));
> +}
> +

Wondering out loud - since you needed to change IMA anyway and need
IMA patches reviews, do you think it is hard to also gracefully deal with e=
rrors
from d_real_metadata_inode() and not have to promise that it never fails?

This question is not intended to block your patches.
If there is a reason we should keep this promise for now,
I have no problem with it, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
