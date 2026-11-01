Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554574;
	b=nyjUOOeBhH+prgqnnheL5AS6+NOCWKyYZAQL7kZWDu4TwrsiqJOe3yPccLOBTrBJrDbg
	 jelXVhchNQl6PgWMkJtDEM0936bhYJw/ChIAowWDrjpZWL6fXG/MnV6fvzhd6yIkNF0Rw
	 IpeyppjsWiQzBHchWBlqGLyDrglA0WxrdwkpW8I0yXtv5VW5DiDwcbmn6yJpra0Zsf4eQ
	 oRmG/M/TMgBRVlrR6DkxOw6o025cdA9mhVuXYYQRNzXgydjMI7EXlNAjh2BF7EjnGNtYn
	 6bN6pT0MbBKIIpVycf9pjLKd9JCyt1u/HuZT7+bUGmmobRvI+1aRZj1y/MNZMtWn7Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rzer3B3b6Mhvp+GybdMNJdIQ2GgHJgSS34HUoJp83Cs=;
	b=PlxSSsyp+V/ASrm7EdvRUZE4cL//5L7bUTfZ8tEE1/E/vDgmZZ3l7GPPhMzGXGiF8TJG
	 4TCDoxgfl7qFo/NVHb3VeiBg53NRHbR/6ne0IncTPyfZJeFkVh3fvbAvOuRWD/xyfNG88
	 TCetLNeCtCXVsxK9Kg+XVUY6cT36UbKRbcUwK7VjuqoReyvBeQ+KeFuCMObnA0L1uo1ql
	 gY4ZhmI+s0EghU1mjRmsXzRoxUTJiWx9kRvhl6t3Bi82A1cN/n/R2dTmS6BKbfNm1xx/s
	 feebMe+P+p8sh412coIp4pKHn/wixyDPgZJFIXJLzcp/JeX0lB+PKr9HJsYXUAteqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dU9atTTc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 999D7606A324;
	Sun,  1 Nov 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dU9atTTc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E3FDF1F000C1;
	Sun,  1 Nov 2026 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554573;
	bh=rzer3B3b6Mhvp+GybdMNJdIQ2GgHJgSS34HUoJp83Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dU9atTTcRVppUutzqwf0Wy1Jg0Ii0uNkHItuf5h1IByp/k0Wohn3zwcFFKhrROIRh
	 rUdX5b1VCG2qV5e29ZKcuoIh4TTZRdJQPhbv0GzZReK/NRwtw+GmYWHTWYcQxZPlib
	 MFM0gtC/TX1kebtC5lUwHqtcz1M+djtdRu3MCuwFeqEQnig+GCgDKzminyzgumG10R
	 WX5MBqREs0OVoXUoVIC1im09FYdUTudD6XSBopbW9tzwiQAL+l/BN1qjinDuWTdjnz
	 jqyfLfH3k5fHhNQ0rLY6Jg3yp5osB9uuW5p7t7zxfMkJ6iZteYdKz1WumG8zkF6ebN
	 RM5IyDfDO1c9g==
Date: Sun, 1 Nov 2026 19:36:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: =?utf-8?B?6ZOu?= <fengaojigui88@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux
 7.3
Message-ID: <aud4isATIt0JOOL_@kernel.org>
References: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>

On Sun, Nov 01, 2026 at 09:22:30AM +0800, 铮 wrote:
> Hi Peter, Jarkko and Jason,

Adding Stefan. 

> 
> I observed a task hang in vtpm_proxy_fops_release() while fuzzing the
> vTPM proxy with syzkaller. I reproduced it on Linux 7.3.0: the campaign
> observed the hang 4 times; replaying the stored sequence reproduced it
> once in an automated replay and three times in manual replays. In every
> case a process is blocked for 143+ seconds in
> vtpm_proxy_fops_release() -> vtpm_proxy_work_stop() -> flush_work(),
> while at the same time the sysrq-t dumps show a chip-register work
> (vtpm_proxy_work -> tpm_chip_register() -> tpm_chip_start() ->
> vtpm_proxy_request_locality()) running on the tpm-vtpm workqueue plus a
> backlog of further queued chip-register works. Which queued work the
> blocked release is waiting for is unconfirmed. All logs end while the
> task is still blocked, so I cannot say how long the stall ultimately
> lasts; I am not claiming a permanent deadlock.
> 
> Environment
> -----------
> - Kernel: 7.3.0-kernsight-kasan #1 SMP PREEMPT_DYNAMIC, built 2026-10-20,
>   x86_64. Vanilla 7.3.0 source tarball (sha256
>   87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f004953),
>   built with KASAN/KCOV. No TPM changes were made for this testing
>   (drivers/char/tpm/ matches vanilla apart from build artifacts).
> - Guest: QEMU/KVM, 4 vCPU, 6 GiB, 8 scratch virtio disks, 2 NVDIMM/pmem
>   devices, 2 NUMA nodes (the syzkaller standard environment). A fresh VM
>   was used for every reproduction run.
> - Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+
>   (2026-09-18). The "+" denotes local KernSight integration changes
>   (seed ordering/state feedback: pkg/kernsight, prog/kernsight_*,
>   syz-manager/kernsight_*, pkg/execbackend, snapshot support in vm/qemu).
>   They do not change the TPM syscall descriptions or the executor
>   semantics.
> - Reproduction: the campaign observed the hang 4 times; replaying the
>   stored programs reproduced it once in an automated replay, three
>   times as a single 50-program sequence, and once with the two-step
>   form above (one of the manual replays is captured only as a sysrq-t
>   dump). Four runs on a bare fresh VM with a *different kernel command
>   line* and without the scratch/pmem/NUMA layout recorded no hang --
>   since the command line differs as well, these runs cannot attribute
>   the effect to the device layout.
> 
> Kernel command line (full text in the repository, cmdline/cmdline-7.3.txt):
>   root=/dev/sda console=ttyS0 fstab=no rw earlyprintk=serial net.ifnames=0
>   oops=panic panic_on_warn=1 panic=86400 hung_task_panic=1 softlockup_panic=1
>   nmi_watchdog=panic ... page_owner=on secretmem.enable=1
>   dummy_hcd.num=16 max_loop=32 nbd.nbds_max=32 kunit.autorun=0
>   (for the live-inspection runs, hung_task_panic=0 was used instead; see
>   cmdline/cmdline-7.3-retest.txt)
> 
> Reproduction
> ------------
> Two equivalent ways are verified; the two-step form is the simplest.
> 
> From the host:
> 
>   scp syz-execprog syz-executor repro.priming.prog repro.prog root@guest:/tmp/
>   ssh root@guest
>   cd /tmp && chmod +x syz-execprog syz-executor
> 
> Step 1 -- run the state-construction sequence (49 programs) once:
> 
>   ./syz-execprog -executor=/tmp/syz-executor -procs=1 -repeat=1
> /tmp/repro.priming.prog
> 
> It runs for ~20 s and exits normally. When its executor process exits,
> the vtpm fds it holds are released and the release path hangs: the
> hung-task monitor reports at t≈267 s (logs/serial-twostep.log):
> 
>   INFO: task syz.0.33:10843 blocked for more than 143 seconds.
>         Blocked by coredump.
> 
> while `ps` shows `kworker/X:Y+tpm-vtpm` and the executor task both in
> state D (sysrq-t dump: logs/dmesg-sysrq-twostep.txt), and the serial log
> shows `tpm tpm1/tpm2: Operation Timed out` while the release is blocked.
> Step 2 -- optionally run the crashing testcase afterwards
> (./syz-execprog ... /tmp/repro.prog); on the already-blocked VM it
> simply runs and exits.
> 
> The single-file form replays the state construction and the crashing
> testcase as one 50-program sequence (logs/execprog-verify4.out:
> "parsed 50 programs"):
> 
>   ./syz-execprog -executor=/tmp/syz-executor -procs=1 -repeat=1
> /tmp/repro.kernsight.prog
> 
> In both forms programs run sequentially (procs=1, repeat=1,
> sandbox=none), but a program can leave asynchronous kernel-side work
> behind. The sequence creates several vTPM proxy devices and
> closes/exits over them. The hang appears when a closing task's release
> path races a still-running or queued chip-register work. The
> hung-task monitor then reports (t≈480 s in logs/serial-verify4.log):
> 
>   INFO: task syz.0.33:10857 blocked for more than 143 seconds.
>         Not tainted 7.3.0-kernsight-kasan #1
>         Blocked by coredump.
>   task:syz.0.33        state:D stack:26264 pid:10857 tgid:10857 ppid:10246
>   Call Trace:
>    <TASK>
>    __schedule+0x134d/0x6880
>    schedule_timeout+0x24a/0x290
>    __wait_for_common+0x1d3/0x4e0
>    __flush_work+0x6ab/0xd90
>    vtpm_proxy_work_stop     drivers/char/tpm/tpm_vtpm_proxy.c:470 [inline]
>    vtpm_proxy_delete_device drivers/char/tpm/tpm_vtpm_proxy.c:590 [inline]
>    vtpm_proxy_fops_release+0xa8/0x1d0 drivers/char/tpm/tpm_vtpm_proxy.c:239
>    __fput+0x408/0xb60
>    task_work_run+0x170/0x260
>    do_exit+0x90c/0x2b60
>    ...
> 
>   Showing all locks held in the system:
>    locks held by kworker/3:2/1235: 2, on CPU#3:
>     #0: ff110000267a8540 ((wq_completion)tpm-vtpm){+.+.}-{0:0}
>     #1: ffa0000006cafd08 ((work_completion)(&proxy_dev->work)){+.+.}-{0:0}
> 
> While the task was blocked I captured full task dumps with
> `echo t > /proc/sysrq-trigger` (hung_task_panic=0 variant; three dumps
> included). In the first dump the kworker running a vtpm_proxy_work is
> itself blocked in the transmit loop:
> 
>   task:kworker/2:3     state:D stack:24648 pid:9703
>   Workqueue: tpm-vtpm vtpm_proxy_work
>   Call Trace:
>    <TASK>
>    schedule+0xec/0x2d0
>    schedule_hrtimeout_range_clock+0x11d/0x310
>    usleep_range_state+0x178/0x220
>    ? vtpm_proxy_tpm_req_canceled
>    tpm_transmit+0x4bf/0xb90
>    tpm_transmit_cmd+0x62/0x1f0
>    vtpm_proxy_request_locality+0x140/0x280
>    tpm_chip_start+0x18f/0x340
>    tpm_chip_bootstrap+0x80/0x1c0
>    tpm_chip_register+0x27/0x4d0
>    vtpm_proxy_work+0x41/0x100
>    process_one_work+0xa9c/0x1dc0
>    ...
> 
> All three dumps also show that the tpm-vtpm workqueue carries a backlog
> of further chip-register works behind the running one
> (logs/dmesg-sysrq-verify3.txt):
> 
>   workqueue tpm-vtpm: flags=0x40108
>     pwq 6: cpus=1 node=0 active=1 refcnt=33
>       in-flight: 24:vtpm_proxy_work for 75s
>       inactive: 4*vtpm_proxy_work BAR(10837), 26*vtpm_proxy_work
> 
> (logs/dmesg-sysrq-verify4.txt: in-flight for 109 s,
> inactive: 29*vtpm_proxy_work BAR(10857).) With this backlog I cannot
> tell which specific queued work the blocked release is waiting for; the
> running work shown in the stacks may or may not be that one.
> 
> While the release was blocked, the serial log shows
> "tpm tpm3: Operation Timed out" / "tpm tpm31: Operation Timed out"
> lines. All included logs end while the task is still blocked, so I have
> no log evidence of the release completing; I have also not established
> an upper bound for the stall.
> 
> Two entry paths were observed for the blocked release:
> - process exit: do_exit() -> task_work_run() -> __fput()
>   (campaign reports, the automated reproduction, dmesg-sysrq-verify4.txt)
> - close_range() returning to user space: task_work_run() -> __fput()
>   (dmesg-sysrq-verify3.txt)
> 
> The minimized single-program testcase does not reproduce the hang; the
> full 50-program sequence above is the reproducer. I have not isolated
> which preceding operations or timing conditions are required.
> 
> Question
> --------
> vtpm_proxy_tpm_req_canceled() already exists and the driver marks the
> device as being torn down before flush_work(); from the captured dumps
> I cannot tell why the wait nevertheless persists for minutes. Should
> the release path be bounded, or should the in-flight chip-register work
> be ended more promptly once the proxy is being torn down? I am happy to
> test proposed patches.
> 
> Materials (the reproducer, the sysrq-t task dumps, full serial logs,
> the syz-execprog output, kernel config, command lines, a sha256 manifest,
> and a verify.sh that re-checks the numbers quoted here):
>   https://github.com/Zheng-zheng-codes/vtpm-proxy-release-hang-repro

Thanks for making it public on one go. Here it is the best pick.

> 
> Repository contents
> -------------------
>   repro/repro.priming.prog           state-construction sequence (49 programs)
>   repro/repro.prog                   crashing testcase (use after the
> priming run)
>   repro/repro.kernsight.prog         single-file form (50 programs)
>   logs/vtpm-sysrq-t-all-tasks.txt    sysrq-t dump: kworker stack +
> backlog (run 1)
>   logs/dmesg-sysrq-verify3.txt       sysrq-t dump: backlog,
> close_range entry path
>   logs/dmesg-sysrq-verify4.txt       sysrq-t dump: backlog, do_exit entry path
>   logs/serial-7.3-auto-repro.log     automated state-primed reproduction
>   logs/serial-7.3-manual-repro.log   manual replay, run 1
>   logs/serial-verify4.log            manual replay, run 2 (serial)
>   logs/serial-twostep.log            two-step reproduction (serial)
>   logs/execprog-twostep-step1.out    two-step step 1 output ("parsed
> 49 programs")
>   logs/dmesg-sysrq-twostep.txt       two-step sysrq-t dump
>   logs/execprog-verify4.out          run 2 syz-execprog stdout
> ("parsed 50 programs")
>   logs/serial-7.3-bare-no-trigger-*.log  4 bare-VM runs (no hang recorded)
>   logs/report-7.3-*.txt, log-7.3-*.txt   the 4 campaign instances
>   logs/crash-title.txt               crash title
>   kernel/kernel-7.3.config           kernel configuration
>   cmdline/cmdline-7.3.txt            kernel command line (syzkaller
> standard set)
>   cmdline/cmdline-7.3-retest.txt     verification variant (hung_task_panic=0)
>   verify.sh                          re-checks the numbers quoted in this mail
>   MANIFEST.sha256                    sha256 of every file (except itself)
> 
> I am happy to provide additional information and test proposed patches.
> 
> Best regards,
> Zheng Zheng

Thank you for reporting this.

Br, Jarkko
