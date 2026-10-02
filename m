Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12404390223
	for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952298; cv=none; b=m8657ck6BVDSEGgX9fdZQXif8V67SBJOskZBhoE/lYwLC3vmhvOM9x6t/CeuxgWQGTaQgR/8GYytNdmyEEF/mL2c6wp/Sj64pgEGkWg6RbhH6ItG1KsnH0IkbWE2GmBgL/Q7GehTfLIcrGu9mrf/Yd0ZISeoY6CZxuuJl22ZoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952298; c=relaxed/simple;
	bh=GWsyH6hBcwla1pNANi7ebFerp2rnqJQcWaAcfk29BGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SDyAW7qS/9UxsdPFFnaTN87KL7xrQMPzOy0faxcA3YiEZJN3y/3CmEqIVaM2dmcS/aJG1j5/bunR/2sqb4bvMeZn1wwyklilyJE0ssuWxnGiwQyLpLg577htXDSVYC4hA10C4Ek1uCzDHDrpIyLbmqtvutlyo+5dNOaeB51GPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slKklJhJ; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slKklJhJ"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6af9e2ecfbcso1118011a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2026 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790952280; x=1791557080; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uhe1kjp0ioHVkkyq0x9skUJJmlCnM0ROQqvDHAfjDU=;
        b=slKklJhJ5Mz6JlUDJdZ5fjGNKZmbLzqI74q/KJYfQOjhfdNuN/HwC9mIMI5iDGEmhK
         O4QG+kNT4EsbKM7LxMbDmhQzoATYtWNxiHOY61sou6d8YfJjX/K9JsfQntKThWp4OpJh
         4CtbnKNprEHRhDGhquanFs1fb+Ir5CiQEI9Z8cci2oTpX8M/LmucUv6ySnNPzoyW7Tjw
         aqVi/QktktXF5lgLaZko5Ly/06ucSOvx1TuZ/Ik3u3T1eBj/sx9TLe7RiNTW8p9fJyvB
         Rv1ZLfXJ1YaZd4eWr3uWGCvaSMK3x9OwLoKs1oLw3S5boEGHTxE0yF2ypl/od8MduYIl
         wZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790952280; x=1791557080;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uhe1kjp0ioHVkkyq0x9skUJJmlCnM0ROQqvDHAfjDU=;
        b=B5/BJ8nd6IOSU9s/VOh0gqQ1vWEOciW7ZkZKQHDdPZhPcA3ir3KGzW7C+CBGKH5a3t
         R584HY+URCdT/GTyuLqCs5K03wpyWpIS/ApWoAurz1rlpRZ17PrFrKGvasYX59UrGc9m
         dbCjeY4uLl5aKQSFFAYbYw/hg89MB24TQNE3IwzwgYpcmd87rBe4UXxwRFrshwDMUxVL
         qUaKt1NOpQN624iIHuM8yWBDnxMOuvMoAwMoqBPQWx6n8Us4d5H4bf5L1u4I9SSPFiZt
         b0HyMHkbe6RWMKSw3+rJqZgaOTeZiqR/O0/FaL/jAn2F/ZIJerq6wIWIlef8fGGP7nPB
         irag==
X-Forwarded-Encrypted: i=1; AKwUvBzBNrldG0KXxXa/3PzEzwKCH9YsfxWD10UhNeT6DSiv5jOyZnv90sFpuWgKxwo45XQQfosON1iVgS4bbTE78Jk=@vger.kernel.org
X-Gm-Message-State: AFuF++lLzwRvryZEEFTWO/f2vXsi5FhICNjlobErkZU3wd2xlScqdQXT
	AzpUOeWdr8AF8zAN+yWv6SRMVrRIcqDb1UgGCxLvoBbEug8awS1Mv1lz
X-Gm-Gg: AYBFou1la7plTzI31eXwTB0S5EE3krD5kw9vTzoDC//b8BgKKIF3jKYKi2nrE8ArT+A
	ko1ntTeKX+7VAeQVXOeYVmEnF1WaX3w6upthTIYnxdPpShD75LY+lmauZq6nAxbbWofEokJDlAj
	5lO1AlsLnW2lzm1l2LDoTJ/NV9BsvJQ3VzLhz6WBaVVC7lZ9Mlfwz2XJFegYRahXMaKolt7x9KY
	a8Ex+kxlB0A9ID4j2a2dEooDgqsXMzEgF4e+DacIPA1i5NH81wQB89sM62SGMyigvZPEFttbjVh
	CHc3cSD/wun/AsIam1ztYZa4CuzsYQiE2tFcBNZ2f3jc1L0L6XKBvCgaZZtaySatFYRmGBXOtG8
	RxF9ou4q6sD+k6+BtvDgxEkPfDFiPmmN/ppK4/ejBCtfd/uPh1ozb9Ir4b7E9SzPwT54BPbAr5V
	tzVgfy8cdRsK7pGjUuDPYT7JZ36B3DZzI3Sps7GBQjpCZOMEAvmAJ2vSznFpG1bEgBsQU=
X-Received: by 2002:a17:907:9346:b0:c2e:4627:285c with SMTP id a640c23a62f3a-c2e4ad2cf15mr246398466b.21.1790952280011;
        Fri, 02 Oct 2026 07:44:40 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cfa6dfcsm92846166b.72.2026.10.02.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:44:39 -0700 (PDT)
Date: Fri, 2 Oct 2026 17:44:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] tpm: clean up error checking in setup_ring()
Message-ID: <ar_DUjuGv-9vPzga@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The bind_evtchn_to_irqhandler() function can never return 0.
Historically, IRQ functions used to return zero on error, but then we
added an architecture where that was a valid IRQ so it went from being
an error to being success (but in a limitted way, just enough for that
arch to boot, I guess).  Eventually we removed it and we will never
allow zero to be a valid IRQ again.

The problem here is that if zero were an invalid IRQ then we should
return a negative error code but the code returns zero/success.

Change the code to check for negative error codes so it's not question
of how the zero should be handled.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
From static analysis.  Untested.

 drivers/char/tpm/xen-tpmfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 3c0cce57c4ae..731444eac5f2 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -266,7 +266,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
 
 	rv = bind_evtchn_to_irqhandler(priv->evtchn, tpmif_interrupt, 0,
 				       "tpmif", priv);
-	if (rv <= 0) {
+	if (rv < 0) {
 		xenbus_dev_fatal(dev, rv, "allocating TPM irq");
 		return rv;
 	}
-- 
2.53.0

