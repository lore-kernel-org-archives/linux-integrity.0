Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764761;
	b=l31l3vvtkOkfJWlwGnTBa4XzQVv8R79kGlOHyQuzLEq/SoV2+Kg4zsV0ZjlWxJqq/Uv2
	 /xCn+Wd7VC8fZzNphZcNno+M1psiKRpUXurzKdRIbiAXBg6mKq6kCAnnQZQltoANr5sBo
	 yQ5KDDTe7nWzMPtnlR14UYH4xWM3GNXqfrPByEkq2YIyJWk6KkH4b+OvQmFo+20lTOO8g
	 Sk44WSJnFn37ZL2A1jx3fc1LJ/qDICtAIAlVKGBDTBHnvxFk1k8WzqAKjXXs1aX+gqj+t
	 nCPRt6yCYl3OS3ExpkGaz7n2kFMRMgSVkMH8wJPnKmfj5QJLket6/91V8aRtmEHFnOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
	b=mVI88x/vmhsPNn0RAaoKKiR1NBQkeymFGOcSAf6vYn7OvB/nIJ5BMn3cgTommk6zAVr1
	 3N6XhOB1CaL92Pp2S3M7w0Raf/CsVTjK3Lq1KW4aZaOWupOtb+bE78u+yWWtW2w7WAQTD
	 Q10oqP3JZqPbXEMcNveOmwyKD3QjfQWEX03n8BqCrYrU8WtLynD6pLmifJAdKc0+wW7kT
	 lG6s7CSQa593dPkHQ+Xni1pKE8/NV4c2Xk1jzfjJ5pRRnTNgKFhEiIl3Gd8FGDnNBrFBK
	 4L4Pgjzrm2ApIZNVmzoLaCJK2GR08W8o0xYPWsO8WRnK14R2pQ3mnhDJHjGGruhuUoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kzx9ZZrL;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6740606A321
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 07:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6740606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kzx9ZZrL
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso5706188eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 23:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795764760; x=1796369560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
        b=Kzx9ZZrL/EDdPoNVDguy4uUQHvfrLbRe+5pu5vvCwHwBOKDtOYvENQXazWF9Q4QG9S
         RErEtlF1I8fl2bbP5a8rpgtSfrjD1QE3vdZHreBqkNFQYUqwQiN4PMOnyNYzctbcCAWX
         4+houz0x1MJ4+72svaeoYgBJLkQiZheUdD+2cHAY8jZb3xzDBcoc0Xm5MB1yiiH5/qoU
         PekSK3e7BHqIOObn2z/hfEQWeLVAYugix34HFADqzQoQRH/3t7TRgYZqPrFrFyH9ots6
         IEbgRQVnEzOTy5i56LoA0JcCJEwJbYRspYwvYu/qWQ0W2XD24HFFZo9K6lJadYizwakz
         os5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795764760; x=1796369560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
        b=0+A2rHd/GGV0b7d1NYfc2JqcryjQYb/FrzEsLajdoM08R8AfpgzSg0uwioLbIOHDvr
         QBVZv2fqg0Hx30tdtPW3CBImN11oD1xVZEgiSZgpumFayQWF5yp0yD3PDSbdNCyON9AQ
         FbOa7d481X8+79+dQOHy2rC6/SChBpivqaSkd0cbmh6ocQhV1jLb/P6cQhSaskMxHqAt
         j3CPENoG4ReeCxyAhJRXLt98u014LlopubR+mDmm3Aq4dwyKpW7N6VQj4MGWtQqTStc+
         dZXQsGsQSXMUqANYL0uWO68+QHjUXp3es8h8oxbHqkayWCOIqmV8njeEKz9Chc1xo4oQ
         4vRA==
X-Forwarded-Encrypted: i=1; AL+hErHZ5Z9MdLITuaNTJEX98OcxnGco8AjUjSWT2L1kYJJvjl0fkO9NR1/6SohdqXOV4YVdo1ebxaLqZb1Wg5psbFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AEcNe3NGGSNrPKvW/X6jJGmQ8GVgcTTnShcRDOAE4e/9AFfWB
	B6HiXDVNlETjbpiZ7/Sn3eug+vx/d4Zz/md+S9GjOl5fWFIzDpUf7AqhB19teQ==
X-Gm-Gg: AZFdTZcnVNXX3Ipq8MTUqJjZn2Gito+Hz8T2CMN50VJluxvHeG1dyPIcJjnJf4CxHjJ
	DSLem7aXXbyAX42WCkZK2a8FywBwzko3LBq2xRTJ983en/wnipVpCHtVlNXQCWRUgsXBwtd6S0P
	1rPYtDAD4hIp9ANLTZnAeW+iJ0OJ8TkXwaGG6qKIFmnv2S1TIFLK7+DFsppNrdZE0YkqTs0jALm
	hYFMPitUcTFCMSrBXjKt3mxSansvYxvfcrwYX4xXkaKEnnK7RuOk/Ayyfl7d55fGq7W62VzhMh+
	IbP+pKQaRQB4HJhAy1PAK9HFz6Enfw1ngsAiBSqu0LfGqYXE92P70wh+oT/bIz/zosGgS70bCSL
	hOKxjoZvsLnPGmaMbvxKHT6FSlAETqywCSl22IkJOX8mssoTHvB++y0fd9fWyzkgYgkQZ+cU6RT
	ktenq7Or16Ymx1WiO1LiiesKTM0HuJwJB0G8qhz9OB44PQj+FB4axKaNlkFuofAAjC7D7dXGpKi
	cepjPywlijG/3aBwQLH5Y1E4s4p8ghXwHdkNoOc8iuNsM3HEE7pgQjOWoocCq8VJgdGPdUii2Ow
	JIqyGKg5Rwp8JkYW7aigBN2cAp0NhxJ/f9rVUMx5d88gpP4=
X-Received: by 2002:a05:7300:2301:b0:385:4c54:3c8c with SMTP id 5a478bee46e88-3856c0c9403mr33946786eec.1.1795764759968;
        Thu, 26 Nov 2026 23:32:39 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm62804163eec.20.2026.11.26.23.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:32:39 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: free the restored template entry on error in ima_restore_measurement_list()
Date: Fri, 27 Nov 2026 14:32:33 +0700
Message-Id: <20261127073233.181925-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

ima_restore_template_data() allocates a template entry that the caller
owns once it returns success. ima_restore_measurement_list() breaks out
of its loop without freeing it when ima_calc_field_array_hash() fails
or when ima_restore_measurement_entry() fails, so the entry, its digests
and its field data are leaked.

Free the entry with ima_free_template_entry() on both paths.

Fixes: 1ea973df6e21 ("ima: Calculate and extend PCR with digests in ima_template_entry")
Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_template.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 16154078fd70..d5256da8f76e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -526,6 +526,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 						entry);
 			if (ret < 0) {
 				pr_err("cannot calculate template digest\n");
+				ima_free_template_entry(entry);
 				ret = -EINVAL;
 				break;
 			}
@@ -541,8 +542,10 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
-		if (ret < 0)
+		if (ret < 0) {
+			ima_free_template_entry(entry);
 			break;
+		}
 
 	}
 	return ret;
-- 
2.25.1

