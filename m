Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987541;
	b=FcNZU6QmtJViQSImjFrKlcw2tw2Rl5grF+mQst+3VE6/bKDVbBv7ZSPW/esmgNxOCICV
	 nq71rDwomFNtucDnMMjNV6iAux0/tib6LWEEKVaPLpLy1umeNq/HAp0kGlIdnfFzyZk2k
	 NE19u80laUiXQ1ltjl2Vhu/+yWnuUKManlU2BYyaZrkx6J8KfqttewFUWya4pxiZbVFNM
	 yNheyChrZAjGBivNJ4B91xrVmw3OMrKKMlGqEp43D1AXYCv+l+sLdVbvhCKVRmfQL4U9N
	 W8IbXFm8oSXjnEcS5w+nqcdsNFLE62YGVHFeCgmkX2xPbMNgfU3jiXMv9NN2pAVJ9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987541;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=OJgQQYxJs0Sb7LZKdrxdw/6+xeL6InZ2RrNS/V3saLk=;
	b=SkH462/UReJ+LtWsyUIiJwyOAYY9mo+Z/1GLqjVqR5KxX0zcfVH3/QOSCuobuMgWEE9r
	 MQuMEv1927A/zR9Ge1s5vF6igEnoLRmqWujmlHfWg93ASeMG5aGW2zxXQsCQaxDM31VPr
	 uG8w7LBcbqQuUlxCGcgo3Kip+D4GOvNK52vyOZucjcVtjjmPILwFBH3fYvfclXwIi/3BE
	 sDAKqwh1BROja++am65mr7fceDhSlBONwfscgGZ+uhl4w4XTmglj9pFnJbYT0WB6z2r3a
	 8WFnV87morXb7hzF0bAemyz7giRMDjaP6SAc3F1ZPe0Kl/sY3YIPK8FGjByL8xlvKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T5cwlpCS;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F92606A325;
	Wed, 18 Nov 2026 07:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F92606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T5cwlpCS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794987540; x=1826523540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJgQQYxJs0Sb7LZKdrxdw/6+xeL6InZ2RrNS/V3saLk=;
  b=T5cwlpCSeZFPTiF5VOKaisk5K2Zx6UBNOJ4HMAgytHL1003xWCTyPqn4
   t6bjw3ACbpOm9m1HkrZaPI50SlXeEK23YWFKDerXjUGkFmy+6ySWXE9Yl
   cC13GaZSgAwptC7SXbIund24isTA2V7jEOU62f2ruucaWdeT4dB7AaNk3
   i9culIkVDctl83m8ALACZSrdMym3yNrmIKv1GjbXJPzikNgqaInfNsk5I
   EwyFsxXiIHTSMzXg8atsXR1j5UNBdBh7fJ1eqSWNZsbTQ8i9lZv/engp0
   klOqlm6tvA1KgRnfKqpymsXpK1Qgpgqmz+YfQiC0AJdkFdAP2fy1IOsV6
   w==;
X-CSE-ConnectionGUID: wsIhGAYsTb6lBq+7A+eYqg==
X-CSE-MsgGUID: bEHT4r7PRCuqWzjp0L+Khw==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34489208"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:38:58 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id bdf68e22-b966-4573-a584-d8d0f21a771c; Wed, 18 Nov 2026 07:38:57 +0000 (UTC)
X-Farcaster-Flow-ID: bdf68e22-b966-4573-a584-d8d0f21a771c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:38:57 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 07:38:57 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, Jonathan McDowell <noodles@earth.li>, "Breno
 Leitao" <leitao@debian.org>, <nh-open-source@amazon.com>, Alexander Graf
	<graf@amazon.de>, Gunnar Kudrjavets <gunnarku@amazon.com>, Josh Levinson
	<joshlev@amazon.com>
Subject: [RFC PATCH v4 0/8] tpm: Rework timeout and duration handling
Date: Wed, 18 Nov 2026 07:38:44 +0000
Message-ID: <20261118073852.81107-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Review of v2 [1] asked to redesign how the timeouts and durations are
handled across TPM families and drivers. This series is my attempt
at it.

- Interface timeouts live in four fields, TPM1.x duration in an array
which uses duration class and TPM2.0 in a different map with raw time
values and other duration macros. Move interface timeouts and duration
classes to a new struct called struct tpm_limits embedded in struct
tpm_chip so that core and most drivers read them from one place.

- Currently it's left up to the driver to initialize the timeout values.
During probe, core/driver runs tpm_get_timeouts() which on TPM1.x
queries the TPM for timeout values. The transmit function used for this
request uses these timeouts for the state changes which can be zero at
this time. I found a case with xen-tpmfront where it calls tpm get
capability with TIMEOUT_C at zero. Hence the limit table is initialized
with default value which is highest among both TPM1.x and TPM2. This
makes sure driver is not missing to initialize during probe.

- Add module param option for all duration and timeouts. This gives an
option of passing these values via kernel command line.

Current flow:

  tpm_chip_alloc()             Each driver sets its own default timeouts
                               or none
  tpm1_get_timeouts()          reported values, ->update_timeouts()
                               and ->update_durations(), into
                               jiffies fields and chip->duration[]
  tpm2_get_timeouts()          fixed TPM2_TIMEOUT_A..D, no driver hook
  tpm_calc_ordinal_duration()  chip->duration[] on TPM 1.x, a fixed
                               per-ordinal map on TPM 2.0
  tpm_transmit()               resubmits on TPM2_RC_RETRY until the
                               delay passes TPM2_DURATION_LONG

The limit table is built in fixed order starting with family
defaults, reported by TPM chip, ->adjust_limits, tpm.limits= parameter
and finally the validation that checks the bounds. This also adds
a visibility to the source which sets the limit eg: default, TPM,
driver, param etc.

The flow after this series:

  tpm_chip_alloc()
    tpm_limits_init()          larger of the TPM 1.x and 2.0 defaults,
                               tpm.limits= and bounds check
  tpm1_get_timeouts(), tpm2_get_timeouts()
    tpm_limits_update()        family defaults
                               reported values (TPM 1.x)
                               ->adjust_limits()
                               tpm.limits=
                               bounds check
  readers of chip->limits
    tpm_try_transmit()         polls for completion up to the command's
                               duration class
    tpm_transmit()             resubmits on TPM2_RC_RETRY up to the
                               LONG duration
    drivers                    tpm_poll_timeout(), or the limit in
                               jiffies where a driver counts jiffies
    sysfs                      timeouts and durations, on TPM 2.0 too

This changes some of the existing behaviour:

  - TPM2_VerifySignature waits DEFAULT 120 s instead of 30 s.
  - Completion polling first sleeps at most 100 us instead of 1 ms.
  - Until the timing query runs, tpm_crb waits up to 750 ms for
    TIMEOUT_C instead of 200 ms, xen-tpmfront 750 ms instead of 0, and
    st33zp24, tpm_i2c_infineon and tpm_i2c_nuvoton up to 4 s for
    TIMEOUT_B instead of 2 s.
  - On TPM 1.x, an ordinal with no class waits DEFAULT, which is never
    shorter than LONG, so a chip that reports LONG above two minutes
    waits longer than the old fixed two minutes.
  - The timeouts and durations sysfs files now print exact
    microseconds, and their "[adjusted]" marker also covers a value
    changed by validation. TPM 2.0 chips now get both files too, in
    /sys/class/tpm/tpmX/. tpm.limits= is documented in
    kernel-parameters.txt.
  - tpm_atmel, tpm_nsc and tpm_infineon never query the TPM for its
    timeouts and durations, so their sysfs files now show the
    defaults, marked "[original]", instead of zero timeouts and an
    empty durations file.

I ran each patch in QEMU with swtpm, on TPM 2.0 over CRB and TIS and
on TPM 1.2 over TIS. Every boot answered commands and the TPM 1.2
sysfs output stays the same across the series. I also fed tpm.limits=
values below the floor, above the ceiling and malformed, and with a
local test hook held the TPM in TPM2_RC_RETRY and stalled completions
to see each wait end where the table says.

On an EC2 instance with Amazon NitroTPM, I ran a GetCapability and hwrng
loop through repeated periods of TPM unavailability. Kernel without
these changes logged "tpm2_load_context: failed with a TPM error 0x0922"
and every later TPM command failed. With this series applied, no command
failed.

The idea for this series is mine. An LLM coding assistant helped draft
the code and I reviewed every patch myself.

[1] https://lore.kernel.org/linux-integrity/atLD-d1v1B8ARv7x@kernel.org/

Surendran

V3 -> V4:
- Add a header comment to tpm-limits.c describing the limits table
- Export __tpm_poll() and make tpm_poll_timeout() and
  tpm_poll_timeout_us() static inline in tpm.h
- Drop tpm_limits_apply_quirks() and struct tpm_limits_quirk
- Keep the existing tpm_tis timeout override table, and set the
  NitroTPM limits in tpm_crb with tpm_limits_driver_set()
- Drop HW_ERR from the "Adjusting reported" logs
- Document the TPM 2.0 timeouts and durations paths in sysfs-class-tpm

V2 -> V3:
- Replace the TPM 2.0 duration override with one limits table for both
  TPM families, built in a fixed order and validated
- Replace ->update_timeouts() and ->update_durations() with
  ->adjust_limits()
- Bound the tpm_transmit() retry loop by the LONG duration instead of
  TPM2_DURATION_LONG
- Add tpm.limits=, and show the timeouts and durations files for
  TPM 2.0 chips
- Move the NitroTPM values to a tpm_crb quirk table, raise its SHORT
  and MEDIUM durations to 30 s and its LONG duration to 45 s

V1 -> V2:
- Drop chip->busy_timeout_ms. TPM2 durations and the TPM2_RC_RETRY
  budget now come from chip->duration.
- Map TPM2_CC_SELF_TEST and TPM2_CC_VERIFY_SIGNATURE to TPM_LONG with
  floors of 3s and 30s since their durations do not fit SHORT, MEDIUM,
  LONG durations.
- Keep the TPM2 defaults for commands sent before tpm2_get_timeouts()
  has run such as the one in tpm2_probe() and keep the 2s retry
  budget for TPM 1.x chips.
- Keep the first TPM2_RC_RETRY wait at TPM2_DURATION_SHORT instead of
  chip->duration[TPM_SHORT]. No TPM2 command maps to TPM_SHORT today
  and a driver that raises TPM_SHORT for its commands should not also
  lengthen the first retry wait.
- Return early from tpm_tis_update_durations() for TPM2 chips, since
  its overrides are for TPM 1.x.
- Raise TPM_SHORT, TPM_MEDIUM and TPM_LONG to 30s for NitroTPM.
- Replace the vendor quirk table in tpm_crb with a plain vendor ID
  check.
- Use the TPM_CRB_ prefix for the new tpm_crb macros.
- Rename the patches from "tpm: Add per-chip timeout for transient
  unavailability" and "tpm_crb: Raise timeouts for Amazon NitroTPM".

v3: https://lore.kernel.org/linux-integrity/20261112163846.97654-1-surenkj@amazon.com/
v2: https://lore.kernel.org/linux-integrity/20261016043733.30589-1-surenkj@amazon.com/
v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-1-surenkj@amazon.com/

Surendran Kanagaraj (8):
  tpm: Add a single table for all TPM wait limits
  tpm: Wire the timing setup to the limits table
  tpm: Take command durations from the limits table
  tpm: Bound core and CRB waits by the limits table
  tpm: Drop the jiffies timing fields from struct tpm_chip
  tpm: Add the tpm.limits= parameter
  tpm: Show timeouts and durations for TPM 2.0 chips
  tpm_crb: Raise the limits for Amazon NitroTPM

 Documentation/ABI/stable/sysfs-class-tpm      |  38 +-
 .../admin-guide/kernel-parameters.txt         |  13 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/st33zp24/st33zp24.c          |  28 +-
 drivers/char/tpm/tpm-chip.c                   |   1 +
 drivers/char/tpm/tpm-interface.c              |  72 +-
 drivers/char/tpm/tpm-limits.c                 | 427 +++++++++++
 drivers/char/tpm/tpm-sysfs.c                  |  29 +-
 drivers/char/tpm/tpm.h                        |  63 +-
 drivers/char/tpm/tpm1-cmd.c                   | 669 +++++++++---------
 drivers/char/tpm/tpm2-cmd.c                   |  80 ++-
 drivers/char/tpm/tpm_crb.c                    | 107 ++-
 drivers/char/tpm/tpm_i2c_atmel.c              |   9 -
 drivers/char/tpm/tpm_i2c_infineon.c           |  25 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c            |  32 +-
 drivers/char/tpm/tpm_tis_core.c               | 168 ++---
 drivers/char/tpm/tpm_tis_i2c_cr50.c           |  15 +-
 drivers/char/tpm/xen-tpmfront.c               |  10 +-
 include/linux/tpm.h                           |  66 +-
 include/linux/tpm_ptp.h                       |   9 -
 20 files changed, 1179 insertions(+), 683 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-limits.c


base-commit: 8054cba7f0619486c237b21bd257a4544b5de455
-- 
2.47.3

