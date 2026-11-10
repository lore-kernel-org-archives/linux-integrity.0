Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794292984;
	b=cTtuI+F+iK3DpZApzZhLAFOGcWP/9f4ix6/ELnXA+xgtv/z2CPSLyVGEFK5S2Y1XHHh+
	 QSGTmJ1yDWTRJRHJ2kC/CVxq99M5A9+xQGDYQ0yLfQiRfRcNW/iyl/Q+3keEt7MhxyADK
	 irudjZEJj4xfxyTSN5l6b5g1u+51yLjxSrcovW+mzwQZRLyVkL6xp+61H0Yn+a4jhw8Uv
	 Fno+FuYafSEpi+zzXGqSBEUYqjlEdQbP37GRXTna6AsKCDee7h+pSF0Hikaq+3AkbnrJT
	 OJCPVkXzx7AHNqOxJ7ewUG8ooamrxGgPPSgrUeg0/mylF2YZIAwG6emzLNgHryth3qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WhMGbH5jrCgdZtm+muhfnQpcOX+DUr1ohq9U4/27cYA=;
	b=dVy4dl++2znvWVrnTA9ygAimyt6qVlpCa2yI0c/lQBlF6MjKaI2K0Pj1+MoGUa91Z2BS
	 uR0sdIYFC0KqYnrRqlLoHDoqmkBFaeNiIbIL8ozvd3DUbqDakesjRjMIPnfNCMveqIC70
	 GVSnCSudG9pfDOQdhrMsmhXP5iU19YbNmUIsVAtStskfgU8FxVct683C73EEZmAbHTIBb
	 amq4PNGb2d8sSRmlOUCNW1BR1xbWMlycjceCgYzeSrs3EWWp+jH2X6eqUuXEhEdq4yAnV
	 tqLkdHBoGR6RPL5dYLB9YaCmX95+efZUU85O5fWSV6UpA3SB9RY41l+4UZo5N+XGJqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fg+JoBW0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F7606A645
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 06:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E1F7606A645
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fg+JoBW0
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3adf2030cdbso10502211fa.0
        for <linux-integrity@vger.kernel.org>; Mon, 09 Nov 2026 22:43:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794292982; cv=none;
        d=google.com; s=arc-20260327;
        b=ofFnPE9AwiM0c7o7V0qO5/3TtcNd44EeUjFp15a5fGP1wbbPwRuEmSMArFpNwhzo/Q
         rzfZs/dW3iqp5pNtLAlI8xskJoEu/BHXlEBSsRFDIrlMR+87d4lBPTEmj049xh8tl/pI
         WnP8JaRzCa+Ej63QcEaUoP24Xu7kB56ImErjsFG9Yr7xGCsCpimmeJjYC/dCHjnVj765
         q38BwqkJupi9v46kFq5nq+xabhX5AJtiZiiPatXcsyqhDbNBqhPDWMlp+hXSxqlZpqWV
         wPTiXaAUadhB5dm5RXrgElEWfCPFJ2mro28oLLK4H7eH/rOZ/Hw7PiCBdLDJdSJHoIo0
         uwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhMGbH5jrCgdZtm+muhfnQpcOX+DUr1ohq9U4/27cYA=;
        fh=RUbakBTW2IZ+UARmZYZlrUCERI8ESt2o4qAXk4GEQWo=;
        b=ndC2Rfq0EQ+kXjKkaHwhH9kuqAcKVcS1npma4oSvsOAuzEMNC4ceRKbnOdVizk/WPb
         XaogHWumP/f2KceGb/k4kutiDdjvzZ1oIpT84QszxmhuwvCxovBLDkP/m6AFPML25P8l
         WVrUyMZ5sQEdfrlfX/cxl3Q6CSo+eVbC1X+knUD2LCnlno86Q2L2Ns8Ku3axfdeL3kfN
         CwQiBIypjmJ/WPF5DNAxGkJswshey9B+txW9lDF9qyv7mJjzpwoJD3AFK6D3fg0CZVJ1
         iLBnwuwKoSlG16TpUZfWJALPtHOld8OKSWuMNl4C6Wvdy1d9i3ucnqMAiS/yVGARi0MU
         CV/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794292982; x=1794897782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WhMGbH5jrCgdZtm+muhfnQpcOX+DUr1ohq9U4/27cYA=;
        b=fg+JoBW0t/ZuyT0OxykQAG/bZ5UxDMyJGDB0z0OShqkku3DyfcOXh2Ep5y77g2NCEZ
         CpmqUpASF9cxBE+2UJvYlgA2zsZmdeyeenZ6ndTaXl35c80PwXNNDiI8TV79MU/CTZm/
         3LAurxabSzu3lfTtjzLgApglmHTJOJR95wVlU1kZ1VjJHLMbES3eYiIlCRIQ8KiXVzAf
         AmJ2GpYV9IF7+9lMestUhiHGO4jCIJvItvYUhz0ZMvvT/wNLN9LPaI8aGhpFyLl8tlxU
         55IsvYy4tPOjd86hfZQIQdiYxmdwgkSg6dsZvTztPIou/Ti84HuD3BU1qp46KNigC5JC
         OySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292982; x=1794897782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhMGbH5jrCgdZtm+muhfnQpcOX+DUr1ohq9U4/27cYA=;
        b=ZyiSANtbb99v7ChtNzOnxI0ZlO1ORCC+GpoZ37Lr9B+9jnaeH7R2POfPdSFfqfsroU
         wU4mjGdaEtDDFuYiiPx0fACQGsdqN+L8GRcpTZHC3cBe9rkHpfJO04DFqHhK3sEKWBoE
         OzJjh5PcAp1emY0pZH0yFtS1tqfwd7aYd4UXPeZe1jT7q5VjUz8rdYME7X2g7L0JMLJW
         wGgK5Lkq/e4J2N2qiWY1oHCFQoSgy4WutxN0vsZWjX/CF7AjIvU8uL/JJq0JvvfqMxoR
         LtGg3msGN68Ob+pRqeytOreGIm1EARnRqCF0vneiGjsrMFg9KqTgUTJHj2jV95ZNhvsa
         RJKA==
X-Forwarded-Encrypted: i=1; AL+hErG7vZA+xoBKzxME0pjygYx2sbmVqx2wOuLC9n7747W0kjpNiRbhP6pPLW4822raqfbUgnI6yWT/kNQArHOoAbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E1+LsPBBGpPS7/bg1MIhzghpYWeexQxoizU7mULI6AOM08ft2
	z0PFaoEU64Jna/AD4dMrEIIdPQCcl/h4ud0+3LNb4VRXvETkYX7NfSnTdKbmqY4fawy//epIEDu
	vJYL4gEtzybdXhGm3VjPNOG2nWN8LvSI=
X-Gm-Gg: AYBFou0tDe11kqa3nMFb+u93L1KpHoy1HEaJbVMfNDq0aC6NSNMIlb1qISX3MLbRzik
	eGh1BV//c9JixfnVR/r2KfAXG8MxXtqSY2gNvpQPdPDeyUo5OjkVfviKr16WuBckNZV/c6FjgUn
	g4r74VJhIvh2coBH9v8+YMJvPVKqN4EOa0M1MmUGm3RIa0oM5HhyNmH73tYFnZ8ctbaLKYuZJ9o
	qSzWKzaCzmyc9IfWF6RAtDsMks1fzEPuk3SVKQh1BAd6iqY1x719BEoH+X3qiAtVe8yIvMVNcjl
	C89hm308J5oVhHg+96rpv7uvfqf/oVx4/n+PcpteJdkCgdp0/7T5fuX/VGuxaszpnrL0pF6Uro0
	D1oeUH8BxOFI5XuD/gm7mcfWiEglwLu8pIX4UKS2QP1FiKAyuLfVqrrg/3tNpLO6xz2ycAQ==
X-Received: by 2002:a2e:a882:0:b0:3ad:f0bb:3463 with SMTP id
 38308e7fff4ca-3ae0963fc63mr2890711fa.18.1794292981968; Mon, 09 Nov 2026
 22:43:01 -0800 (PST)
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
 <CAO-4RZ0Od63iUeFkoPznV4vd84Ghjii4CGo+khybQckCv=EXkQ@mail.gmail.com> <931108a5-e880-4b74-b5e1-8625307af8a9@linux.ibm.com>
In-Reply-To: <931108a5-e880-4b74-b5e1-8625307af8a9@linux.ibm.com>
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Tue, 10 Nov 2026 14:42:49 +0800
X-Gm-Features: AclHuK__sIkjq6_P0UP8xexq_8RLljwmoTcqPN_jWYXn2fvdpqhywO6VO34HsQ4
Message-ID: <CAO-4RZ3mtXVty2dhjcT=ZX9mGnsDsYrvYe4Mx_u1TBgF5yi9PA@mail.gmail.com>
Subject: Re: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux 7.3
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thank you for your question about closing the server-side fd.

Short answer: yes, the server-side fds are released when the
reproducer exits, and the hang occurs during that release. The hang
reproduced in 4/4 recorded exit-time release attempts (three with N=3D32
and one with N=3D4). However, our separate tests that explicitly call
close() on every ioctl-returned fd did NOT reproduce the hang.

Since the .prog files are hard to read, we replaced them with two
small self-contained C test cases. Everything relevant to these new
tests is now in ONE folder in the repository: minimal-c-repro/

1. What is in minimal-c-repro/ and what each part shows

vtpm-hang-minimal.c        the hang reproducer (default N=3D32):
opens /dev/vtpmx, creates N vTPM proxy
devices via VTPM_PROXY_IOC_NEW_DEV
(flags=3D0, TPM 1.2 mode), and exits
WITHOUT explicitly closing the server-side
fds. The kernel then releases them during
process exit, entering
vtpm_proxy_fops_release().

vtpm-close-minimal.c       the explicit-close control experiment:
same creation, then close() each
ioctl-returned server-side fd explicitly,
printing a timestamped line before and
after every close. This directly addresses
your question.

n32-auto-hang/             the N=3D32 hang runs (3/3 recorded attempts;
some performed on the same boot):
serial-N32-run1.log       INFO: task vtpm-hang-minim:9397 blocked
for more than 143 seconds; a follow-up
report shows the task STILL blocked at
286 s (the log ends there, so the stall
lasted at least that long);
serial-N32-run2.log       additional hung-task observations;
serial-N32-run3.log       further N=3D32 reproduction evidence;
N32-run2-sysrq.txt,
N32-run3-sysrq.txt        sysrq-t captures while blocked: workqueue
tpm-vtpm shows numerous queued
vtpm_proxy_work instances; the serial
logs repeat "tpm tpmN: Operation Timed out"

n4-auto-hang/              the first hit (N=3D4, 1/1):
serial-minimal-c.log      identical signature =E2=80=94 the hung task IS
sysrq-t-minimal.txt       the reproducer process itself, blocked in
vtpm_proxy_fops_release() ->
vtpm_proxy_work_stop() -> flush_work()

explicit-close/            the explicit-close runs (your question):
explicit-close-N4-log.txt  N=3D4: all four closes returned promptly;
explicit-close-N32-log.txt N=3D32: all 32 closes returned promptly;
neither test reproduced the hang.
serial-explicit-close.log,
serial-explicit-close-N32.log
the matching serial logs

small-n-miss/              negative results: N=3D1 and N=3D2 attempts
serial-small-N1.log        did NOT hang within the monitoring
serial-small-N2.log        window (no INFO, at most one
"Operation Timed out");
campaign2-console.log     automated-run log with the same misses

2. What this means

The hang occurs during the release of the server-side fd: the
blocked task is inside vtpm_proxy_fops_release() itself. In the
reproducing cases, the fd release is initiated automatically during
process exit. Explicit close() in our control experiments did not
reproduce the hang.

vtpm_proxy_work_stop() calls vtpm_proxy_fops_undo_open() BEFORE
flush_work(). Therefore, STATE_OPENED_FLAG is cleared and
wake_up_interruptible(&wq) runs before the wait. Yet in the hanging
runs, the wait persisted for more than 143 s (and at least 286 s
in one run).

Earlier sysrq captures also showed chip-registration work inside
tpm_transmit(), reached through vtpm_proxy_request_locality(),
while the serial logs repeatedly reported TPM timeouts.

Since req_canceled() checks STATE_OPENED_FLAG, we are unsure why
the pending work can remain active for so long after the release
path has cleared the flag. The captured stacks do not establish
whether or when the cancellation callback is evaluated. This is
where we would particularly value your analysis.

The hang is not unconditional. Explicit-close runs returned
promptly, and N=3D1/N=3D2 did not reproduce the hang. With N=3D32,
exit-time release repeatedly produced the prolonged stall.

These differences suggest that the timing or ordering of fd
release relative to chip-registration work may be important,
although we have not established the precise cause.

We understand that TPM timeouts are expected when no userspace TPM
server responds. Our main question is whether vtpm_proxy_fops_release()
is expected to remain blocked in flush_work() for several minutes
under these conditions, even after STATE_OPENED_FLAG has been cleared.

3. Build and run (guest needs CONFIG_TCG_VTPM_PROXY=3Dy, root)

gcc -O2 -static -o vtpm-hang-minimal vtpm-hang-minimal.c
gcc -O2 -static -o vtpm-close-minimal vtpm-close-minimal.c

./vtpm-hang-minimal           # exit-time fd release; reproduces hang
./vtpm-close-minimal          # explicit close; no hang observed

4. Repository

All the C test cases, corresponding serial logs, sysrq-t captures,
and results summary are available in:

minimal-c-repro/

The original syzkaller programs, kernel configurations, QEMU command
lines, and earlier reproduction evidence remain available under:

repro/ cmdline/ kernel/ logs/

Repository:

https://github.com/Zheng-zheng-codes/vtpm-proxy-release-hang-repro

Best regards,
Zheng Zheng

On Tue, Nov 10, 2026 at 2:15=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 11/8/26 12:15 PM, =E9=93=AE wrote:
> > Hi Stefan,
> >
> > Thank you for the patch
> > ("tpm: tpm_vtpm_proxy: Set STATE_OPENED_FLAG before inode is created").
> > We applied and tested it, and we have also reproduced the boot warning
> > Stefan reported and identified a sufficient condition for
> > it (running without KVM acceleration). Two findings first; "Where to
> > look" at the end points to the exact files in our repository.
> >
> > 1. Your patch does not change the outcome of the hang
> >
> [...]
>
> >
> > v7.4-rc1 is affected as well: drivers/char/tpm/tpm_vtpm_proxy.c is
> > unchanged between v7.3.0 and v7.4-rc1 (empty diff), and the same
> > reproduction hangs there 1/1 (t=3D402s, same signature).
>
> I have a hard time reading these .prog files. Are you closing the server
> side file descriptor you are getting back via the ioctl to /dev/tpm?
> Have a look below. If not, that could be the reason why its hanging. If
> you close it, it should clear the STATE_OPENED_FLAG and wake up any
> client waiting for a response.
>
> /**
>   * struct vtpm_proxy_new_dev - parameter structure for the
>   *                             %VTPM_PROXY_IOC_NEW_DEV ioctl
>   * @flags:     flags for the proxy TPM
>   * @tpm_num:   index of the TPM device
>   * @fd:                the file descriptor used by the proxy TPM
>   * @major:     the major number of the TPM device
>   * @minor:     the minor number of the TPM device
>   */
> struct vtpm_proxy_new_dev {
>         __u32 flags;         /* input */
>         __u32 tpm_num;       /* output */
>         __u32 fd;            /* output */    <--- this one here
>         __u32 major;         /* output */
>         __u32 minor;         /* output */
> };
>
>
>    Stefan
>
