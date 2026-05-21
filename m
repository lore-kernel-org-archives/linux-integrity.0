Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B97376A03
	for <linux-integrity@vger.kernel.org>; Thu, 21 May 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356285; cv=none; b=cUPNLShstoNngKUv2Bk+Dzkgs9s53aFnHM33ttfgOyWv6bilxibFNyB0XUTztxI07y/RpHjRmV7T7f7I7aaT4tEtQpEg2L9RhEvyfg6aZ1RiD0dAjnmEnInmiYf8+jGjdbagTDmLCrq4BUUvm7qbdX0sdtzte8AmdoJOIHMlflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356285; c=relaxed/simple;
	bh=YqAQytJbYhQ39t3pkKct2Su+5H1G5e6obzCJjhI+d9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPcese8AXuhyIh3Wpli/5oivW7ssr1LjqdfDBXhXM95P7i/phFBUNWeve9fJCgIF68df1bVifJwkqTDAeshgVGiXm+P9VuAGmqGG8tCEXxLM1aMCewZy505KkZj+t/3WwzMQnHcHVn5ArwgCg5nHWRcCOf4wwW/HtaPOAchcKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmGn4Vjx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmGn4Vjx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779356271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3HkDah9G3ZXvEMnDoovHGjAyQRejsoiaP7BkJegKqo=;
	b=AmGn4Vjx+ulywScrk174lQ9+slQRI44UuUrK6HoHiI7FCvmgM4IwlrI7kqPz9osUiBHyUw
	+vAbVgu1S+fgSxgjVQPsO2TqZI6YN39OY0dLoUgkxBYUEJz9bPKHyPPj95zMahsNY2+QdP
	C1nO9gLpynXyZk1MDuKTzisQB087umM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: fix event_size output in tpm1_binary_bios_measurements_show
Date: Thu, 21 May 2026 11:36:39 +0200
Message-ID: <20260521093639.162095-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=thorsten.blum@linux.dev; h=from:subject; bh=YqAQytJbYhQ39t3pkKct2Su+5H1G5e6obzCJjhI+d9o=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl8lzQqb4pMZlNfHqsd2PR358Oiuxtke1uvKP7/+2jlC ebcRcvrOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiHEaMDN+E4n9JzL96yibx 8OnVwSWyWmKXt/AZ28y3f/XRuuFT5idGht5v6S+VL+z1mNUiH5LzZVOyZhj3NeO8yzNrFrmvK16 mwwsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
split the output to write the endian-converted event header first and
then the variable-length event data.

However, the split was at sizeof(struct tcpa_event) - 1, even though
event_data was a zero-length array, and later a flexible array member,
both of which already excluded the event data.

Therefore, the current code writes the first three bytes of event_size
from the endian-converted header and then the last byte from the raw
header, which can emit a corrupted event_size on PPC64, where
do_endian_conversion() maps to be32_to_cpu().

Use seq_write() to write the full endian-converted header, followed by
the variable-length event->event_data.

Drop the obvious comment while at it.

Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/tpm/eventlog/tpm1.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index e7913b2853d5..291720e89d91 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -224,29 +224,17 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
 {
 	struct tcpa_event *event = v;
 	struct tcpa_event temp_event;
-	char *temp_ptr;
-	int i;
 
 	memcpy(&temp_event, event, sizeof(struct tcpa_event));
 
-	/* convert raw integers for endianness */
 	temp_event.pcr_index = do_endian_conversion(event->pcr_index);
 	temp_event.event_type = do_endian_conversion(event->event_type);
 	temp_event.event_size = do_endian_conversion(event->event_size);
 
-	temp_ptr = (char *) &temp_event;
-
-	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
-		seq_putc(m, temp_ptr[i]);
-
-	temp_ptr = (char *) v;
-
-	for (i = (sizeof(struct tcpa_event) - 1);
-	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
-		seq_putc(m, temp_ptr[i]);
+	seq_write(m, &temp_event, sizeof(temp_event));
+	seq_write(m, event->event_data, temp_event.event_size);
 
 	return 0;
-
 }
 
 static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
