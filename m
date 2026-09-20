Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF923E334
	for <linux-integrity@vger.kernel.org>; Sun, 20 Sep 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886008; cv=pass; b=gyxuwEwImr+fiD+pi0AoDXgYCWoElYxvmeiHWcyHWHKPFQcWpWcHEpTjPYzg4Nnuvag1w9ZGkSqa4DOFe1HmOHhHErE6PthCH0c+gy1mj9v+XZ3xxoGrdR9J0JdIiiUJKsBYBT963bj1GXBFa/eplmUny7lGjvVEiVloVLp6i40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886008; c=relaxed/simple;
	bh=zSVFVOdh1zsub7yTm7mZlMF70KBbf/y6lmir71eMvcw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WBO8NwAymyIQxVQ2/FTt4Os6QikZ5U0g8HoopdkY1leG4eIi4H1L0b/j8KUHFuA9sHgjuCn75+UYFuz80rljPjujki5PFgVgSfTWAkdb8meSNyaRj7vCgVhe56EkNuLjKsa9K4jNJSC1+bM3+cl9K4I62COE9uIO9wpv9dGN/NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyMDgRUN; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyMDgRUN"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso14259341fa.3
        for <linux-integrity@vger.kernel.org>; Sat, 19 Sep 2026 23:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789886005; cv=none;
        d=google.com; s=arc-20260327;
        b=o6XkL87/h3GuiC7x0EHRu7JEJeLCr8Rd7erGiEyPqyN5nVWkgKghkrkxD7wfIGxvoB
         Pjw1Pm2DCT3MsNUtr8hq/8zziDE0uIArGluRbyi7ZOOtHnUqg+kEw9F464AiXAsBNd3C
         6HK47Mqygt5DfrN0Y4uDuREWtGfEbr7+b6CV7JTcsL+PDLMdGqSLihhSXjU196T5KfMT
         TBv8lSgrpLsYi3PEKTSZFxz3W0y5yUmBrKXmZxwCwAna1BMSsuwDFhY7p02SmgT9zQ+u
         NdgsXVL81I54BFySY9DQWBb1WyoOM+kdeFy9nd7G4Ag2pWGpf7NaBBBTogWQP0I55j9d
         fvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YCaFJb32tWeW2ZLjK9ZpU6RuTP5xgMmLUszdPvYrcg4=;
        fh=LyUMJfvW2B+5pICKNWBqwEY9MzixV9CTNRWigit3mJo=;
        b=a6UUW+U1xkP4J0E2ulqELKP/ZV45V784jlRoJhlNa0nCZ+oIdPiflBl9Uk6GjLwtbm
         XzSV8mqP7ERIbUNXO7Rmq3ZMxWm2Yh0lXCfkCVLLHFpUPFWtmbL9vaJvBi1QtoLk3OnT
         FcSNJFS8bV3sMRRZLYwllECacd/8TH1f/3bdBsWQnP6CBdHozJLyEu2TsJXz5b6lJgRn
         UEo1g2hQosfo5mL+0bqtwBFzC8tli/cHjHMix/dats896Un7GsbbGZvLW2n5ndaSuKWC
         dZU7y4JvSyeCOR3zEyoAwG8CQqLO22GzaoYuHj+irMXRarHsinaV4Z5xanNUkT8VN+8D
         d4tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789886005; x=1790490805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCaFJb32tWeW2ZLjK9ZpU6RuTP5xgMmLUszdPvYrcg4=;
        b=DyMDgRUNWnRz0hCzTY6uLJ9ep6YoXhKVuDrK6VOU28lZinrunKWu6xEC7NwwdHrMqo
         vDtc2z8ylACEmcZGHldUWcIqoxaoWa/MyZ8Q0AnH+QcfnNuUXszvcFIZqm4gLJBuksbb
         9Aj6Ov3Dot59kmzjgDB2hewMdZD0mCdOkqE9//+1IFM1po2IJQctR3ClWpYWfLEYIGEn
         Jpi8b2kPfYfEhNh3yb100TIiQ2Fl5a5cPO31mDACoUZMplYUD2v2ozHua3dgIJB7L17d
         nYGthHlf4LfG+72mrmjvP32cp3rKXkocFd+5yxD0GcUBbE1PC4kJ5EMDxt6glADD2Q9G
         dUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789886005; x=1790490805;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YCaFJb32tWeW2ZLjK9ZpU6RuTP5xgMmLUszdPvYrcg4=;
        b=sKCI/hyR9T1YwrTHiOMaHGMuilXUzdIEUoSD5aNfkqQu2wldlhPjyGwIQDCaxt0eEz
         6TBpQri4IfaBunl8THzZghMvaijSW3aQqardzlvKnFJLlWx6G/TTghsuIa7w9vr9P5WA
         9akybsxA2R7K9TmrEgr0cNJLdbcZ29z6PyN7C+/TCMrlsHyw5Gu9lfDXyTtVy3RN+m4F
         q7x/7K9aPTlJFEc46yvb2Y33dIXyfF0Labe5C642BscoaY/9xQMXGqGT7VQkjlopB5o4
         VKkaQLVXvGqjptTuBgOjs6XMtC/ljmjMkGVsCKTAzbB8b8U+ncr4fJVSMKgr9wwoUQUb
         I/Xw==
X-Gm-Message-State: AFuF++nDBVH57xtUuaGrgf498Vs8oqUTZ1i+/hSDFrJP7WxFFiZJ2fdA
	Q9O2jiZAdJZM9ndHjWHE9D5XNl2DGnLuubViQ1GE40Xb1MBbMX00Er/a0kln1SrAqJ58N5egEHz
	ygStkhqhoUrM3E0oLLCxsAjiWcQLuXqQ=
X-Gm-Gg: AYBFou0JVZnEZqyvmn0M8HtNR7yOwG+mhnowQmN78I0aLeeaSwGUOkJxd2isKFchZni
	+Zax9fnRTr7f1PqJbvtuePeqzdYEMPao68MYZehV43LtzG/WQKkIJr4menpau+72NfJ2TALuePd
	NgH3AMBGud8Wyl+a9iNptS4amtA79XDpCgigW++cvmG8F+t0GFpY1sZ3gVq+SHHzxL1XqxB8UwL
	MFV0PzClthC0KGiPCcGHlqZxKRjRDEYaXVB5sjCi2eYDKN2jblmshfeFxaptrp+dxGvt8SnB0hH
	Ag+ZnzFx6OtNLqGSbDSju5bypML6O5zrot4+EUQ7i3eKGtmGGzA=
X-Received: by 2002:a2e:b8cb:0:b0:3a5:a54d:c8cc with SMTP id
 38308e7fff4ca-3a5fbfdd6d9mr15728441fa.23.1789886004561; Sat, 19 Sep 2026
 23:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Delton Ding <dsh0416@gmail.com>
Date: Sun, 20 Sep 2026 14:33:12 +0800
X-Gm-Features: AcwNN1XBxdlrbnq0M3C_4Z6yGT1NmGRFssrIdBOlYnMsT1u8vBXvDFIZpg8SqPw
Message-ID: <CA+mXNo2bBZg69RkKYauV_+K5zp=1kuHm1xLPwD6_ihZ_MzL0SQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
To: jarkko@kernel.org, f13208471983@163.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko and MicroFish,

I'm following up on this discussion:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2652132.html

I would like to add a Fujitsu/Intel platform with what appears to be a
related NVS resource reservation failure. I have not tested the proposed
patch; this is an additional hardware report.

Hardware and software:

  System: FUJITSU FMVU14003
  Board: FJNB2B5
  CPU: Intel Core i5-7300U (family 6, model 142, stepping 9)
  BIOS: Version 1.33, 11/25/2025
  OS: NixOS 26.05
  Running kernel: 7.2.5 (NixOS build)
  /proc/sys/kernel/tainted: 0

On this machine, the TPM2 table specifies StartMethod 2 (ACPI Start).
The control area, rather than the MMIO range reported by _CRS, lies
inside ACPI NVS:

  TPM2 table (length 52, revision 3, checksum valid):
    ControlAddress: 0x000000008ff6e000
    StartMethod:    2

  Relevant /proc/iomem entries:
    8d77f000-8ff7efff : ACPI Non-volatile Storage
    fed40000-fed44fff : MSFT0101:00

  The TPM SSDT declares _CRS with base 0xfed40000 and length 0x5000.
  It also contains:

    OperationRegion (TPMR, SystemMemory, 0xFED40000, 0x5000)
    OperationRegion (TNVS, SystemMemory, 0x8FF6F000, 0x27)
    OperationRegion (CONA, SystemMemory, 0x8FF6E000, 0x30)

The kernel reports:

  tpm_crb_acpi MSFT0101:00: error -EBUSY: can't request region for
resource [mem 0x8ff6e000-0x8ff6e02f]
  tpm_crb_acpi MSFT0101:00: probe with driver tpm_crb_acpi failed with error -16
  ima: No TPM chip found, activating TPM-bypass!

Neither /dev/tpm0 nor /dev/tpmrm0 exists, and both /sys/class/tpm and
/sys/class/tpmrm are empty. The ACPI device has status 15 and an existing
platform physical_node, so platform device creation itself succeeded.

Based on the ACPI tables and source inspection, this appears to reach the
iores == NULL path in crb_map_res() when crb_map_io() first maps the
48-byte control area. That area lies outside _CRS but within the NVS
reservation. This is an inference from the tables and error range;
I have not instrumented the driver to trace the call path.

Earlier boot logs show the same error and address on BIOS 1.10, 1.30
with kernel 7.2.6. I do not have a known-good Linux kernel on this machine,
so I am not reporting this as a confirmed regression. The TPM works in
Windows on the same machine; its TPM firmware has also been updated.
The vendor of the TPM is infineon, but the exact TPM firmware revision
has not been collected here.

The missing devices cause systemd 260.2 to wait 90 seconds in the initrd
and another 90 seconds after switching to the real root. We have prepared
systemd.tpm2_wait=0 as a local workaround for the boot delay; it does not
restore the TPM device.

Does this look like another instance of the NVS mapping issue, and is
there a preferred revised patch or targeted diagnostic for this ACPI
StartMethod 2 layout? I can provide the raw TPM2 table and TPM SSDT,
including its disassembly, if useful.

Best Regards,
Delton Ding
