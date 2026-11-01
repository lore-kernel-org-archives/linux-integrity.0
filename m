Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793496166;
	b=vfZZJHb+Ce3LR8K5Fa9WRBWDbmYs26L9nf9qUM2hIVQX0ooKRXANBuziquRYqFUEpqNk
	 GBpoXqTkCugaHpOANdrL8Rn6Hn5qTzkSFvSmPVxG8v8o7Xh/FnA00DAl+WlTViroWqM6W
	 gVIXcbQzBh4ZwSzsyZ43SnFyuySqw07Q2P7x7sdy8j4J/KaSphEdcVhS8q7zxJdeaACZ0
	 nwXsU7mEyBbmCHaOywiehagHtf+yLi9NyBx6IXd9cXI8GcCzrci67fAEQfzxv4eC/+F5j
	 d3aUtuHpg0K3BsDvmr0AQaUPMCms1UnfA1XQ5nY3f8jH8qB6plqhNpx78rj4mQzgx9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=adZ5p/K2XCIc9ZIqatzmVAiyk3FpES3PeTW7T0laFOY=;
	b=h4uy63P9iGOharuUjB4n0qBkqVpbynbk0nZ88JrQOZOMAvyoOyffOkSxoE6fuLEP4FSL
	 paivx+F1rVvbvgM0z1tHsJOzzbRGacEhAkT2uh7DE0vHbuvfzIoQM+X82CxuJNpjc7+0B
	 yl3k5NgR51RcsDgarwSV/SQWr4HYK7Llu566TrvjgNzoL2z1s5BXJe/tL8WvbGEa/OJCc
	 LPrqR7ba+q9zlS2swuG3kNN5U6CiVX1M2S+cMMIRIrD17RPariSRwE8d+wd4B8qbZLxOp
	 eHckRJeLSAXYqPJi2/5FkqnM3JnyPK0O/Y+pr7ikkWZoYsLI4A2G6rJFGRa6YqwsEHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6HsXY5X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AB606A31C
	for <linux-integrity@vger.kernel.org>; Sun,  1 Nov 2026 01:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6HsXY5X
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1bfd1373so14114591fa.0
        for <linux-integrity@vger.kernel.org>; Sat, 31 Oct 2026 18:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793496165; cv=none;
        d=google.com; s=arc-20260327;
        b=OGnF+/PH9ZVzu5OotdaVBBVbRbis8XwjVx2JI6GfLxFml356S46KNzxBetYo0OPKc8
         KX8wTUZEVnuw7S9hl7gHsKyMJavvu+WbaeiRJlr/PVIG1HeQimC/DhqTVv6ErJOGt2PJ
         jXO1+x+lloRm10w7Iy5DCF32zhvztHKFLCrCupCgMXXmq/XHnrlUstpZ6NBtXq3bf9s8
         RlmY6jiW6DgKbUDACvqubYcv78OE31kqOf7ZWcXAonMrYcJCn+oEreP6uHsfkZXJZW+o
         L6PxgR3QpYGm+99n9tSEobi0X7qPNON5NqVNvFMF/sqcBbT4UdBWiOLUvgoJ1mX11gnx
         VVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=adZ5p/K2XCIc9ZIqatzmVAiyk3FpES3PeTW7T0laFOY=;
        fh=BsiW9mzsWPq4tdgivAZblYUavjF+JBLZRDzt33flqt4=;
        b=MspumVyuxkAtAgRipg6dmiiQHLIL0TJY0RdCr736IJrcFhjBWB6BNkNlB1bClJ+oSv
         ucl7M0F4ghVzKSbB0kiGftuo50Y/OQLr8sKFdsU8qj7BpSnWX6LkmaalaDe0rce7rVHP
         0uBdCXrS3IGfx6yUBcYn0Tv/SPyzHs0RbQhQChNUA/AJHUOKRAiVB+IP862DnEQqp3sD
         kxhmFzwKBypFusSfe6SuGFYcaBa5eWDfhhi/IFgdt/1UTZ0olQYjgtOrsuhJ7kBgYvEM
         cculyEfMhaHokbH6yIotuXI1bhbC5MMnxXixdYf/h9kHyB2oeCpk1FSMqiv2B+YDto+G
         XUeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496165; x=1794100965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adZ5p/K2XCIc9ZIqatzmVAiyk3FpES3PeTW7T0laFOY=;
        b=b6HsXY5XE7IPWi9g/1jpJ3BYdBGP/lGp1yvcLUkYy+SG81mBVMk2iiJFM1+4/TYyAa
         FAy86ioLWJE5Wo6AoxD/8lJLhAeIPptRVzCxhTd+p12b7CenT2mncUjBtWDaQg9ZHDRK
         YM0OjxUB8C/coZFl1t+j4F+6Derx63qGUvgxO1hM93LUZc0KzQebGAoYhk0L1VpddaW5
         s97knUE4D8D8fr885TWBJjYNEXZuK5FisOqbN332fFKZBPMA9+Su3uyxv4GG1wCBdnKf
         saoG/Vncdgq9mJo3nJrSJvmY7uJG6KOLaVZIyCWhWog45NCS6FG1HsRKkANQ36WoCu09
         YnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496165; x=1794100965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=adZ5p/K2XCIc9ZIqatzmVAiyk3FpES3PeTW7T0laFOY=;
        b=tEZA6DPav5uKJOvG8fiLrKNohexAoOLtYo/aLAdeV+BMC7Nsw3fyWvbk9yZb1KE613
         jzc+hOdmqSf1yv5IUea+WvHFtFUGabWjadpzISRCBnaQhLRC5SN3iYJgRe21J6J5eVOm
         55r84yr0YqT36cUrKxeh4cqMw/hS1EX/wHwJwvemenWrH3AwpfEcROIPZtSlwhoCWirF
         dV19bHPJJiYwA3h9nyvD5w5MPXRxYGQ8Ot3gkkg7G5k/oPdsElIaGUEV9P7+csa17g3r
         ftW7mrHag4Blfx4CgYcDAcjTnjfO5SFwVRlURxYsW7ttG8S87Vk8b1wVTvYDOtOgF7uo
         5PBg==
X-Gm-Message-State: AFq9FYKhnWeo4rvh7SjWL5ZF3f4q4nZvLrYn83U93DLtnTn+RTVN7puY
	1Eh+eS5Fq8PUmy1dWJMcK9IM2/tA494k68hnjv05yzcQ2sD6ZnzUIZ3YSi0KcPplAgWrpYjmjKj
	PWP78FBdPgqzimpjv2qK+6Oarc85RILE=
X-Gm-Gg: AYBFou1AE29p0aDODgeizy7f1GY26mYtlEhtuCto5gqxw/TzMSC7gqqmcT3ydt6n53u
	NfJB2z9RZ5TYIpx6J+KyWyCp60Mg85XEHyQIxHLWMf0Hm2Y5kDH1Dbgts8Gjcfjcg28eIqr89ti
	xmsEVHTFeZ1URJn045Tt6ZqfOMz6ULkRmBpwxEWI1sHNF73HbhRbzkSKgv179hmdKknxY9iodER
	3jE9kgIjglAmqNCZFr6s2K82Y+4NygDXRD8fCapxApmM60qRLl2Klq/89xmxUAHF7mBls9GYIpf
	bFvATEo1lx1nKJ0qyfAgMlVUEMbrkCZENMlvZBrHVSTwvtSDpkS4tiuYve4PGKcabcS7OGqziMK
	I6KmO0MGhKRN8lxB9TVcnrZi9C4F7FYPOVDNyiQ==
X-Received: by 2002:a2e:b88b:0:b0:3a7:6d4a:1c9f with SMTP id
 38308e7fff4ca-3acb7aacdebmr14873131fa.15.1793496164431; Sat, 31 Oct 2026
 18:22:44 -0700 (PDT)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Sun, 1 Nov 2026 09:22:30 +0800
X-Gm-Features: AclHuK9RPpmNuHM5PN_mRaWc7TyMYbicYKkLqhZYUNjB2KAFRdCXF3Uz9Bd0vog
Message-ID: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
Subject: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux 7.3
To: peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, Jarkko and Jason,

I observed a task hang in vtpm_proxy_fops_release() while fuzzing the
vTPM proxy with syzkaller. I reproduced it on Linux 7.3.0: the campaign
observed the hang 4 times; replaying the stored sequence reproduced it
once in an automated replay and three times in manual replays. In every
case a process is blocked for 143+ seconds in
vtpm_proxy_fops_release() -> vtpm_proxy_work_stop() -> flush_work(),
while at the same time the sysrq-t dumps show a chip-register work
(vtpm_proxy_work -> tpm_chip_register() -> tpm_chip_start() ->
vtpm_proxy_request_locality()) running on the tpm-vtpm workqueue plus a
backlog of further queued chip-register works. Which queued work the
blocked release is waiting for is unconfirmed. All logs end while the
task is still blocked, so I cannot say how long the stall ultimately
lasts; I am not claiming a permanent deadlock.

Environment
-----------
- Kernel: 7.3.0-kernsight-kasan #1 SMP PREEMPT_DYNAMIC, built 2026-10-20,
  x86_64. Vanilla 7.3.0 source tarball (sha256
  87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f004953),
  built with KASAN/KCOV. No TPM changes were made for this testing
  (drivers/char/tpm/ matches vanilla apart from build artifacts).
- Guest: QEMU/KVM, 4 vCPU, 6 GiB, 8 scratch virtio disks, 2 NVDIMM/pmem
  devices, 2 NUMA nodes (the syzkaller standard environment). A fresh VM
  was used for every reproduction run.
- Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+
  (2026-09-18). The "+" denotes local KernSight integration changes
  (seed ordering/state feedback: pkg/kernsight, prog/kernsight_*,
  syz-manager/kernsight_*, pkg/execbackend, snapshot support in vm/qemu).
  They do not change the TPM syscall descriptions or the executor
  semantics.
- Reproduction: the campaign observed the hang 4 times; replaying the
  stored programs reproduced it once in an automated replay, three
  times as a single 50-program sequence, and once with the two-step
  form above (one of the manual replays is captured only as a sysrq-t
  dump). Four runs on a bare fresh VM with a *different kernel command
  line* and without the scratch/pmem/NUMA layout recorded no hang --
  since the command line differs as well, these runs cannot attribute
  the effect to the device layout.

Kernel command line (full text in the repository, cmdline/cmdline-7.3.txt):
  root=3D/dev/sda console=3DttyS0 fstab=3Dno rw earlyprintk=3Dserial net.if=
names=3D0
  oops=3Dpanic panic_on_warn=3D1 panic=3D86400 hung_task_panic=3D1 softlock=
up_panic=3D1
  nmi_watchdog=3Dpanic ... page_owner=3Don secretmem.enable=3D1
  dummy_hcd.num=3D16 max_loop=3D32 nbd.nbds_max=3D32 kunit.autorun=3D0
  (for the live-inspection runs, hung_task_panic=3D0 was used instead; see
  cmdline/cmdline-7.3-retest.txt)

Reproduction
------------
Two equivalent ways are verified; the two-step form is the simplest.

From the host:

  scp syz-execprog syz-executor repro.priming.prog repro.prog root@guest:/t=
mp/
  ssh root@guest
  cd /tmp && chmod +x syz-execprog syz-executor

Step 1 -- run the state-construction sequence (49 programs) once:

  ./syz-execprog -executor=3D/tmp/syz-executor -procs=3D1 -repeat=3D1
/tmp/repro.priming.prog

It runs for ~20 s and exits normally. When its executor process exits,
the vtpm fds it holds are released and the release path hangs: the
hung-task monitor reports at t=E2=89=88267 s (logs/serial-twostep.log):

  INFO: task syz.0.33:10843 blocked for more than 143 seconds.
        Blocked by coredump.

while `ps` shows `kworker/X:Y+tpm-vtpm` and the executor task both in
state D (sysrq-t dump: logs/dmesg-sysrq-twostep.txt), and the serial log
shows `tpm tpm1/tpm2: Operation Timed out` while the release is blocked.
Step 2 -- optionally run the crashing testcase afterwards
(./syz-execprog ... /tmp/repro.prog); on the already-blocked VM it
simply runs and exits.

The single-file form replays the state construction and the crashing
testcase as one 50-program sequence (logs/execprog-verify4.out:
"parsed 50 programs"):

  ./syz-execprog -executor=3D/tmp/syz-executor -procs=3D1 -repeat=3D1
/tmp/repro.kernsight.prog

In both forms programs run sequentially (procs=3D1, repeat=3D1,
sandbox=3Dnone), but a program can leave asynchronous kernel-side work
behind. The sequence creates several vTPM proxy devices and
closes/exits over them. The hang appears when a closing task's release
path races a still-running or queued chip-register work. The
hung-task monitor then reports (t=E2=89=88480 s in logs/serial-verify4.log)=
:

  INFO: task syz.0.33:10857 blocked for more than 143 seconds.
        Not tainted 7.3.0-kernsight-kasan #1
        Blocked by coredump.
  task:syz.0.33        state:D stack:26264 pid:10857 tgid:10857 ppid:10246
  Call Trace:
   <TASK>
   __schedule+0x134d/0x6880
   schedule_timeout+0x24a/0x290
   __wait_for_common+0x1d3/0x4e0
   __flush_work+0x6ab/0xd90
   vtpm_proxy_work_stop     drivers/char/tpm/tpm_vtpm_proxy.c:470 [inline]
   vtpm_proxy_delete_device drivers/char/tpm/tpm_vtpm_proxy.c:590 [inline]
   vtpm_proxy_fops_release+0xa8/0x1d0 drivers/char/tpm/tpm_vtpm_proxy.c:239
   __fput+0x408/0xb60
   task_work_run+0x170/0x260
   do_exit+0x90c/0x2b60
   ...

  Showing all locks held in the system:
   locks held by kworker/3:2/1235: 2, on CPU#3:
    #0: ff110000267a8540 ((wq_completion)tpm-vtpm){+.+.}-{0:0}
    #1: ffa0000006cafd08 ((work_completion)(&proxy_dev->work)){+.+.}-{0:0}

While the task was blocked I captured full task dumps with
`echo t > /proc/sysrq-trigger` (hung_task_panic=3D0 variant; three dumps
included). In the first dump the kworker running a vtpm_proxy_work is
itself blocked in the transmit loop:

  task:kworker/2:3     state:D stack:24648 pid:9703
  Workqueue: tpm-vtpm vtpm_proxy_work
  Call Trace:
   <TASK>
   schedule+0xec/0x2d0
   schedule_hrtimeout_range_clock+0x11d/0x310
   usleep_range_state+0x178/0x220
   ? vtpm_proxy_tpm_req_canceled
   tpm_transmit+0x4bf/0xb90
   tpm_transmit_cmd+0x62/0x1f0
   vtpm_proxy_request_locality+0x140/0x280
   tpm_chip_start+0x18f/0x340
   tpm_chip_bootstrap+0x80/0x1c0
   tpm_chip_register+0x27/0x4d0
   vtpm_proxy_work+0x41/0x100
   process_one_work+0xa9c/0x1dc0
   ...

All three dumps also show that the tpm-vtpm workqueue carries a backlog
of further chip-register works behind the running one
(logs/dmesg-sysrq-verify3.txt):

  workqueue tpm-vtpm: flags=3D0x40108
    pwq 6: cpus=3D1 node=3D0 active=3D1 refcnt=3D33
      in-flight: 24:vtpm_proxy_work for 75s
      inactive: 4*vtpm_proxy_work BAR(10837), 26*vtpm_proxy_work

(logs/dmesg-sysrq-verify4.txt: in-flight for 109 s,
inactive: 29*vtpm_proxy_work BAR(10857).) With this backlog I cannot
tell which specific queued work the blocked release is waiting for; the
running work shown in the stacks may or may not be that one.

While the release was blocked, the serial log shows
"tpm tpm3: Operation Timed out" / "tpm tpm31: Operation Timed out"
lines. All included logs end while the task is still blocked, so I have
no log evidence of the release completing; I have also not established
an upper bound for the stall.

Two entry paths were observed for the blocked release:
- process exit: do_exit() -> task_work_run() -> __fput()
  (campaign reports, the automated reproduction, dmesg-sysrq-verify4.txt)
- close_range() returning to user space: task_work_run() -> __fput()
  (dmesg-sysrq-verify3.txt)

The minimized single-program testcase does not reproduce the hang; the
full 50-program sequence above is the reproducer. I have not isolated
which preceding operations or timing conditions are required.

Question
--------
vtpm_proxy_tpm_req_canceled() already exists and the driver marks the
device as being torn down before flush_work(); from the captured dumps
I cannot tell why the wait nevertheless persists for minutes. Should
the release path be bounded, or should the in-flight chip-register work
be ended more promptly once the proxy is being torn down? I am happy to
test proposed patches.

Materials (the reproducer, the sysrq-t task dumps, full serial logs,
the syz-execprog output, kernel config, command lines, a sha256 manifest,
and a verify.sh that re-checks the numbers quoted here):
  https://github.com/Zheng-zheng-codes/vtpm-proxy-release-hang-repro

Repository contents
-------------------
  repro/repro.priming.prog           state-construction sequence (49 progra=
ms)
  repro/repro.prog                   crashing testcase (use after the
priming run)
  repro/repro.kernsight.prog         single-file form (50 programs)
  logs/vtpm-sysrq-t-all-tasks.txt    sysrq-t dump: kworker stack +
backlog (run 1)
  logs/dmesg-sysrq-verify3.txt       sysrq-t dump: backlog,
close_range entry path
  logs/dmesg-sysrq-verify4.txt       sysrq-t dump: backlog, do_exit entry p=
ath
  logs/serial-7.3-auto-repro.log     automated state-primed reproduction
  logs/serial-7.3-manual-repro.log   manual replay, run 1
  logs/serial-verify4.log            manual replay, run 2 (serial)
  logs/serial-twostep.log            two-step reproduction (serial)
  logs/execprog-twostep-step1.out    two-step step 1 output ("parsed
49 programs")
  logs/dmesg-sysrq-twostep.txt       two-step sysrq-t dump
  logs/execprog-verify4.out          run 2 syz-execprog stdout
("parsed 50 programs")
  logs/serial-7.3-bare-no-trigger-*.log  4 bare-VM runs (no hang recorded)
  logs/report-7.3-*.txt, log-7.3-*.txt   the 4 campaign instances
  logs/crash-title.txt               crash title
  kernel/kernel-7.3.config           kernel configuration
  cmdline/cmdline-7.3.txt            kernel command line (syzkaller
standard set)
  cmdline/cmdline-7.3-retest.txt     verification variant (hung_task_panic=
=3D0)
  verify.sh                          re-checks the numbers quoted in this m=
ail
  MANIFEST.sha256                    sha256 of every file (except itself)

I am happy to provide additional information and test proposed patches.

Best regards,
Zheng Zheng
