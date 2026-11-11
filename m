Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434392;
	b=QOX4Ih6fWG6X3bzzxr+EJ4t+q8tJYlChIrAy9MqngDlez6O55td7jECxy90Ta7S9WXfk
	 12nutMN4QRjAgznVTeYujLNv8ZWEk6OfJNJMgpeAOoPXwfjiPtMPCF/umsnCTzcIke4GT
	 LmVSnWHlesTwtDBTZTlMxK1G9CKgoxCo3TQSmSKJYyX8spwHF6S25wKtYUanby4PHSMcp
	 1GuZ4QeU5CWF4cSM+JeCtFVCe20vNeT2G1hSBdRrVBPAVRS/BgBJt71O1z3ynAvv+Bxn7
	 aJSoY7laNFbptSqk5obez4TfjPvgUwzJPmSbC1mgODHM7sNqd+QwDOzs5xGAEZBBYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=90pSFmld/fR1eS3PIVathWYp/h+Eq2KImJhG7d+ZIhY=;
	b=xAxn0ivJT/iBX9fBmI9SOBRHQ/uEIoleCwDRSeZOk3PR2m9dKrC6SHO9kZLVXZWX78a0
	 5ZWYjwpw0yo6t65T+9rTj0tzdOcrkJp73WvGFFtJ15oKr6gTUf5rI2vsCPl7xoNFg41Zq
	 tvIi6lySxJbZcq5Vq9+YNq7zHZjwaUAgdDDPDfBaPSfyHD85ATV159v6nItq2yec54Il7
	 4nfoWh2tFclC/tljTzcX9jnzVUd3NUNAiZlippW/Aw7R7pznUTLSBPV/7bD8A83b/vnXZ
	 DuX1IIu+rabYFrmb0Cj8XuOv0lbmQFs262Dpk7A4YYBNpnEaZiASbgYMrVnubUw2S3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SZppQVJt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHWtaqBG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB3606A880
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 21:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DB3606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SZppQVJt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHWtaqBG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIpOuS2079734
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 21:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=90pSFmld/fR1eS3PIVathWYp/h+Eq2KImJh
	G7d+ZIhY=; b=SZppQVJtZ6znTeobswqmlJMF487MG267OZ9DrVk2qcMkO3GL6B0
	eA66nStjKBw6Vd+zK3p4cjKpqwllJOfpu6/Pb70TpJexuMYygroIBhqSvODszARi
	Vga7S/9KkXC3akJ+NMVbNhMMCJZFQswtkf6TN+OFv2t4ukFG4zHYbiYxDzlhIK5k
	cBxAozDrEUq51JZwyWIDROA3AeElj+b9BYXtFDjOJvSN73ctEUostewqHL8DGZe+
	tbUR0M/h7h+nvlhwkx0glmsFfiGvAUjWYl4+JCvut03oafJlUNY6corbsP5Z6GeC
	HAL/3quAdVFDBl8MsbiOaVQR25KDq1cYDdQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m23hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 21:59:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb98809caso608969985a.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 13:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794434390; x=1795039190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=90pSFmld/fR1eS3PIVathWYp/h+Eq2KImJhG7d+ZIhY=;
        b=LHWtaqBGXNA4lgZB/xwqtJFpfgjvwFbhPoqWTMclGpPTgRUXfh76AF3m6ekqfBgkKZ
         EGs3fvdWIeU6Qhl9TxbS7GPBpzMJOx3LsJqTkWG+OvTQk4QxwTWTzdYejk0woNeREUY9
         kYKPMgliQqWK3nllWzlWml9CBqXk3GBa6ol2zxqcU13WV7JtKKQ3cwVsrPoU6UV3/dpz
         Ic+iamV57afrQf7hyQRXvXJUXnbdj5hlkt3IVuq129LRTVIWiR02aBPCNyLzNsinF4dJ
         wB5iZCcHQ8xjq+nZIYOm0JBg8KwljZtlUfYDiLi5KxNlMeFlDDT8/5jga8BvcwBHcEyt
         GgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434390; x=1795039190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90pSFmld/fR1eS3PIVathWYp/h+Eq2KImJhG7d+ZIhY=;
        b=uR7toysfHBVta3mz7+Wcog6oPHfK7xpy+bLTaOeMbn9c7E+IBjx0wkkxc6W6NuKeFa
         j6E6/ZAwbOblF0mKYulTSkyvYjd3XNHJlrYY1TaBt/AMXZOiVytwX96goQtn+9Oj3spv
         rl+qsqNkC/03D7ABWSljC0T7yja86+mKC3unvES8xWzUoQtmHzf0Gg/yWI/NHujWbDKU
         FUOjuqpIh1/D8ArElNPhuVH8KZMEuacVzIUZqKGCXQhuzwRKhpVfW+yWY/S7gvS+aNm/
         KPLPYz2rMrsrFOsvQ/2v2oRYnvHYAvHXo6jZsx4AzZad9rxcCYDgUPVkZNg5OrJSHEuj
         np4w==
X-Forwarded-Encrypted: i=1; AL+hErHS6pkMY6N4sJ0ojfnJGU1tsyW6Aw66RnKX68qEA9rcmgYyUs04V1pszNZ7M43OnzFaaQfbzu2Akb6DeZLR9C4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hQWTizpCDsHc1xm2dY0tIXXmdbF56FaRaCqRB04GvsOubQbzM
	jis5t8fZUwfwoSP7AC0WQCUcbOGBJW1hLR6rtHmNKIZeV0N7vz3v29YuOdJeUrYK6N8oJqpe4Wl
	mblN+8tvC9p4JbgthEbslngMw8z5XlvF/kFcAE+tA9rmN4oP7P1lY4eIwWteBW5ookP59sLdeab
	M80kM=
X-Gm-Gg: AYBFou3JZ4XWvZsepeGhyptaXxXltvll5uQ8188v6XugVjQOV67HynXpOHFyaF6PwqG
	jUz/6ofNfxIGw9UqpQ2w8QZaiUXTMODIeLAmd/YsH+IPr2/GEjDYke5NaOcBluyRLr3cDZ3Tsmy
	KcbrkKMPfwp6an4wp5GN6AzVGs821xf2RhaTN3EEBUSasSUxCq4IjeKm5CbLOaOrsQ/T+GUCYmP
	zcxAHZ2VWz78brpR1ag63NBIweD2sDTrO6wiyH297Z5QxUChM8rnl5Gj/45fGRF26yJLOP988dh
	OEK/97UMhQ9/N95og/jXmckK1LbL8lP27UyaUT0eQ3+KlCg3LT90omqzHxEwSSWh7wRS2inebJf
	lcJHbZ5WhEZzL1HWcgWRkokcgBSyUUSguC8dOz/Y2UFV0KYItoAR86ubcn3z8z0nRt2eoNc6cuu
	hl5nBJhN6uPFcp+lybiQ==
X-Received: by 2002:a05:620a:6f01:b0:93c:5f3c:f485 with SMTP id af79cd13be357-947b005f191mr653305385a.53.1794434389562;
        Wed, 11 Nov 2026 13:59:49 -0800 (PST)
X-Received: by 2002:a05:620a:6f01:b0:93c:5f3c:f485 with SMTP id af79cd13be357-947b005f191mr653302685a.53.1794434389102;
        Wed, 11 Nov 2026 13:59:49 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4982eedfb36sm13244740f8f.0.2026.11.11.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:59:48 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and firmware TPMs
Date: Wed, 11 Nov 2026 22:59:33 +0100
Message-ID: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: ki5AoQ0sXCHSkUQckAIdUWysmHIdZwbG
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af4e556 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=McN5tr3TAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9ZQdPFlokNCryPtFuLAA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=NFOGd7dJGGMPyQGDc5-O:22
 a=OiMWn5MEmObRqTLTTlUg:22
X-Proofpoint-GUID: ki5AoQ0sXCHSkUQckAIdUWysmHIdZwbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4NyBTYWx0ZWRfX+2HYBEcjJjpo
 3TT0JxHpold4HrR6vI9kiA8lBUgIs4gisA73/gRep7y/DAZGkFTMM4av/PifMmyvBywo5LiuDku
 1wUXgPuhEQYEWVZD8tTvqEphl75bSGtwS/eLDsBC70x32ca60Rz+P8VTsuGw+G7C4GmXvCTDYXU
 +7N2ocO9kfpdjOMQJ4820J+7oXuDniSrJFW+1bASRlz4p0wKJ7e6ybexcUGS/plRRq3Di9sJDyT
 KL9vBJVu2Lmxb92w8ykSfp/Eg93SdFgcNp498z5lTau0rXw2ioIdzeNgn1VXYWGGRKLeCDImunO
 BvpZuDfli5O+Fxuz108peaQNJgE6NADGbXkEgNNxvLP7OyUkovqFc9ily7lmIMJBoNQBU3fE6z9
 Y3Mxh+A0oCE2ywmFimDwpzDxYymoMnbrDuW8Wz88udySlfozPUP2ACySD30bH4bVb/7/To8wJLZ
 Y19p9cMGr5QzZcbfnCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4NyBTYWx0ZWRfX1uH7SH0goQqz
 10vBMJlYYx0Cfjbicr+a3v8jC7BZMQ9pqJkkmWajjS6aP/IkTqILzXRnTS9sT5u2yQX8+PGO4Zy
 /xwYEakisfL/qkwIctKQuvIy+8/LQXs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110087

This adds a driver for a discrete TPM that OP-TEE owns and the normal
world cannot reach directly, and factors the shared OP-TEE TEE transport
into a small core so the existing fTPM driver uses it too:

  - a transport core shared by the OP-TEE TPM front-ends;
  - a new discrete TPM front-end;
  - the fTPM driver converted onto the core, keeping its name, its
    platform/OF binding and its shutdown path.

Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
tpm_ftpm_tee platforms use.

This is the normal-world half. The secure-world OP-TEE support it binds
to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
relays commands to it -- is under review separately:

  OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
  locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
                  (design follow-up: the secure world policing
                  normal-world locality access to the shared chip)

Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
SPI, owned by OP-TEE):

  https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html

v1: https://lore.kernel.org/linux-integrity/20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com/
v2: https://lore.kernel.org/linux-integrity/20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com/

Changes since v2:
 - tpm_optee_dtpm: give the discrete-TPM front-end a .shutdown callback so
   it releases its TEE session and dynamic shared memory on shutdown/kexec,
   as the fTPM front-end already did; without it the session and the
   normal-world pages stayed registered in OP-TEE across a kexec, which can
   stop the next kernel opening a session to the chip.
 - move the shared tpm_optee_shutdown() helper into the core patch so that
   patch builds on its own; the dTPM front-end no longer forward-references
   a symbol that was added in patch 2.

Changes since v1:
 - split the shared TEE transport into a core; the discrete chip is now a
   thin front-end, the tpm_tis_core-style solution that was asked for.
 - convert the fTPM driver onto the same core instead of duplicating it.
 - use an optee-prefixed name for the new modules; the fTPM driver keeps
   its name, no module rename.
 - rewrite the commit message with a plain description of the components
   and the rationale for a separate front-end.
 - drop the explicit zeroing in favour of initialisers, and reword the
   module description.

Jorge Ramirez-Ortiz (2):
  tpm: add OP-TEE transport core and a discrete TPM driver
  tpm_ftpm_tee: use the tpm_optee transport core

 MAINTAINERS                       |   8 +
 drivers/char/tpm/Kconfig          |  28 +++
 drivers/char/tpm/Makefile         |   2 +
 drivers/char/tpm/tpm_ftpm_tee.c   | 295 ++----------------------------
 drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
 drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
 drivers/char/tpm/tpm_optee.h      |  32 ++++
 drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
 8 files changed, 414 insertions(+), 312 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
 create mode 100644 drivers/char/tpm/tpm_optee.c
 create mode 100644 drivers/char/tpm/tpm_optee.h
 create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0

