Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2563C3C0C
	for <linux-integrity@vger.kernel.org>; Fri, 28 Aug 2026 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895424; cv=pass; b=Evr7SbHtPoDXFzOOlu82H37i5bF2pnpizd378r8R8pamEO1boOjoH6YRcvQX39o0Yyvbpgt39YRwCiA/5eeZVzYOqowEpQXjapvzTZbKC5x9zk7UHQgEXD9fah81371m+2Dqas+vjWcvD7ici6trlNpxw/fJ5IKH9KokS0yDauY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895424; c=relaxed/simple;
	bh=F6974V1qqhjB184vkuvnv1K9HbL/klGkmFP33fR4nEY=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=qQL6RVNkdPyOIfuhbqBhdxIVlhof/bcF/B4BhaU0XXepKJWqtEk60nzxGjvLItpvV81KtZCxL6ikL/wVT2scI3olKKXnu2Qg4g1zLqnoqkizsSBF111GuQTd3w0S43YyZwlWVZZNsWM7Vdl7Bt1gd8dl2EPHGMVF8icZmY2kOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=WgtuHzTz; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="WgtuHzTz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so427636a91.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Aug 2026 22:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895422; cv=none;
        d=google.com; s=arc-20260327;
        b=YHT/hf7qxGT4WUusqhsTRp54AMxyD/ZGnjHmfpsqq7FmFNK6Su8vL3+cEtgYkWGAZo
         XQQcskBVE7LJLTJIO4jTNHiKvFQi7vIHLYr1561NC/jkZEhkX5XgFtG+vnlnXTnR19qm
         Y0USOeaJ2tNqbXUARNZi4+PtTb/nJO7dxVSm6w1IqKkCAz8EKUSAMBsFfz616Vt6gHAP
         Dclu8do3VUIwq2fMLBd3VFWfEyiIAAg7z95zuIaFKjK0Rngifcf1zUQb/tiimPbkqL/s
         IogudLb8e0PzFSwBqfqaJWH8DMM7NgTk8rPJaJjLNntooc8n67KqeP3COJ1evMVD7z+U
         q9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=TsyfVz00LthLpZZO0h8zMHmczrHd5U+2H2ML5+krMkI=;
        fh=hrwAvUN1gqrzAAOs31sflHu0THZxBsp2i740RCuD1FE=;
        b=s0uQQWvsdGHCr4dxOUI42vziMaYdJelZ4J1HDSbJUI5TPglyuHquwd+j8MBVXOEtfz
         wZdk0g2SsXYLy4IBxKkfugL9UHMndSZVvxl0S4szIfjVCiSSKR2TK9HyCg+IxtA2fxiF
         cRGySiE+XoyHxuAjBwod27CRqqU9E/PUq+W8ZUAVTIXRRV3mg4oyA1sHDvJniKJ6+XXV
         4LpKiTDjC0uXASzFFQkddOAsLhlSFwNhSJH0c0eG6D/nwJWKFc3lSgRK5cgGDLdz9Xlz
         /+WL6GTi0R225Cn9wzQt10klNDDIpAW3XSs9mWtkUtgtDHwc3nq42nORcszjhYbE14zY
         WCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895422; x=1788500222; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TsyfVz00LthLpZZO0h8zMHmczrHd5U+2H2ML5+krMkI=;
        b=WgtuHzTzS01WzF8n9AEPgxMAcR/f1I6FKEskF+BK1+h7GRHaFpGpaMJ4FL4aRTC9VG
         LN+l0sJuKoaqwal1X0tRrFyl0K2v+qaNmRu7l9lAK4ZHp403lvINCe0KDNyoTcOBkWa2
         bH/jj0EhB+2npXME3BC80FmgPJpnM6lRHAV2UB/wVXRsmnzf6sngvTXR+J9glXxZAqwy
         xq02MRDrJ+iWiVxDJPKmVIz5e/faPonKlEp+ksgMMzx4SEJ5B8+4S0ACKGjot5mRV2nJ
         M5VbJqHo51Gt1vXY20MIQwPYoAETaBEl33F/hKLJI4DUwVRT+N8TcZrzaSIax1AdSRsc
         HAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895422; x=1788500222;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TsyfVz00LthLpZZO0h8zMHmczrHd5U+2H2ML5+krMkI=;
        b=b+Ub+8IS/bZ1sUXo/EuA/qvxlT82BHyBoZg89LPPQxOdyJFav6sKy6W20esYvlZZJF
         pkQir6mhcfZ/ZTQ9DnyNg748CeKR6iVeLVaTpzbtW4ai6dyz6jdSN/iqkbO7VJvA5sMq
         +FNkNmyOn6NkB4jzj9z6HgfOVYlEg1b+j/gS+kKpC2vNa4WDjFXVA45qEFTKgp383nRO
         YtN7kKnxtKwWS57Y3z7i5teRbosUcwlhB9IwNe9PI1GeBC74FiNPw2ScatQmJwaJcGuy
         WoF/NpEXi6ehEaTpPMExMPexVx/7Nz7o3+hxlUM5jjmD+9tzzymXsaLSd9klVoRb2SYk
         pPcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA876/lYU9zM92t5aQ5mJjl6ZzO3pQ2jlPKRcOQtojgaCoYzbUgYe/XXzNRJgpiyTBfILboiYwZfA8lKRWPhA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDD2WXrQnw9v94xn4zMFKltKSm9ZTeO+OwB9y2GZSh3o00Gl6J
	qX6tDi1VqW9OfsPSonjatv17gUVcjzmzL4blTygOaPq9keTiZYlP18kgvyQ76a1zcHgg4zm8fKx
	7PDoAMkFLgAsMXZpE6t5IyUBwnlUJQ0PCV9Ehza9gia46Q9Fa1kjtgw==
X-Gm-Gg: AR+sD12c0i/W9Geplmc/NEk11C9eMa7+uCTneJEu5bC1yLDdmaVyP2hhD96ojv5wxsi
	pBP/Z5kUI7EejTyKr/Hd0nx4no+wLhtQ4RWty1tWOJIhLKxa2oq4OrOlMser4yWZtSHGOn9fYBu
	dvxEzo2USWYa++ynDO+rVgnsmpe/YxZ80IzMYpTrLs8YgiN/o/8zY6lxtIbq+TifrQ414r6yD5k
	HSaue9/WlrYocR3am0L0y/PkUFT8RykoTyl94o52nWe2Js8tIqo0zr7+rf0nRIAYoqm5HS4Zvne
	V+r0fLdVhC2andr+rWJvzzz7XRmUTXwXiZppj9saSEcY0bDZ/5moNP9B4fKKu1OtqVJL7b9y3zP
	vIwARNfkEYOUiy1obdRZph61DWAWoZTRV
X-Received: by 2002:a17:90b:440d:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-396d0e5f35fmr7652756a91.1.1787895421337; Thu, 27 Aug 2026
 22:37:01 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:37:00 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:37:00 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:37:00 -0700
X-Gm-Features: AcwNN1X-Dm9Pq93nwXthj_Gk_cu7GiCRwHHlNBoEo4XihKqW7_PeohxdvRfPLms
Message-ID: <CA+0ovCjBrrU0H0Z-fqBZ_mat4toQM_z2=+NC-9ONSXn=bD8mmg@mail.gmail.com>
Subject: [BUG] tpm_tis_plat_probe -- maps a borrowed MEM resource by its own
 size, then reads at a FIXED 0xF00 offset
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: falemi@asu.edu, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/154-tpm_tis-borrowed-resource-fixed-offset-read/

  BUG: unable to handle page fault for address: ffffc90000a17310
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:ioread32+0x1c/0x80
  Call Trace:
   ioread32+0x1c/0x80
   tpm_tcg_read_bytes+0xec/0x270
   tpm_tis_core_init+0x48c/0x1830
   tpm_tis_init+0x420/0x540
   tpm_tis_plat_probe+0x118/0x1a0
   platform_probe+0xf9/0x190
   really_probe+0x267/0xaf0
   device_driver_attach+0xe0/0x1d0
   bind_store+0x1d0/0x220
   kernfs_fop_write_iter+0x3af/0x540
   ksys_write+0x150/0x270
  Kernel panic - not syncing: Fatal exception

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
