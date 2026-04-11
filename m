Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9E1A2C0B
	for <linux-integrity@vger.kernel.org>; Sat, 11 Apr 2026 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867595; cv=none; b=WUrQWC7GOfd8UbLnOdTdvoehfpPpB8+mwydbxiMKw/S2P74BMBnF/SLsVY3AMSD3KlwC5ccI7owFwxZGoicqgu/qvAaNeNrz9/JqZrmqV72+po/49VOhNvhHu0caIi37hwzPU7fN4Jna+aKao/lWRazpK9bP2b2bPj4F6rcAq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867595; c=relaxed/simple;
	bh=XPuMBZVG0NE8mdkLvBlb6VgXYh7nwYZy31NTdP4PNa4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TEc6T9TC4YtSy8khRUD6eGWRXdWYiKewsj7S6S/RXQwrIKlrAc8XXSh1hIsON/0R6kC4QglraoLcG9PeNxeEPL7FPJpMYd3hy3AzRM4zX0gdAYuicaR063bEWqbLebwUKifnt0rc1l/EVOx7kZk67mGzWVQdJllli5M7v3emK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGwpN4AL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGwpN4AL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35449510446so2940045a91.0
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 17:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775867593; x=1776472393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ucpdMiFaCcp1sRrYg856z8/0lc62sspcUFHQ5kuDksw=;
        b=QGwpN4ALUt7WvtmaWdND7MvIxts62I6FgsUdei2+Key+QnuuetV6F+/N0V+JOvUUwB
         cDo7h5D0xy9XJY1et4pS2dlUfMIt0sT0DTAQcDYNmGDaFsJTzqxYHbCqnbvA/UHC/2yO
         b1IEB13efoKZspdbikoEJZ2TtPCbn6eoWA88PH2lAunGkE0GR1nR+7wznpgdkmBsE2IH
         W0JKbjYlOXZBkYJrnyG6rU1wNcpvUdGmT+kHkAQBHXQ1nIn2sNsTHdCQtEubewLhqs9t
         5NOhRW742y1qywk+4AXahJaNtEY28AXgz3OhDZ298pgEWfTw+O2iq5hkO0H0NbRfTX76
         fRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775867593; x=1776472393;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucpdMiFaCcp1sRrYg856z8/0lc62sspcUFHQ5kuDksw=;
        b=Lpywc9u3kEZlbvxW6oDhEdLc77GCRRquwIA3rNJjKpHW41N6obSDZXA2usgYasbxeu
         tUvaF7q0KrqreD22qBoSAA25a8nVPIy2f02LRNoB6VH0Hj+s/5MM77NKWAatZXrcGDLk
         A0kUpLvaWF2XsJMm0hHW1AC/3UycNKsXy3ijzZObvHUYUemodb0is1QfAxtWJ3TNuXJj
         9xxOeCRZFRMNRa1KNDLsGHFZdHgshcp0plmt511fjt/MAgP/rWCoSqTGFJjlXwAGr/AE
         7MNFFXmyrMml6S6CoKlPWBiAgLsVA8Y8eIo2xtchAov1I2JsNAi/Q+Ypx8XzFHPojSp6
         m/HA==
X-Gm-Message-State: AOJu0YzFe8bhXQgVf8A/3hXDQZLDEhSmnqe+h+b20TIMBViuSYhR6NdC
	lsI0ZP98fVPIfOieovS+fj4zQl59u7pUdk/gfnWv7vxC2uCcscEizvjWYifjxR+FP0GrksHyzx1
	R6HOFAHqXoZxJJbokUkAUI8hwFSoW1z8VFBwAjIS9h1IEUKR9ZWmNKMt/G/z71MPq3oN/MqeM68
	Y05pcu7pTx9rc9falNLXoXY+4s8BQ2PnXCNZW4w3UFOqbBuZS2l3CDfIxb+jg=
X-Received: from pjbhk16.prod.google.com ([2002:a17:90b:2250:b0:35b:993f:f936])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d610:b0:35a:24f3:2c8e with SMTP id 98e67ed59e1d1-35e4276eb1cmr5067290a91.9.1775867592849;
 Fri, 10 Apr 2026 17:33:12 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:32:58 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411003300.1823020-1-jacqwong@google.com>
Subject: [PATCH v2 0/2] tpm_tis: fix retry exhaustion and add logging
From: Jacqueline Wong <jacqwong@google.com>
To: linux-integrity@vger.kernel.org
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	axelrasmussen@google.com, Jacqueline Wong <jacqwong@google.com>
Content-Type: text/plain; charset="UTF-8"

The Fix:
- Patch 1: Adds error logs to identify the specific hardware status mismatch.
- Patch 2: Stops execution immediately when retries are exhausted.

v2 changes:
- Split logging and logic into separate patches.
- Added retry count to the error message.
- Included dmesg traces below.

Testing:
Dmesg traces obtained using error injection to simulate status register mismatches.

Before:
[  130.288751] tpm tpm0: Operation Timed out
[  250.306070] tpm tpm0: Operation Timed out
[  250.310173] tpm tpm0: A TPM error (-62) occurred attempting to determine the timeouts

After:
[   10.271547] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
...
[   10.646283] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
[   10.653461] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
[   10.659304] tpm tpm0: tpm_try_transmit: send(): error -5
[   10.665435] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
...
[   11.037198] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
[   11.044441] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
[   11.050288] tpm tpm0: tpm_try_transmit: send(): error -5
[   11.055723] tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts

Jacqueline Wong (2):
  tpm: tpm_tis: add error logging for data transfer
  tpm: tpm_tis: stop transmit if retries are exhausted

 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.53.0.1213.gd9a14994de-goog

