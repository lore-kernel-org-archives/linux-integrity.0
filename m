Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB13A5422
	for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682575; cv=none; b=Ftqm+fa3roWeJXouomORArQx+sY16OVuFSGRAFTa7h/vRyDfBNHzfmaZ06yRBnMAi+3Q6WpupTKURAL8qmZm57ypqkwpewamSAAYkFD87JpBK5DveybwbzOyu29jPhGQDSHy83VIjaHkNIzSywHWtEoHM84tSab2p4cTKNulmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682575; c=relaxed/simple;
	bh=2LHAtjESN6S66Bv21aGOPHTI3dmXGbwU9JZCPapdB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNTDCJnL2on87vcoWTRo4wI08G6PEYQz23qwq6SlsqxjFEJXlY/9SZu87zYohRuouk7OO1jKt02zHH6ErwAdwxdg1BGVG2JaPVbOqgkpOqEBnCWgqHdAe9d5rbzWf1K8imWliCATtNuQpd+2FT3zuhe+msBn71Qhrg80CD29EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky25Mvbk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky25Mvbk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so218549b3a.1
        for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682573; x=1788287373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=Ky25Mvbkhooa4TlV4ffDyMvkyWjqixuCeIjaOMZmEwAhTQCPsLa07P/bc6/NYcdZ2u
         j5oYH3I4+geEDpCQ+4QHHPdSwl88vgM/WzOzeovV2oihxnJD1gVI0oGxrfgORnVTUAyd
         lSoqcBdQniAxTMQiziOdO5iQQcHIqgL+Sw+R+XlIJo5Izir5GopaX0y3LvjbN7C6dy5+
         TkVfMj44lI1vAkkqaGl7eDRTA3XO5c5kse03TQPPJjngG0gV3ywMzcUoD+iRGbo1VKYC
         a3Wyl8NLQiQrhl0mPyR2ErDcOrmLr+q3UMjp9/VjdBpjkg6fxonM58AUhzDW2qPV4jT/
         RXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682573; x=1788287373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=CTr5VsnSLe7ZOXCGJr0Zz8IqFKD2QIo+zZi76LvARvnLxDSAgLPypj9LyXj/5cwES3
         ykw5ggc9bSe/yEml9W5/nuTFu5sVfql1F8H7MDT9qP+JVni/yPCLYh63vcUct/NLjn4+
         Xv9VD31CvXZROlhwfp/+W5QkQzAzt3/sNvGeJy1k+WzvBpKYSGOhdVKpUNybAG3UtHW4
         BZ4NJj83eLHuxTY+RelwHAOslG/fnS/FpWnLw+dqMPhmdCgcZ/OA/yTfTbEK6SOQfHR0
         7N1FlMwuXy+JNXPLJr56p3BtKTDnDGjbbl92AEGiRILXBgOHOlgKQhHvuQvk9X/omGV/
         p+tA==
X-Forwarded-Encrypted: i=1; AHgh+RqbMLXk5+Rz5u8IhFz1Xd48XxLBSnXMwMiaLtFH1cPfKCfDiMe/X3k96MaHhY1XRsFLuCBIaaXcVJU2pYK8Gzs=@vger.kernel.org
X-Gm-Message-State: AFuF++n6YF9UB0MsF1TLTZKefsv4uTioIhp1CguNoO0YUuMBGfx8bAp8
	jf3eqTm9kAsxP/HTx9uinxOM5lVHu20xXcFexpHbekZ31Pq63vLipoxV
X-Gm-Gg: AR+sD12RnA7i0xuAIrNAxkvC8H2bBcYvEsSZffWkj3oWAFBGavKNuaYFCXH5pcaFU4r
	5St6ee05YgpxCu9oirqqFFt2aHUOcoWdznzb0USHSnTCHjg4ZzBbfwDt+qbUqMSneuf7YtyyqLw
	xdW0q4AIHaCebnqw+SAHd2QWeqRzTZLsCk0hzMg/2NAVqBtFs7EnAKwmUJ0UTRJmAOm18OTCNDa
	1lsGTbh9dtt7PXA1/yfBjbIY/1QmjFfHIKKy1HRUDatzoVJcdBysomtHh22A0slHu1RzKaIAh6C
	BPuueBtNQlItU+f/XmU2vL0AB/pKKZ90tOx02ws3segPm5UEgkWZf9gf5bn7yZ+Om1ACrDtyWCj
	EbGkDoNpAXa2931bakNyVMDlWDQOM795KC/acVYTgeEV8TAGR34kbuBp/rs1HuahynQjqfy3rLJ
	3Enr8V6Gv0EgKGs20f/zXQwv+k5N/+UqMwrSbLNASl0KMMm08Tu7YdlutkSUx2C2K6mlwADLznY
	B8+7U84cG2NndkZoJp+wwevTwDKdNkUEBDmoJeDXDM6YP2tOH+ksmFeRPA=
X-Received: by 2002:a05:6a21:390:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3cf7628564bmr850511637.6.1787682572983;
        Tue, 25 Aug 2026 11:29:32 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8861d3sm1230188eec.18.2026.08.25.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:29:32 -0700 (PDT)
From: sn0x-sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	sn0x-sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Tue, 25 Aug 2026 18:29:18 +0000
Message-ID: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_seal() computes storedsize from TPM response fields and passes
it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
validation. A forged TPM response can set storedsize to 4086,
overflowing the 512-byte blob by 3574 bytes into adjacent slab
objects.

Add a check that storedsize does not exceed MAX_BLOB_SIZE before
the memcpy, returning -EINVAL on oversized responses.

Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
Link: https://lore.kernel.org/linux-integrity/
Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 8f57c6111..d47cb7108 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	/* copy the returned blob to caller */
 	if (!ret) {
+		if (storedsize > MAX_BLOB_SIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
 		*bloblen = storedsize;
 	}
-- 
2.53.0

