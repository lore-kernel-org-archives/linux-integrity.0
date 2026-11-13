Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598606;
	b=koysrCl5KlZllt9HVNcPetBUKPXIJ8KV42PywJYwPGoGH/KjtYztN/MwEgcTYkLhSrK8
	 109NLvwQzz3oYYHIKsbwAzn2bmcYKLS9F2mXP7AZmhQ1yOlyZ75iM0jkmAxL+2LjwxZFq
	 I1tcMMqb9k6HwNlb35F9eqdDWej8wtqUk0VnrDTlX7wesLIXNTrc+jDRzRqUGYa1aTDOR
	 IEr+4P6LQDV85xTGQelb9Z1f6+z/rnUK3QgKAfJSg7Dmprhb4D7EfJ+dvwHva27f50uCs
	 hgG82RXzwT0wgJvOr2Z/bvM/UPU3Zw2Pu4f9cfr3jGFqIspRLq2C66grd1SL813kgMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598606;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=81KFPaygbpyg8aEThKQOKRzNXk04+hHH6COSEmyUUXs=;
	b=zmgjxj2of9toIslYNN4SY1rhXEYZk3bb6czpXa2UaCETXn+/tFVX+jgsD50F2Yx1E19T
	 HKqZBppiKGtGIvI95GS8kcvjVsD5e70Nevw+iIP/w1SK6sGJL/uOq4UqXT3ViYpIJq7/a
	 leGbtsYrjw/LxiBZlBN2F0BsHLyls6HPK96pTn/IjlWt2GN4Y6HHeJZHx1RKlbiDLZY+U
	 b9zzdsL6tcgTemqcvZNsnqhtx699OicqT/zWme94maVptZMAl2LpbelfoeYwpde3L8GB/
	 fb80bwKl9dKKJafhJ2tqgfq0dy0n0l6Vl9q+ZA+A1t3sq+DoqtTbHOfb3GtDe7ZJVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzTqyZm3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMbyn8lG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471E606A333
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4471E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzTqyZm3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMbyn8lG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADJ0Wfi1102427
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=81KFPaygbpyg8aEThKQOKRzNXk04+hHH6CO
	SEmyUUXs=; b=XzTqyZm3kFEnhykhpyCnNSA3OlA+/FLDv1nwtp4GnYDuUHWnJHl
	VV6fqqcWK24r1dHwaTklPWkb1dS1VRANCRa19zSFX8hJ5oDw8Cx7IEAsKirX+o9C
	IH1lS4dfED8NDa1TJMkrrJoUOjzHOXCYBALg5XOUAdnGXFjDrWA87oRFqptRVe7D
	VND8CwarYCU8Sl+7b5zoTd4QQEdFMSqB3XsbGy0lRvGcseQJeAISroCO2I5kN913
	CLKO+yTR896Zl0cbgiEyi1zUU6pIkzsg7LwUUZV+QAPOFqYLPCidwvXg8cec5wsx
	gCeEQmCLYpCAXFv1Ai6k4zJN4vvSV2H6M3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwcj03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:36:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so277899485a.0
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794598604; x=1795203404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81KFPaygbpyg8aEThKQOKRzNXk04+hHH6COSEmyUUXs=;
        b=AMbyn8lGT4Bgy1io/vlUzCeGOfsdWRO3IDiY3OrCkLZlUPivB30bC+LtW4+WG4K1IQ
         5wzqKOE7CuRwVcX7xbr8BdcZH5arU4OXnWiN5/hz3rTlk9gXPAHgf1J42jm8o9aHz1QM
         GneSlgVk0ZkWXGLGvqIIYNJxIAG/njnkIvNl0M8Z2Ms8bqIqLc0mUczAWG7lD9wjJUw/
         MWExNtxiIOAevOqCbBj312UYQ4nYL5vWrBEn+DDaNOBNmXIgcftCke0LVUwfs7lzOKWY
         WiCctDzCsGCFKZKhWZgbiKqXwkRGS4YF2Yzdd0LHMckrXF3W5aRctCnonqopMdCSIgBe
         3woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598604; x=1795203404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81KFPaygbpyg8aEThKQOKRzNXk04+hHH6COSEmyUUXs=;
        b=xkZuU8uM2IpcN5erzWWENr7tXjsNN+/npUtedgrNmmNQocwnPxnHKbTkdgyMZevjBc
         i2s0vWlTuKhAIwODri4TgmayFMc581z+LxK38cBIFW17tvNusHIyAfh3+HAcFBrT/F+j
         q//h0vC530uhyuI26JWW8mgWDZmSBuvof+Mimax6hGgJJLsKOWoL+b91PBEeOcPtYfxg
         fSCcA1NEzHu3eJ3/EJaVoUMSksFtFY2k4j2HfNOYGLSF7Jhc8XHwqzEh/3cVAshCTBOy
         10GvYtPQ3d+AciDHdYrx3BA2hRAniRTPa5NkGajVlJO88/yYAHZERA8GWpjf6ZW2o1xE
         TJsA==
X-Forwarded-Encrypted: i=1; AL+hErHKglc4Ragnp4HHGfyU1nqzuksVFE1VFu++H2rN6007oP7DAKE6R0dq64G4XDQCCdhqY0i8VWLB89Y4JwdS2R0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SLrCdD+RNOPzEdq0hUaFurdaHYgnJgUrvkNACWC28TNh5WCy5
	9HiR0NuAfC2NqerThAzD581mYvV5mdKAYWK2r/5EF0o0CP/leXUe0Jm8u4NMfTu/c3DMHePGe2C
	aikDplDMShFbumVSfRny4bSi4qdwC1t/l8gq5EpHfKc3diGG04blHWKxzTAiM87y5Djxd2ZM=
X-Gm-Gg: AYBFou2nZMiEukRePQOfkuRgkpdo5+PyY+S3+b/14NxdXfbly2peE4L1CJw7I4uOFZS
	pbWXUI55UvagOiPvKEWPB5gMGK55hB4ree/QZWIL0vYuiqFaC/UOYmh2pIWsgIH7QTZ7uNr8NXQ
	wLajEPAeLvmGpMhZiGy8jAVP7dfs/YCc1kYf9dAgMQgXPPOpuhOXAbbh396NaLYUB+nbfXXuOWM
	IzPklFKDCS/D7rkjAaI2VME+uNgm/ZI7g7JvDcP1hKs+WkPs9vwsEiChrikn841wiDHvVwURhz2
	Z+2RLMgZ4iKoQdXpUQrHRMILUZVjU9Tj2uw44aIK8wopTyCn1AQqMpG2Z/C8bFrAl1qhCVlUPZa
	JP8J8WDs1OF5PzJKuBsfGwhNXkLIvYNKOCVGYQ1WhxzwyvIe89vkYyzfbgo6/4eqUp88RC1QHbF
	zyij3oYH5mDVwB2a8kWw==
X-Received: by 2002:a05:620a:6cc1:b0:93e:c12d:4ecc with SMTP id af79cd13be357-949331a016bmr1101647885a.44.1794598604243;
        Fri, 13 Nov 2026 11:36:44 -0800 (PST)
X-Received: by 2002:a05:620a:6cc1:b0:93e:c12d:4ecc with SMTP id af79cd13be357-949331a016bmr1101642885a.44.1794598603784;
        Fri, 13 Nov 2026 11:36:43 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da11c5sm6268876f8f.54.2026.11.13.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:36:43 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, jarkko@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/2] tpm: OP-TEE transport core for discrete and firmware TPMs
Date: Fri, 13 Nov 2026 20:36:32 +0100
Message-ID: <20261113193639.4020859-1-jorge.ramirez@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af766cc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=McN5tr3TAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aTdWg_Z3cYdHtKX5QXYA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=OiMWn5MEmObRqTLTTlUg:22
X-Proofpoint-ORIG-GUID: RqEmRZ0FinCg7q136wQXs7MjeKR6TT8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3OCBTYWx0ZWRfX0Ich82i8W4Xy
 R2g36T6o5l2Z0msoJevEwZ+2e759cFaKuEEbMj2jd6R61oBOY+7gprODNTWjwOJWAaVQDDgmBCf
 RGrGRllVlu/6MC2RX6knELfVsSWE7hGNsIfpnZM4FKN2z2LwOT16yy9SNmvTa5NqOigRQQYSLOC
 kb+BnxUgwwevD1gVPSpXDt69xkI7Pky5e26DRF0TV4lTZsnpqapyOVVqb/4benaDa2gb+KMTcma
 QFoLh1pgwTfzpvMXWVjb2Kb2yjA7ZU5q3L4Pp69Cmsc35UtPP5tYD2QN47Avw09QaWLRYneoTwA
 DtXaGTW0NKq6GbBEGca9cgWkou3Ig9a2VWpHeC1IMy+ghNfnYM0vKniWgES7H7Wn+tYDEnBi5/B
 /FeH1I5SZH0IEGsPVRaNKhN+mN4S8fGXgSVmYbYGCxLxqBFfFJIbaCgx1o+qWHkwSNc28/4hJWf
 uRBU3u3KWWw2xlxgxwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3OCBTYWx0ZWRfX2HYISLvCuV2o
 BWWX04BGwuXLDMuWq4dufG8Cmu1GbcqCHsm/J47JKKHLkXq8UIxr/YbA9lksSVn4+seLABxCcWW
 q+Qof6DHXrsbAyBhB1za/Rqoz5iUYdE=
X-Proofpoint-GUID: RqEmRZ0FinCg7q136wQXs7MjeKR6TT8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130078

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
v3: https://lore.kernel.org/linux-integrity/20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com/

Changes since v3:
 - rebased onto the tpmdd tree, which already carries the treewide
   devm_kmalloc_obj() conversion; the series now applies cleanly without
   the merge fixups that were needed when v3 was picked up.
 - tpm_optee: allocate the private data with devm_kzalloc_obj() instead of
   devm_kzalloc() with an explicit sizeof(), matching the type-based
   convention now used across the tree (and already used by the converted
   tpm_ftpm_tee front-end). No functional change.

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
 drivers/char/tpm/tpm_ftpm_tee.c   | 294 ++----------------------------
 drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
 drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
 drivers/char/tpm/tpm_optee.h      |  32 ++++
 drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
 8 files changed, 414 insertions(+), 311 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
 create mode 100644 drivers/char/tpm/tpm_optee.c
 create mode 100644 drivers/char/tpm/tpm_optee.h
 create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c


base-commit: c3d9e7297e8d1934c8f2aaa0b9d82018ab15376e
-- 
2.55.0

