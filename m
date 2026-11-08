Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794158123;
	b=bTmruzrYs4gSmpnPlewHNe1oLSsxrx8jdjeng8BsjFWghQFfY2MXB4BXJoO2JIJe9Osk
	 +xMBGfI2cOTpRglV32J0EaS6Lq/07+Wrq7UqcEwdwXQASIePOnMj+0pXlp1dxfrHrInGJ
	 6NtUEha+YP32N20Z7QUftADnNSRpAqyUmdRSjIJlIhwiBG9T9jlghoAFDtNkg+miv1PHf
	 0lCAmckq35aHCO2U+qTIF4x+uokgPimqjJ2XVDfQ9PrbF2fYqUD28TU3LfAwPC2z80SMq
	 1jQ+P6ZUPqYetqhopmaA/c+rq8mNlzCZiq+01XqgGzAfM+/C2/aqi23r3lA21MQrtYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZQU7p4tR/ulXMEWiEs/vvuxtN+ooDf321Dtf3Db82H0=;
	b=muhLVrqprpNGmnzTRhfw4VuIn5Cl+lsqxPHwYljFX2KZd8XNVrb8coFYaVumhma0A+XJ
	 zDuOGxzyrw7ZqBnaT/E16uYB3urIEQlwduCoZ0deax+3mZNvc+9KJsT4jbyDNJV/ju95U
	 raOuNkt/C4TuXTzCGvwxd+DyQK863Hb/r/2kfEQUmJAKODEC25jeOT1gfdmiHExXWk7XR
	 ybf833anK2Sa8jZ5s9k6XjnTJiTbL4lf/xyvgmlx9/CWKZ2TqChvQ+nw/r0tQyQWSffXv
	 Ob8RGve6hJyMTX3eLeXVA5IbmmoiEU/W6NDFyuklGbr08dhgi0I9Nof7Hbzx/tfqSZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ul4avjep;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285D606A32A
	for <linux-integrity@vger.kernel.org>; Sun,  8 Nov 2026 17:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1285D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ul4avjep
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3ad85432c52so2153201fa.1
        for <linux-integrity@vger.kernel.org>; Sun, 08 Nov 2026 09:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794158120; cv=none;
        d=google.com; s=arc-20260327;
        b=fCTfFqrBY/CdyhUfs67xP9jY9+szrXW7ZsIJoilvqRWaWou0OpHYnZ8HsYzGWAnaXM
         8ENI6Di0Y9ZIXH1rReaH+IEjuO5b2b/12ugvWuR7jNHdqtdM4ZRm+IAwEKYMLyTd+AiQ
         VlGIJWd3vYGrfQ+Ltk0sOGQCEDDeMG6snuxzANbsMRp3Sbd739m575K61h9paaWjP3GF
         isJSUaKPT+xsC94r+PMUwry3dByAUwo8PQr00Q8lvlyFKUHUic5QfrWP2QQwiXvJ/c/i
         Q91mb6UXWMQP+oDd6d5Z+8AiYIayQo+eHIlXfT6fGw44oEjIaSVrr7Xp3L50WpLnakGH
         gh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQU7p4tR/ulXMEWiEs/vvuxtN+ooDf321Dtf3Db82H0=;
        fh=Q2CWv5AT7PIkIVWa7SHux7E3oPK5MIWBzX7eVu5/bYU=;
        b=fGVB7SMApN+lTCsMALUDfZ5IQVLCxVolevR+jzPZGJLhnLLwT/sE+uwdg185fi9ifZ
         GfRHAoJU8t9Fk8AiEdtsYiMekp0bfkilvch/Vg5j2y3C9PNPkJx9qP0tLIgPt3YyrNTF
         RIqk2hV0boy+kNdvyeJDSLyZH5YFosxRv6ZTJ2W+hHI1dPF9TC4HtNUcIU6YpOFKAkLx
         EJ+4ctpVgwdQsl0HhpnaLnhx6YaxkRRAwp+PQmKZg4ZESsoOFQa9I9Es1J0lqtYY+r52
         yedz9iPFMZQ3macFSJsGm9TywkOar0lHvxtU5AR77O2cSYYB6YHZ4EQcYg6nHh1XyG4f
         3OFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158120; x=1794762920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQU7p4tR/ulXMEWiEs/vvuxtN+ooDf321Dtf3Db82H0=;
        b=ul4avjepeuaa386rmE9YWn62JG18ea6045+l+b3rjjQdNoNUFiRfTaw5SnjaNeV6Eu
         6EdruEkOQY1IFzVJp0NV+AuXEwsAuaxfqglr8RkJIwWtY1WfZAz1N5p/YeMZplteMlDp
         OcOa/tahpd1upt/ArVejygvvbH8vMFM3owHmuMHczGkUPvhAoj7Nl0aV0Aav8EX30CEh
         DrikzPVfp0kUw+77LJev99cBQcQO4UlRMFjSDoyElosmVvwhNQMyFnZyLR27W9jmFJgK
         Q8kkwvBmgLmYa/2w5rw3yaU6mz6CkU6TCnV7S+W7M09835cMKpYItLPZyaIvVxh3AEq0
         ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158120; x=1794762920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQU7p4tR/ulXMEWiEs/vvuxtN+ooDf321Dtf3Db82H0=;
        b=acG4FXx7w7B0ZvVw3Daczg7XhP+dTxDCru+jY2OVZFCEtJzFBiN9MV2YQj0pSl77+s
         IfFCEbelLq8F3O7tv531YmJaKlMRV2QiWNyYzuUyRierlrCKBwygzG06if1wSz5G4zsq
         WgHbX0XIu03UQUqtGxq9iyRGVbD3Rm+MYKtQbdXLxiCjmxVUp6IcLI4lDE8H138lLQ8i
         iWo2Q1arrrc0E8T3wzGpjDn+aZXTGtDo+bSE7fekzQblvcI99/oahnnLjuB1pvmvI3bc
         Wb+s0MGD8eTqaQGMhg+yGeEC3lgy0e6bTVDANiJBT6gXpOW2rGKyy4LLUpsOMK0nqDav
         giZQ==
X-Forwarded-Encrypted: i=1; AL+hErESHbxTMALxduppe5Rw5bw2yw4DWWhVKc6n0Yb4T3KgRQy5xouIlPmsKf5ap5SQ0Pma+fxfgrKMgtdlEqKQzBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Oi6F5gmj9FqLCLuvFekcGfRu7tRU5vZWdEVX73+5FUTU737Ex
	A5SM6qrwig510JOfIsE71lZjMFCMloncDMK41DLWrfMF6227yP34PRykyGvO0Kj1Vvjhvwv6wIK
	UhkC+j35M/3O7h+L7j8mDwYYLR4ZBx24=
X-Gm-Gg: AYBFou2EUeDG0bFVkdyK9L9hz0jJPMX0vthgX/WATcBuchx2islMQedKA+V2+kendHO
	VDoBlwyRCRpYcIUb5u/iN/Sytt/EL83v0nArdviqJJcO2Ej7VHLyJqhm2laUvlS++DoCqs3fGbX
	ToqaIli18UXSTtVc5i2rQWLJPFOflpQzxi7QjJ9ShGF+MnsjC8/zogXdrZgZwZ6GRti5TR3Hcoq
	F6Vun4mtaIqlk4/diQHUUk+vIb5APswDN4OkRuJRh49bd7YYlDsGoS5I/u54t/iSXyrsW4u2YcW
	jg/Wjstk+2Xo+SKZM8II/i0d7VRsiVBwHcDdlcBB9HpdtKTbV6i8ziKBsPiWm2yGt8tSIPgPkx5
	muQpozeGW2U2NoirI0PK4AVF7FUuUiSb6AUQ=
X-Received: by 2002:a05:651c:150d:b0:3ab:28cd:f612 with SMTP id
 38308e7fff4ca-3adfa32c7abmr4972131fa.1.1794158119886; Sun, 08 Nov 2026
 09:15:19 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
 <aud4isATIt0JOOL_@kernel.org> <012799b9-aa35-4990-86df-23b012ab94e6@linux.ibm.com>
In-Reply-To: <012799b9-aa35-4990-86df-23b012ab94e6@linux.ibm.com>
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Mon, 9 Nov 2026 01:15:07 +0800
X-Gm-Features: AclHuK8r2f2--ezEXDEYO3_9R2f_lejThWLcjakBiwd_a71fevjpitvK-Q4Xh6A
Message-ID: <CAO-4RZ0Od63iUeFkoPznV4vd84Ghjii4CGo+khybQckCv=EXkQ@mail.gmail.com>
Subject: Re: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux 7.3
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thank you for the patch
("tpm: tpm_vtpm_proxy: Set STATE_OPENED_FLAG before inode is created").
We applied and tested it, and we have also reproduced the boot warning
Stefan reported and identified a sufficient condition for
it (running without KVM acceleration). Two findings first; "Where to
look" at the end points to the exact files in our repository.

1. Your patch does not change the outcome of the hang

A/B test, same session, same QEMU layout and command line, two-step
reproduction (49-program state-construction sequence; the hang appears
when its executor process exits and releases the vTPM fds):

  patched kernel  (7.3.0-kernsight-kasan #3, your patch applied;
                   drivers/char/tpm/tpm_vtpm_proxy.c is the only change):
    hang reproduced, 1/1 run
    t=3D414s: INFO: task syz.0.26:10773 blocked for more than 143 seconds.
            (t=3D434s: 163 seconds), blocked in
            vtpm_proxy_fops_release() -> __flush_work()
    t=3D460s sysrq-t: the chip-register work is sleeping in
            tpm_transmit() <- vtpm_proxy_request_locality(), with
            vtpm_proxy_tpm_req_canceled() present as the transmit wait's
            cancel callback; workqueue tpm-vtpm backlog
            "inactive: 64*vtpm_proxy_work" (plus 4+58 on a second pwq);
            serial repeats "tpm tpmN: Operation Timed out".

  unpatched control (7.3.0-kernsight-kasan #1, same session):
    hang reproduced, 1/1 run, t=3D387s, identical blocked stack.

So the udev / STATE_OPENED_FLAG race does not explain this stall. This
fits the shape of the reproducer: it creates vTPM proxy devices via
/dev/vtpmx and exits; nothing else ever opens the server-side anon-inode
fd, so there is no udev open/close racing the flag. What happens is:
fput() of the server fd -> vtpm_proxy_fops_release() ->
vtpm_proxy_work_stop() -> flush_work(), while the chip-register work
keeps taking TPM-timeout-sized naps on a client that never responds and
dozens of such works are queued behind it.

v7.4-rc1 is affected as well: drivers/char/tpm/tpm_vtpm_proxy.c is
unchanged between v7.3.0 and v7.4-rc1 (empty diff), and the same
reproduction hangs there 1/1 (t=3D402s, same signature).

Given that vtpm_proxy_tpm_req_canceled() is registered as the transmit
wait's cancel callback, which direction would you prefer for a fix?
  (a) make teardown terminate the in-flight register work promptly
      (e.g. the transmit path honors the closed/torn-down state so
      tpm_transmit() aborts instead of timing out), or
  (b) a lifecycle-safe teardown approach you consider appropriate for
      the release path and the in-flight register work (we defer to your
      preferred design).
We are happy to build and test whichever you prefer; the environment is
scripted, a build + run cycle takes about 15 minutes.

2. Your boot warning reproduces under TCG (no KVM acceleration)

You reported (2026-11-01) that the suggested QEMU command line fails
with:

  sched: CPU #2's llc-sibling CPU #0 is not on the same node!
         [node: 1 !=3D 0]. Ignoring dependency.
  WARNING: arch/x86/kernel/smpboot.c:329 at topology_sane.isra.0

With KVM acceleration we could NOT reproduce it on our hosts, in any
combination we tried: QEMU 6.2 and QEMU 10.2.1 (Ubuntu 26.04,
seabios 1.17.0-1ubuntu1 =E2=80=94 the BIOS string matches his report), full
layout, the original suggested command line, and even forcing the exact
cross-node-LLC shape via "-smp 4,sockets=3D1,cores=3D4,threads=3D1": clean
boots every time.

Without KVM acceleration it reproduces byte-for-byte: booting the same
QEMU 10.2.1 stack with "-accel tcg,thread=3Dmulti -cpu max" (same layout,
same command line, same unpatched kernel) produces exactly the warning
from your report (topology_sane.isra.0+0xa3/0xb0, same Hardware
name string) and then panics via panic_on_warn=3D1 =E2=80=94 i.e. the boot =
fails
as he described.

Mechanism: with KVM + "-cpu host" the cache-topology CPUID leaves mostly
pass through our host CPU (Intel Xeon Gold 6326), so the guest never
sees LLC siblings across the NUMA nodes of the suggested layout; under
TCG QEMU synthesizes the topology itself, LLC siblings span both nodes,
and topology_sane() fires. Whether your machine ran TCG (e.g. no
usable /dev/kvm) or a host CPU whose KVM enumeration differs cannot be
determined from your report, but the condition is now reproducible and
checkable on our side. Note the two runs differ in both the accelerator
and the CPU model (KVM runs used "-cpu host", the TCG run "-cpu max"),
so the experiment isolates the pair, not the accelerator alone.

The mitigation works in both modes: "-smp 4,sockets=3D2,cores=3D2,threads=
=3D1"
keeps each socket's LLC within one NUMA node =E2=80=94 the TCG boot then
proceeds with no warning, and under KVM the hang still reproduces with
the fixed topology, so the one-line change makes the boot robust
regardless of the accelerator while the bug stays testable.

3. Where to look in the repository [1]

  tcg-topology-20261109/            <- the TCG finding
    README.md                       KVM vs TCG comparison, mechanism
    serial-tcg-hit.log              boot under TCG: the warning + panic
                                    (byte-identical to your report)
    serial-tcg-fixed-topology.log   same TCG boot with the -smp
                                    mitigation: clean boot
    boot-tcg.sh / boot-tcg-fixed.sh exact QEMU wrappers of both runs

  patch-ab-test-20261107/           <- the patch A/B and v7.4-rc1
    README.md                       results table and build details
    0001-tpm-tpm_vtpm_proxy-Set-STATE_OPENED_FLAG-before-inod.patch
                                    the tested patch
    serial-7.3-patched.log          patched run (two hung-task reports)
    sysrq-t-7.3-patched-excerpts.txt  worker stack + workqueue backlog
    serial-7.3-unpatched-ctrl.txt   unpatched control run
    sysrq-t-7.3-unpatched-ctrl.txt  control sysrq-t dump
    serial-7.4-rc1.log              v7.4-rc1 run (hung-task report)
    sysrq-t-7.4-rc1.txt             v7.4-rc1 sysrq-t dump

  repro/                            state-construction sequence + testcase
  cmdline/                          guest kernel command lines, QEMU args
  kernel/kernel-7.3.config          kernel configuration (KASAN/KCOV)
  logs/                             original syzkaller campaign evidence

4. Caveat

In every log the window ends while the release task is still blocked, so
we have not captured whether the release eventually completes once the
backlog drains; we are not claiming a permanent deadlock.

Happy to test any proposed patch in either direction, and to provide any
file inline.

Best regards,
Zheng Zheng

[1] https://github.com/Zheng-zheng-codes/vtpm-proxy-release-hang-repro

On Sat, Nov 7, 2026 at 3:11=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
>
>
> On 11/1/26 12:36 PM, Jarkko Sakkinen wrote:
> > On Sun, Nov 01, 2026 at 09:22:30AM +0800, =E9=93=AE wrote:
> >> Hi Peter, Jarkko and Jason,
> > >>
> >> Question
> >> --------
> >> vtpm_proxy_tpm_req_canceled() already exists and the driver marks the
> >> device as being torn down before flush_work(); from the captured dumps
> >> I cannot tell why the wait nevertheless persists for minutes. Should
> >> the release path be bounded, or should the in-flight chip-register wor=
k
> >> be ended more promptly once the proxy is being torn down? I am happy t=
o
> >> test proposed patches.
>
> I have tried to reproduce this now but cannot. The kernel fails for me
> like this when booting with the suggested QEMU command line:
>
> [    3.224399][    T1] Timer migration: 2 hierarchy levels; 8 children
> per group; 1 crossnode level
> [    3.239948][    T1] smp: Bringing up secondary CPUs ...
> [    3.243980][    T1] smpboot: x86: Booting SMP configuration:
> [    3.246035][    T1] .... node  #0, CPUs:      #1
> [    3.252255][    T1] .... node  #1, CPUs:   #2 #3
> [    0.076393][    T0] ------------[ cut here ]------------
> [    0.076393][    T0] sched: CPU #2's llc-sibling CPU #0 is not on the
> same node! [node: 1 !=3D 0]. Ignoring dependency.
> [    0.076393][    T0] WARNING: arch/x86/kernel/smpboot.c:329 at
> topology_sane.isra.0+0x97/0xb0, CPU#2: swapper/2/0
> [    0.076393][    T0] Modules linked in:
> [    0.076393][    T0] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted
> 7.3.0-kernsight-kasan #1 PREEMPT(full)
> [    0.076393][    T0] Hardware name: QEMU Ubuntu 26.04 PC (i440FX +
> PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> [    0.076393][    T0] RIP: 0010:topology_sane.isra.0+0xa3/0xb0
> [    0.076393][    T0] Code: 07 00 44 89 ef e8 ed fa 07 00 44 89 e7 89
> c3 e8 e3 fa 07 00 41 89 c0 48 8d 3d 79 4e 3e 10 41 89 d9 44 89 e9 4c 89
> fa 44 89 e6 <67> 48 0f b9 3a eb a5 66 0f 1f 44 00 00 90 90 90 90 90 90
> 90 90 90
> [    0.076393][    T0] RSP: 0000:ffffc900001afde0 EFLAGS: 00010092
>
> The first thing I was going to try is whether this has something to do
> with the 'STATE_OPENED_FLAG' flag. There's one location where this is
> set and that's after the anon_inode_getfile() was called. For a server
> side device to be able to access the device, udev would have to run.
> Maybe udev does run between anon_inode_getfile() and the server side
> opens the device and the immediately closes it and resets the flag
> BEFORE current vtpm_proxy_fops_open() sets the flag and makes the client
> think that there still is an server-side app responding to requests. So,
> let's reverse the order and set the flag before the inode gets created
> and the flag can be reset - patch also as attachment:
>
>
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c
> b/drivers/char/tpm/tpm_vtpm_proxy.c
> index b81fd2a537df..245a8f959bc7 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -197,10 +197,8 @@ static __poll_t vtpm_proxy_fops_poll(struct file
> *filp, poll_table *wait)
>    *
>    * Called when setting up the anonymous file descriptor
>    */
> -static void vtpm_proxy_fops_open(struct file *filp)
> +static void vtpm_proxy_fops_open(struct proxy_dev *proxy_dev)
>   {
> -       struct proxy_dev *proxy_dev =3D filp->private_data;
> -
>         proxy_dev->state |=3D STATE_OPENED_FLAG;
>   }
>
> @@ -550,6 +548,9 @@ static struct file *vtpm_proxy_create_device(
>                 goto err_delete_proxy_dev;
>         }
>
> +       /* simulate an open() on the server side */
> +       vtpm_proxy_fops_open(proxy_dev);
> +
>         file =3D anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_de=
v,
>                                   O_RDWR);
>         if (IS_ERR(file)) {
> @@ -558,8 +559,6 @@ static struct file *vtpm_proxy_create_device(
>         }
>
>         /* from now on we can unwind with put_unused_fd() + fput() */
> -       /* simulate an open() on the server side */
> -       vtpm_proxy_fops_open(file);
>
>         if (proxy_dev->flags & VTPM_PROXY_FLAG_TPM2)
>                 proxy_dev->chip->flags |=3D TPM_CHIP_FLAG_TPM2;
>
>
>
