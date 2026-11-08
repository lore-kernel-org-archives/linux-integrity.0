Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168334;
	b=qA0waHF/PXFmIjwwRQ9srQnMW2XYhJNziWR38zqXxLn+IzY1fnQ4rz63SeOS/6uWnYx4
	 Hf1L6l9BBqSc2f8IJXauew4YjaZUd5YpeOWJKiGAlUt+tcSwC2zPRLK7C9Bj9NZdD6lEW
	 Hau9cmHwXJpHPhMOzUFFN7oEoJeiPvxagmu6WQyYBh/Q1Ch1vxJNkJ7xY3pK7hWjpgwRr
	 aRaJboWajEBBa7jqztvJP7TsUkqdn+w/+2UKbl4m1Kw8nZDW5OZ7mB4860n562jCMz79b
	 foS6hAginbl+r/Ze7mD78ONRiXvBLOwo36WvLaSfcIebghtcsKFfvufByhvLalUbR9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168334;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/b+EcMdz3JBQYeBrlY3qE8serskLcpaM65tBwPNWFyc=;
	b=HNeR1M6LZYPsbOmYvECyh/NA1MU43aBeFu8GMoQU3cvaCp/qwwhqjxFZh0QeIrB7FeRL
	 L+xlpG3HivS28m2UeCFYyrA2B+/AQABpWQVdqH8TbDxP94YeJP0sDhwqhq1luDd6OQiIF
	 v7fmIUcYgqcKdMy2nCBkoB3l2pwO9LCbYq4H1n/Zj62LbP22jbQBAFyBfU0di0wBwmy36
	 Rr/m31afDUaQjse0ipGsM2nHp1mxYjmlTHJ1OqjDKj+8sbHUBHnuI4MhVAi7LxKqv+DNc
	 YjAuk7YL8iZvcwBtqXN7XlV7OboLbDBzFiPm4As91qZpCwFIoCryDgyoVq1ch4KyedA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0c8kjAh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5E606A330;
	Sun,  8 Nov 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0c8kjAh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794168334;
	b=LpuFxBe7PNoQrR9FqPjOXk5HjFWfHAKRpWuy3/0Abf2BsDKbNCQmJ7KXf5N6Jk0WNBIP
	 hNGeqk8O+XJVH7z3ulQbtbDWV6LyR2Zz62I89sbeMxAGybtyHPJKkg1/pRjATADJnQya7
	 OB+VYLZtPKc4QF/qRsAbrug/EuQtEFsVgAPER2erW8UkpzXZk8rMXHvPGUzBdYhg4A7g8
	 i9fXrE105svQTaEKRvQ5ddbGWILnGZ1f/RE2ubv1NPCq75jeaXnIKw0PqjALgD403rLlF
	 YprWir4qlE3p7UQnS7yud9EjMxnSqrvE0njelVwvOU2guKNJ73bYvV48P3ucRv+DF+A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794168334;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/b+EcMdz3JBQYeBrlY3qE8serskLcpaM65tBwPNWFyc=;
	b=bR+cslNfQFeIdi01pQ98Pojq1IsjKnRX+ceC0wAeI8OHf6igfinyG3W0LZR/p5nam/qI
	 oyFZJl09HLg7awBWu67j+C2ypjTNVWRMK5jKuciTl4ZQzLhRYCfQMLfl9wyvHG2iXYBcr
	 Fw95mgYrnsYp2lZQ5LhtvPT3yBHKLw0Ae7TarrGy9694Bj353mHy4LA/yTR6bK4Uzu+n1
	 PA+Q/o37HK1+cPKeXUszQ3iuzssfP+sTzxYpgXpUXl6fIzQ/Maa73gh+DiYTPfop9kvBv
	 8EOtUQbJcWrpveqrn6FtM8qNm5bUhv7fWHsp12FZmq1CJkquT+Zi9xTxJfCPEonu2Pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E1711F008A3;
	Sun,  8 Nov 2026 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168334;
	bh=/b+EcMdz3JBQYeBrlY3qE8serskLcpaM65tBwPNWFyc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=e0c8kjAh35KI85lZ1Qjj5mCQ1CROC8CU8n+z5efDzz9DKMOYv8LoceJOlNxEpFEnc
	 5QBQlyQpA6BWOsK/A4s7SJ70pv5M8jFQWGM/xC45jgKA/RYJBVBI2Fbm8KpnBFAUGd
	 /CJTTJ5lPNT4ExbvFAT/Oz3PUYls9pe+NAU6J+aWf23KcvPnu+tEZ33U2KiaPC4ZKG
	 8WcCci6nP6P6d1zn2gosC29qmbot+1DOg4UHK68/RsYrBu4gLVwDtDf0QcZUHTEPE0
	 Bb85NILWrVpDxr75L7de4D4AVhbCaGJ2o5oIlI90T3QuRNLv/hPKS4pFFniiman/QD
	 siMnQyHDCxABA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E80BE480B2;
	Sun,  8 Nov 2026 20:05:32 +0000 (UTC)
From: Alban Munari via B4 Relay <devnull+alban.kernel.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 20:05:12 +0000
Subject: [PATCH v2] tpm: Remove enum tpm2_session_types
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-tpm-se-trial-v2-1-92c2090351d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7RimQQVX3MOwKDCFMZSSthIN4
 e4Crl2+5P33FwjshQPckwU8zxLEjRuoUwJNr8eOUdqNQaXqSpTmGCeLgTF60QNe8rRmU9SZoRt
 sk8mzkfeRe1Q/Dq/6yU3cG7vRS4jOf46/mXbvT3omJMwKpSg3RcsZlZ3VMpwbZ6Fa1/UL9ajHA
 LoAAAA=
X-Change-ID: 20261108-tpm-se-trial-580bef9b4f17
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alban Munari <alban.kernel@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794168332; l=2277;
 i=alban.kernel@gmail.com; s=hephaestus; h=from:subject:message-id;
 bh=FiL44ygx4KhhpPRDazZwhl0/A0dCZenHQ3H9IagOC6Q=;
 b=X0eopT0lIsvtKricO5oVDqirkfAmYyAILXvY63PUg5+af7w6HbF4DfZC2LAiqWKAcIppx2ncj
 jcPliS4jvUJACDva0p4Vc8DnyhDSbCu2Qx/PKA7/vbc9mbs9GB6eD3V
X-Developer-Key: i=alban.kernel@gmail.com; a=ed25519;
 pk=E4gTLxHRk8yuKicoDcjhUfRHnlctgbnlV9dmOwM5338=
X-Endpoint-Received: by B4 Relay for alban.kernel@gmail.com/hephaestus with
 auth_id=1455
X-Original-From: Alban Munari <alban.kernel@gmail.com>
Reply-To: alban.kernel@gmail.com
Content-Transfer-Encoding: 7bit

From: Alban Munari <alban.kernel@gmail.com>

TPM2_SE_TRIAL is defined as 0x02, while the TPM 2.0 Library
specification, Part 2: Structures, revision 01.83, section 6.11, Table
21, defines TPM_SE_TRIAL as 0x03.

The only user of enum tpm2_session_types is tpm2_start_auth_session(),
which starts an HMAC session. Remove the enum and pass the session type
there as a literal, rather than fix a constant that nothing uses.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Alban Munari <alban.kernel@gmail.com>
---
Changes in v2:
- Remove the enum instead of fixing TPM2_SE_TRIAL (Jarkko).
- Refer to the section of the TCG specification.
- Drop the Fixes tag: no code used the wrong value.
- Link to v1: https://patch.msgid.link/20261108-tpm-se-trial-v1-1-492218f9de41@gmail.com

To: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm_command.h      | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index ca1e2bf424e1..63e1dd596bc5 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1043,7 +1043,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 		return rc;
 	}
 	/* session type (HMAC, audit or policy) */
-	tpm_buf_append_u8(buf, TPM2_SE_HMAC);
+	tpm_buf_append_u8(buf, 0x00 /* HMAC */);
 
 	/* symmetric encryption parameters */
 	/* symmetric algorithm */
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index fc446a1282e2..c9988fcff916 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -168,12 +168,6 @@ struct tpm1_get_random_out {
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
-enum tpm2_session_types {
-	TPM2_SE_HMAC	= 0x00,
-	TPM2_SE_POLICY	= 0x01,
-	TPM2_SE_TRIAL	= 0x02,
-};
-
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A		= 750,
 	TPM2_TIMEOUT_B		= 4000,

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261108-tpm-se-trial-580bef9b4f17

Best regards,
--  
Alban Munari <alban.kernel@gmail.com>


