Return-Path: <SRS0=9k+n=RM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3795C43381
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4EB206BA
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 20:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvoJdzMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCIUtE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:49:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39623 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUtE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Mar 2019 15:49:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id e15so795510otk.6
        for <linux-integrity@vger.kernel.org>; Sat, 09 Mar 2019 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w3AjnNoD+MkoICM8D1FUgYaBAr3Rbezmsd6GUNegJEA=;
        b=kvoJdzMCxux6fBzeURRM3pgGYCoIF1CpHLCVSor1se56+Yzdfe+Rd0gXZImBoCrOU0
         Y1Pp9l6gDRlv0l6MX5D4n++lflh7hpmLDiEztcEHpQMxnf5ViPtNi5Tw67p+Lzz1vGpC
         fkcOXXv/u40w6yfVZZJlYfJgScxpiAe6MZTBxVUVIdPYzuIdbWsuNP/cGD6jIYe9vRNX
         8et0Fj5muStD3+pHnZUFBKkQAK3CwiDaTYRm5G+dVxHK9SFoJxhxGAvQQOXGAC+PoAFo
         OinsjmYrE1hrqxcaxLHoNoF1kPDdY2m8GaTVyT5dLAQ5DwYipA9ClF6I7DktOHH943MS
         ECqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w3AjnNoD+MkoICM8D1FUgYaBAr3Rbezmsd6GUNegJEA=;
        b=UbiCrCWTk2UjeuR5bZhL5IdF8Y8qKazoQnKtlsSRx7M9ub9wMEIFnSiYhBR1s6XUJG
         /2Mepak8gtorFwzYaaudsJxfaXV2bqE/dghJIH88hf7M3NppYSd4oVXSQqE6ULl490dk
         CzSLaecTSPb41lJsLIT1tPDikhyMopHEINN1Ywe4uwFG66jSBZNNWilBj8fIs7vfS2oe
         gl61eaPnX6QP43U0L1eZN5Iex0w05OV7vsXvKnLaj4bHescqvdfmP6FpIlRl9KlRmreU
         BeQFMaarUyy9FjXe3h9vuXZMvJ9BTOTBFRwwfPjagOQEVDR0LvvDiAaqJP/O51FIJf7c
         veHA==
X-Gm-Message-State: APjAAAURI5vF/fodKdE3DKXARYj6lxZozccODY2KF/RZpqBMoTBPO2k2
        ZGmBvnifIr21H5TRYc5NSkrbyg8ILGZqpr4BakEetA==
X-Google-Smtp-Source: APXvYqwRWLUfb5kUMhcL6iVEp4S2CYk/URunF2QERkbcIsu1zZ0twQLBZYxeHFO8hT913BwqsI+zVuM4UA9XoaEwcEw=
X-Received: by 2002:a05:6830:2118:: with SMTP id i24mr16440434otc.224.1552164543209;
 Sat, 09 Mar 2019 12:49:03 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Date:   Sat, 9 Mar 2019 22:48:52 +0200
Message-ID: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
Subject: Kernel 5.0 regression in /dev/tpm0 access
To:     linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello, I'm not entirely sure where I'm supposed to send this =E2=80=93

As of kernel 5.0.0, I'm unable to use the TPM on my laptop (HP
EliteBook 840 G4, with Infineon TPM 2.0) with the current version of
Intel TPM2 tools (tpm2-tss 2.2.0, tpm2-tools 3.1.3). The tools =E2=80=93 e.=
g.
tpm2_pcrlist or tpm2_nvread =E2=80=93 sometimes succeed, sometimes are unab=
le
to read anything from /dev/tpm0 at all (immediately report an EOF),
and sometimes are able to read part of the response but stop halfway.

The problem seems to be caused by commit 9488585b21bef0df12 ("tpm: add
support for partial reads"); I've compiled 5.0.0 with that commit
reverted and the tpm2 tools no longer have problems. Investigating
with `strace` shows that the tools frequently get 0 bytes out of a 4k
read:

[good]
write(3, "\200\1\0\0\0\32\0\0\1~\0\0\0\2\0\4\3\0\0\0\0\v\3\0\377\377", 26) =
=3D 26
poll([{fd=3D3, events=3DPOLLIN}], 1, -1)    =3D 1 ([{fd=3D3, revents=3DPOLL=
IN}])
read(3, "\200\1\0\0\0012\0\0\0\0\0\0\0h\0\0\0\2\0\4\3\0\0\0\0\v\3\0\377\0\0=
\0"...,
4096) =3D 306

[bad]
write(3, "\200\1\0\0\0\32\0\0\1~\0\0\0\2\0\4\3\0\0\0\0\v\3\0\0\377", 26) =
=3D 26
poll([{fd=3D3, events=3DPOLLIN}], 1, -1)    =3D 1 ([{fd=3D3, revents=3DPOLL=
IN}])
read(3, "", 4096)                       =3D 0
write(2, "WARNING:tcti:src/tss2-tcti/tcti-"..., 97) =3D 97
write(2, "ERROR: ", 7)                  =3D 7
write(2, "read pcr failed. tpm error 0xa00"..., 34) =3D 34

(Interestingly, this is very difficult to reproduce under strace, yet
almost guaranteed to happen when not being traced. It almost feels as
if this is a timing issue?)

--=20
Mantas Mikul=C4=97nas
