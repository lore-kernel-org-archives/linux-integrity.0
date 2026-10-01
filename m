Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316C3B3891
	for <linux-integrity@vger.kernel.org>; Thu,  1 Oct 2026 05:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833848; cv=none; b=nDefWdE+2p1ysbsJtcfTv25UwW++cGoxPVWu4et70VXh/PbBUrtiXvAsC+qYPz9JhZV8CWvWouGl+MxHfzN/asbc3xlIi87EnJ5y7AEUl1uiQnxL3k6N3oxDFS1l1/Suj94w+A8BiKkg7LHp5FUV7OcTyTdOY5KpeQrGdCuC8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833848; c=relaxed/simple;
	bh=LHvwzomglSZ+GGcJZchaw/w0UsqiVLKCXgj9Oi0J3zg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LhhZJc3im48lo0R7ViW9UnETdIrMY4yo38wKnklvywJHWr4qfz617yhCR41yROWD/q6IdF1qxLK69rr26uUlIox+GpEJjgoRD+auyALtncBWnv7Qr21a0+44FaBw82vi4AXAcCpJiuKLMm399JxCwpNDeRkRloPvuSeMzt7Bht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ANBwIvp1; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ANBwIvp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1790833839; x=1791093039;
	bh=8ksQy6MeanfkvfpHQut3hQ6xN1hUcsCd/pALFRS+d1A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ANBwIvp1/ocowntL22wAN4kLe7moxsFWk60wzZE3feu/nI9zJ9GkL/LVDTmQfALs0
	 MT0ibl8G+v0sTu+q1a/5/9YbOSL05r7wkKQfsvNCuUT9QI22m6n6V5lS8Y+PVSm1PZ
	 rc5RG8Auvi6ZxLGOBwnd+TtghDLlK99wxbrybcfNBtefVnB0L/xBVsB2WcEWWo9Z/2
	 e0OIKnbyv1DbhM3h9st1lSUufUFNAQjAWUkfoXALpfl9UHQTJn29CFSbHiysqNaEMB
	 mNz+uqjE+XWErGXSN22IQhwduzO7NKdQShrikpq78ljeR8IAJrn4OqjosTBx3B2kse
	 aWg1T1dLu6yNA==
Date: Thu, 01 Oct 2026 05:50:34 +0000
To: kuldeep.singh@oss.qualcomm.com
From: zeroknots <zeroknots@protonmail.com>
Cc: amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <20261001055029.1960743-1-zeroknots@protonmail.com>
Feedback-ID: 44664438:user:proton
X-Pm-Message-ID: 5be19f9a5cd05f46b76827da84152667a78aadda
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kuldeep,

A data point from retail hardware, in case it is useful for this
series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
is present as the QSEECOM application "qcom.tz.tpm".

With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
(UEFI secure app). On the same boot, qseecom (version 0x1402000) works
and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
-ENOENT.

The Windows driver for this machine agrees: QcTrEE8480.inf configures
the TPM service with AppName=3D"qcom.tz.tpm", SecureApp=3D1, LoadApp=3D0
(preloaded by firmware). The EFI configuration table carries the
TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.

Through that app, using a QSEECOM transport (based on Xilin Wu's
out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
verify, and a sealed object that persists across reboots.

So, as far as I can tell, retail Glymur laptops may ship firmware on
which this driver finds no TPM, while the same TA is available over
QSEECOM.

The same applies to the prerequisite series that moves uefisecapp to
QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
work only through the QSEECOM uefisecapp. If the QSEECOM path were
dropped for Glymur, efivars would stop working on this machine, so it
would be good to keep it as a fallback when the QTEE service is not
found.

Two questions:

 - Is service 81 expected to appear on retail firmware through an
   update, or is it specific to the CRD firmware?
 - Would you consider a QSEECOM-based path for such firmware? I am
   happy to test this series, or any other service UID you would like
   checked, on this machine, and to share the transport code.

[1] https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v=
2-0-b8a8fcbe4211@oss.qualcomm.com/

Thanks,
zeroknots

Assisted-by: LLM (analysis and drafting; the measurements were made on
the hardware and reviewed by me)

