Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189007;
	b=EvXb+1n/wWRPjkqEzHQEbvtROXjupphQSz3iq5Gna/DXIcr2y02P7fo9Xdol7lFwt8Yc
	 MjxxQCiOWegOw4KZADBTK+bpP02WQJSK86DFjR9cScXtfOCKOiQx2UwwhWStMV26kcgPB
	 M3Lgs97QYMvNnQwu2Gm0oYljDqas4RpWVxG7jZb9332KrtG8GTJmWo6epD2PqYxdE5zqT
	 H1CWoVYo0LnIqJwjEyY7ngx+gD/UWqzNoO71EXg9j+6qU7rG1b/GG83eJRwONY2LUEbvZ
	 kGdB0okkWa27rqshJbgyfoUo+2Q4T7PRU3tZMT9dquF2/tLi6RWr1kCebcGLewfhAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189007;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0UrPyjnV+g0ulzGUI2dXxm+mkOWbP/75IbFUZ4V1ZIk=;
	b=qzJUcBsFOIkiSHsw8BBH2Mi+DGwARq9PddsSSTx15NI6CfeEralfrQfRGfW0qZR8PaAa
	 TRfdfbBnszdmxxBCUa4SEqY1O32B8vYS53o2C4FRoT9nBxp9MBAnY4DZImGhqxi3yuWWT
	 g0SJ2jw3aoxDyQu8yixIrdKWbGl7OsAZel0d1nuK+MFrsg9vAtZ+iKgVOvXklxmZgbJRh
	 +m3HEqPml2ACSrMFuQcsebv81WURoSd1iJnVVEhjDD9je/r0I5Q2fZQ7xZ0eprPPSi80i
	 3Sqazu+awbbShAw8jEhIXmQFMc3zLXzOygeBzFoCBTE6Y+oNfvt3heRxf4AnjuERXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MJ4Kyqru;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B4606A31C;
	Mon,  9 Nov 2026 01:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MJ4Kyqru
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794188997; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0UrPyjnV+g0ulzGUI2dXxm+mkOWbP/75IbFUZ4V1ZIk=;
	b=MJ4KyqruD6kJJMxEjVKC1dpsVUjZ+GlGfC525ENHfrR2SH4aywe2VF2UAz3foUWIUI0EsM3TQpzNwfkQY2yHP9QQtX1Z9lccRDipHx443oqwcQ74GOOuwPfpBugnSXh2CP9aIp018G4jARc6Omf8L+uxZH3SydX5rvWQx6jzX98=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1606892|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.000952147-0.000939795-0.998108;FP=13220359827208283216|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jziGj8I_1794188996;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jziGj8I_1794188996 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 09:49:56 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tpm: sessions: bound the parameter decryption by the response size
Date: Mon,  9 Nov 2026 09:49:55 +0800
Message-ID: <20261109014955.2777635-2-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109014955.2777635-1-guozh23@xiaopeng.com>
References: <au3waVnY6QA8TpPl@kernel.org>
 <20261109014955.2777635-1-guozh23@xiaopeng.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_buf_check_hmac_response() decrypts the parameter area of a
response for sessions with TPM2_SA_ENCRYPT set:

	len = tpm_buf_read_u16(buf, &offset_p);
	aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
	aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
		       &buf->data[offset_p], len,
		       auth->scratch + AES_KEY_BYTES);

The length is read from the response itself and never checked
against the buffer: every other size taken from a session response
is compared to tpm_buf_length(), but not this one. A TPM that
reports an oversized parameter area makes aescfb_decrypt() walk
past the end of the buffer, and since the decryption is done in
place, this both reads and writes whatever follows the received
data.

Check that the encrypted parameters fit in the response before
decrypting them.

Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
Sakkinen: a TPM reporting an oversized parameter area is not known
to violate the TCG specification, so this is hardening rather
than a bug fix. No code changes.

 drivers/char/tpm/tpm2-sessions.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index e140079dbc13..59c7fdc0c88e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -872,6 +872,10 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 			  auth->scratch);
 
 		len = tpm_buf_read_u16(buf, &offset_p);
+		if (offset_p + len > tpm_buf_length(buf)) {
+			rc = -EINVAL;
+			goto out;
+		}
 		aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
 		aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
 			       &buf->data[offset_p], len,
-- 
2.50.1

