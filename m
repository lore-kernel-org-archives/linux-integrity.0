Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AC3F9FB
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875092; cv=none; b=dGGjDgK7g4oJrKY2PepIdkV+HdRB3dnNf9KHXPALG8U3jF51l1jRcuJ+kx5rncepK1Ag9H1N/fTGuqEZGRGuHsuOvWg1H4HVr9uE0rpJW/x4Yy/JpQ15azYjSLlmBJgAVTwQvJVnooG40225fZ9lQ6Q+PgHcRaMBuqOeQVPNpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875092; c=relaxed/simple;
	bh=2Jg+aOfLexsl4IhrEflsYtUIJytswVTro/wp/06/3xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rat4Z9VDMBtx9uPQzplX5LmJYJCdvYwXaauZDWZxZqIkrF14HO5vEiEttBq5Orl2rhEm6vlkYjkk/BeAbmzpRSdcXJQN9hwXeSXBqVn5FuJ0476fxD+lY0HyhDJ39WvwCJ3jYPran67QouwtV5agJ5W7dCKoJpQL/Vxwl+YWGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZep78r5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCbH4K74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZep78r5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCbH4K74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782875090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=;
	b=OZep78r5E94HhoNIh5+3YWq6USO5nPf0+KN7AUkPJRwB4R/2g0c1PoVEYIOw50F+ZKJTRt
	8gxce4Cp4RfFgIZ1RDN8O+UP91KGGokrKYx+ZBk0F0vIRjA0pRaZSDHmv+kYOhT/qTv73g
	hIbGzsEaDL9Ffsa9oHhX46+nuom5UwQ=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-L4SOdSGdOLWYtaQzweqGDw-1; Tue, 30 Jun 2026 23:04:48 -0400
X-MC-Unique: L4SOdSGdOLWYtaQzweqGDw-1
X-Mimecast-MFC-AGG-ID: L4SOdSGdOLWYtaQzweqGDw_1782875087
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137f3465368so429274c88.1
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782875087; x=1783479887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=;
        b=hCbH4K74/QElCmjUrsNRkGuvOylcKuuRxso9f8y/xb/Kpk6gjko9GLrtVsiQdxRsa+
         UN2npYb9zqZ9qw02tT01pNanbTXVRijtxqzl3UFYvaUcf8Ti+PZA2pqokbY2RPymYKwn
         O2fkox3GMK0VKc+AfSUEVqT9lY2JvaKvDwEcvdOQVmHNdGaOFoB0y0ewOBZE4+/kV+Zj
         enG1BibrXJfm2G0HVIXW/QcOy54a62NwcD55aUH8A8qYATWWPHgGGvS2JbAa4nVLz2zc
         jmHCisS4b6rTT5WmymUpZYG+VE5N/OcOw9DbMtvpkUlVuMWnSjnoIbDuoHBpRIyb7z3g
         VO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875087; x=1783479887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCaMYc8eNrfsW+6kx9m1j6d4lfDzKZwvqiqCl5u41Vk=;
        b=oWEACOl4c88/pk16o1SSV+ggvzTTrD6+VLTmhJWD3vveT5A89XIDtZ2mkmtG6fuqFW
         WpZinGJ9+r4XTYdrtmCaPXndG365sD+RDQAreJx6edLy5Y6s4B59O86kCL7AHiYmxgwK
         rCSqTu7RGy4R4ivSLllVD7FyzLZDPlqCcs8ZhcO2w73rCJxWPJyvWgwls9KTTmm60n4m
         0EdmZl6/Hms/cdrxOSFZ9SYNIqbitKW5IWJj1x51qM6/KrtW/NMMwswZv0No6pCsNQeB
         NShHzfdpYS712PKcGu8Ev6Y+myaIzWao8m8s7Dckzaru2rEda+a4RgLBLb4WDpJ75yiW
         HFRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8B3AhVL+u0HeJ4YSPa5ixHhHTvscCU2/AvUGapAylQFd6YINDuhm1PLtPdhzvyVet2T/qj/sjhgyrMgY2VlKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYCsdv+cc0a+5Nkh2zagHPTJqiX2ENVPqUW/myoX+xc9bskL8
	10nhTbKSE9R9j8GVzWXi5ojIVt8gdcmnHan0E8TXTX8KBl8DEanYcLo7WtTkU99T/SX/kINKcOG
	QpjESh3Kx14YkZF63nRU/qslPXxUqtHP6oI0FeBLkQKQe4xK7GVXu0AsytjRgE0ytTHg7pA==
X-Gm-Gg: AfdE7cnKP9olTXJ5WVnvqm4kjP8JAW/lC6hJj00vls4Wmi0sjecEEQ+tRCnCRhWbFWi
	OpwEFBaEqRJamWp/57AZEgUstGbikM3+0AnT1c1w4Lb2n1pISO69I+S5xC5aBxoXOMAeZJ6Zl3M
	G9lmGrf46MzUZMq5IJFObAkDtW0dyNZGCvAUVYkKkaKvj8K+Wh9AKWLk7lD+9PguVBW7MkoaYjE
	pk9osrCr/mDd5tgaciDMUkICY+FwiKC421/sIeTO9i3ZRgJWmZ3zBvyBUuK9l4fMK/VnIUSggx+
	mNFJEoPaV/p1OfknqA+jw99DaH02Xz5l7XjSU3Dx7ybshoYrGjQR6fYUbFXKjQvV1r3L/uL+L1i
	fyxr3bcnWje+sHakwYXzve8IK7fq5UfEanEPn4BzW1QU5icQlOdL1c5s=
X-Received: by 2002:a05:7022:23a3:b0:139:ed5a:eef3 with SMTP id a92af1059eb24-13b315a4cd0mr2248703c88.50.1782875087312;
        Tue, 30 Jun 2026 20:04:47 -0700 (PDT)
X-Received: by 2002:a05:7022:23a3:b0:139:ed5a:eef3 with SMTP id a92af1059eb24-13b315a4cd0mr2248677c88.50.1782875086647;
        Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
Received: from localhost.localdomain.com (122-63-73-73.mobile.spark.co.nz. [122.63.73.73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2abbba8dsm15858670c88.13.2026.06.30.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	pratyush@kernel.org,
	Markus.Elfring@web.de,
	kernel-janitors@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
Date: Wed,  1 Jul 2026 14:57:33 +1200
Message-ID: <20260701025732.66330-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from security/integrity/ima/ima_kexec.c:
ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
but kbuf.buffer is NULL.

Fix this by simply adding a check before copy.

Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Tao Liu <ltao@redhat.com>
---

v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/

---
 arch/riscv/kernel/machine_kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..afc68f6a4aa1 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
+		/*
+		 * Some segments (e.g. IMA) reserve space but have no buffer
+		 * loaded yet. Skip them as they cannot contain an FDT.
+		 */
+		if (image->segment[i].buf == NULL)
+			continue;
+
 		if (image->file_mode)
 			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
 		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-- 
2.54.0

