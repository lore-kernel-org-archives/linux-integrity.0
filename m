Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793641053;
	b=xBUmvQ6MBxyCk9E5WgnEXlwTfrEcmQXxGxraqQWiIVb21ic51c6yv3GfAcl1We7Q/y7x
	 6h1xY5dGpHzj47eZ7L8CpIl54F33qIqxdY1GOSFFeTvuZA9vuavnTJao3GQ32CFkC5HIv
	 zrLz7sH8kAarSVk5iRQHLj8UAazvRYJPn1Gd6V8iQoLifG3pSFb5TbsppTUFop4NLVzSG
	 ICQuQ8l4W38qKCg86jjxSuobbLCRmq7Xz6Fe+5DUcIDlWauRgA4gtnDLiVkEX5guv5wsd
	 LU9dy+wtIh+tHYYxzI9wZszNAG2JY89XaMKmUo2T6T8K9+nuu2c9C9TlQJ5AaxEQLdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gPugNcmP49mQSZZGbdfraCdWpP8WlOkdDnudq9ocJd8=;
	b=1CGdBmpxsz8tZrpBzdE/rK7N/tz7SVxEmMli9thcuatK0uW0Mx5nNjMEoCShq+g7tXSm
	 K8UrZJcjUDLaheiqINsX4eDBPXd0PQwsFQi2SKJueaaNJmHNU0s/LpHXlouF5XGpEWpZS
	 saYzDT0B4VUa1d/WwXka21bZfKbjTpY2c0k91F5vyi/iBhKINH7rLOEwkp6ZyIA9g566z
	 lvCfljdCHuJTCaEKvNVahve389ciR2wnxCASN7wrbr2fGn6+ru/lRAvyNWi9SLbt+BFiH
	 Z6CFWIKfmr1USrZENgopY4OmniY5XHeAb2SoGwMiEDu1xibzcdikMBNF8N5t0Vn2zeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJ8n+ZTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33739606AB84
	for <linux-integrity@vger.kernel.org>; Mon,  2 Nov 2026 17:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33739606AB84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJ8n+ZTD
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2ac79b69so25123531fa.0
        for <linux-integrity@vger.kernel.org>; Mon, 02 Nov 2026 09:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793641051; cv=none;
        d=google.com; s=arc-20260327;
        b=ed8fUABOa7lNftVxCUf5zHNl3/DZMecs2YTP5qpv4RrwmkHU9OWaxW06Lr4Wa0MqQN
         P80qGcxeKYiMe3xf0YokoS7CulZzo9TECAC9dkbAsoiKYg9T39gqPy1aF+rnK3iWawVD
         Ui2qUSwabmc4BThIgPZ+Omb8aE5/XvQz1AOlBLkz2v7XffakYMgtYviULd7hT4bbxWZ5
         GljncezccaorrLdgyt6DAg/jIfYVAUeriz+kPdkXo1STZfOB1HBrdDBgaI3zdk4eNaaA
         V7tmvk+um0AEXWt49fJ2pT6uTVH0H7h6ZNfxF65F/xaZpznnzybIbc2BlN/rW7QZfWTO
         h5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gPugNcmP49mQSZZGbdfraCdWpP8WlOkdDnudq9ocJd8=;
        fh=NJ7jmBThqmq1UrY/9v0jAMLGtEgg/+90L0pGwRo5htg=;
        b=ONtOQxnPauMOoXmWI/MWGglRmUdZkC+AYabGv5K7AHhneJMkmSPi5PrsCEPbnkxWs4
         Ur0WcUuVyaSsUBtydHyvvykeCJcqDmxJzmchcm3VzJOdy6HfU7Ur+TziA77JAFIV653C
         K3E1I+KRw6qSQvlBZO9N+Ksi1ZGlDVIrvVTxbSCXfrrMiPEImfoV+Ocr6FhlEDqNcRqh
         LuAGLDLMBsejQgl8RZVXc6jZ5RMgGRtGKSjr84n2vlxbxlrP1RMqCh1Mhguf7RygjabK
         dUXu08BlqM2zwSoqMkzteAeXzVp08lr4lMAlxfh0sskB5nthsxN4udQSCB3A+mD4ntIm
         vqeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641051; x=1794245851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPugNcmP49mQSZZGbdfraCdWpP8WlOkdDnudq9ocJd8=;
        b=DJ8n+ZTDiKHQYQRkmB3Z65u8ghSkw9esMOABCYibHf0RhLKfDbhByE9XuUtTSisYl4
         VptH9p7Btoasf4Q/+82y3cGB0DLOrH12Ro40kyE6Ygp9Ua0RN+iZw9e1U/THV4B//6Re
         2qnO3t/v/bVu4LaLvsjuLvuBX7Qe0OCc7Ag0H+b6zlSr6Hy3h0mPbLixg5wlSYpqxj9K
         vyG2LgGcgxmggnfiJYjCGfhWqfWhZxc64gx70xpQ8ByStsKAroQg9LELKBvqc0kVheU9
         vxo4gjPxV1HL39RlDNQ2Q1Jfw9eLfHrlkVNsnQSpHhhv/nlVED+Hr6cjCjAeMo1NMx+B
         1Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641051; x=1794245851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gPugNcmP49mQSZZGbdfraCdWpP8WlOkdDnudq9ocJd8=;
        b=PYIi+L8gsDyG5LFajf58+xf9qS8606nP4flWctbvgsXGL83GoF40yF52liOKMSxD+E
         KxbUIJ1a3vf/2OUZ9+urLkrZcEMp0sK1fW9Vti3DOGzz22wRMhTMVEh6OQrd8bjL3Gca
         tjEEivTa6vo0B9QjMCzVG1XIhHAb3p/d1Aa8ZAfyNNV8UwQ8ZHtIuuIHhCxoYOAnuOIs
         lTLZnBvTSpeT2JXZ41v9PcYZ8Ye7rdL5MyeYRHxfaw0FRE4/C7VlzWNHfrBb1aEf4Lor
         EsVALy9T32uG8xCkpT+WMxelCaPjJqNICyFF/bt5Kp0Z8egzLbVSP9JYVOWmBRAjGE14
         eaAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGSQ1GuZ2PAuIKAzxkI/2+42wNYAknBBjSSFLg/XJHlfG1i2R4XeTqcNBZ3v9YJ3bp2a/WVMlNfbSwMEXO+Pc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MUXv0Bx5u3qL9NEu6pFSk6OxXsxwouLrooGUwH9RyXeyapQ+x
	BsKUcXOJo0up0AjkllUaUepCO+NDzAjJ5/Q9NwXTXVWwzOQ8C22YHPfiwrluOw5G+2jzA+8paZE
	JFhYy9q3awIS8ylIzmr71R+bwyraHMN4+XNipzkIVcpbeHM09Rg==
X-Gm-Gg: AYBFou1NNfj7i5vyQsNvf8vR7qw5UoPqeOe2j7vWgSOiyxnhbbaFOKVdi4eFzkbqJWn
	SOcP84u3i/UF6vtxjCTQlgcTMLzWu1FJvy1zTg5zqFDKZx/iS7sb3dsWh2MchKS64nfhU2KfOjS
	CJW13jLWhVE1Iz4CU/yWqxeC3Wn9AmCGOaAnkgsuiMzxSqIMaYb+Xtk8gFVSAfe65DrH7k2ptiA
	kuZNzdfy95Fw7dcfgnyf9yOujCd+ofmlNp6mnfCU7lXG1l0sfqUgMFimB8awrdEohjHqC+8x4TN
	t70aZQj1nvnpvdTMcb4ZbXbVReYjBUYqF5OWve/6a7spUGrHu+M18a4n1J/himm2omtCz4DCtnx
	xUU/jL3rAiP3QTc6CWX5VTbeBl1y7lu2457wGLnQ=
X-Received: by 2002:a2e:bc1d:0:b0:3a7:69bd:80ad with SMTP id
 38308e7fff4ca-3acb7a65e35mr29613041fa.6.1793641051096; Mon, 02 Nov 2026
 09:37:31 -0800 (PST)
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
 <aud4isATIt0JOOL_@kernel.org> <1c0d3129-e1f7-40b0-81f5-9cf4c481aabb@linux.ibm.com>
In-Reply-To: <1c0d3129-e1f7-40b0-81f5-9cf4c481aabb@linux.ibm.com>
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Tue, 3 Nov 2026 01:37:18 +0800
X-Gm-Features: AclHuK85iwJWc6Di1ZBloZBYG-JauYSsIyiam9_waOqwD0KPEMX3vawm0p6o8Pc
Message-ID: <CAO-4RZ1zzJBVLSZFcngr+9BUOwOP65Saa6q8dS8xyLo0xQNo9g@mail.gmail.com>
Subject: Re: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux 7.3
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stefan,

To make the reproduction evidence easier to inspect, the repository
(https://github.com/Zheng-zheng-codes/vtpm-proxy-release-hang-repro)
contains five positive reproductions in total:

- Four replays of the 50-program single-file reproducer (one automated
  and three manual).
- One separate two-step reproduction (a 49-program state-construction
  run, with the hang occurring when its executor exits).

The serial logs show the hung-task reports, with the release path
blocked in flush_work(). The accompanying sysrq-t dumps provide
snapshots of the tpm-vtpm workqueue. The first captures the full
running chip-register work stack, the blocked release, and the
workqueue backlog. The other dumps also show the blocked release and
the in-flight work/backlog state, although the full worker stack is
not available in those captures.

The files are:

Serial logs (5 positive reproductions):

  logs/serial-7.3-auto-repro.log    -- automated replay
  logs/serial-7.3-manual-repro.log  -- manual replay 1
  logs/serial-verify3.log           -- manual replay 2
  logs/serial-verify4.log           -- manual replay 3 (with
                                       syz-execprog stdout in
                                       logs/execprog-verify4.out)
  logs/serial-twostep.log           -- two-step replay (with
                                       syz-execprog stdout in
                                       logs/execprog-twostep-step1.out)

Sysrq-t task dumps (4):

  logs/vtpm-sysrq-t-all-tasks.txt   -- replay 1: full kworker stack,
                                       blocked release, and backlog
  logs/dmesg-sysrq-verify3.txt      -- replay 2: backlog and blocked
                                       release
  logs/dmesg-sysrq-verify4.txt      -- replay 3: backlog and blocked
                                       release
  logs/dmesg-sysrq-twostep.txt      -- two-step replay: in-flight work,
                                       backlog, and blocked release

Campaign instances:

  logs/report-7.3-*.txt
  logs/log-7.3-*.txt

Answering your questions in order:

> Four runs out of four?

Yes. Those four were the negative controls, not the positive
reproductions. The sequence was run four times on four freshly booted
bare VMs, and no hang was recorded in any of them:

  logs/serial-7.3-bare-no-trigger-1..4.log

> Does this mean that the 'scratch/pmem/NUMA layout' is required to
> reproduce the hang?

That was not established by the original comparison. The bare-VM runs
differed from the positive runs in two variables at once: the kernel
command line and the QEMU device layout. Therefore, the original
comparison could not isolate the effect of either factor.

To investigate this, I ran a controlled 2x2 test matrix using the same
50-program sequence, the same kernel, hung_task_panic=0, and a fresh VM
for each run.

The results were:

  Full command line + full layout    4/4 hangs (one automated and
                                     three manual replays)
  Full command line + bare layout    0/2
  Minimal command line + full layout 0/2
  Minimal command line + bare layout 0/4

In this test matrix, the hang was reproduced only when both the full
kernel command line and the full device layout were used together.
Neither one alone was sufficient to reproduce it in the tested runs.

The 4/4 result counts the four 50-program single-file reproductions
and does not include the separate two-step reproduction.

My current hypothesis is that the combination affects guest execution
timing. Possible contributors include page_owner overhead,
initialization of the additional devices, and NUMA-related I/O. This
may increase the likelihood that chip-register work is still running
or queued when the closing task reaches flush_work(). However, the
exact mechanism has not yet been established.

The logs and per-run kernel command lines are available in the
repository under logs/controlled/ and cmdline/.

> What is 'device layout'?

By device layout, I mean the virtual hardware configuration and
topology presented to the guest by QEMU.

The full layout includes, in addition to the root IDE disk:

  - 8 scratch virtio disks (2 x 16 GiB and 6 x 12 GiB, created with
    `qemu-img create -f qcow2 ...` by the QEMU wrapper for each VM;
    the wrapper excerpt, the sizes and a `qemu-img info` output are in
    cmdline/qemu-wrapper-scratch-create.txt);
  - 1 additional virtio disk used as a write log;
  - 2 NVDIMM/pmem devices (1 GiB memory-backend files each);
  - 2 NUMA nodes (2 vCPUs and 3 GiB of memory per node).

The bare layout has only the root IDE disk as a block device, with no
additional virtio disks or NVDIMM/pmem devices, and a single NUMA node.

The repository contains a captured QEMU invocation for the standard
run (cmdline/cmdline-7.3.txt, with hung_task_panic=1), the kernel
command line used for live retesting
(cmdline/cmdline-7.3-retest.txt, with hung_task_panic=0), and
sanitized QEMU argument templates for the full and bare layouts:

  cmdline/qemu-args-full-layout.txt
  cmdline/qemu-args-bare-layout.txt

The controlled retest uses hung_task_panic=0; the per-configuration
command lines are also available in cmdline/.

I hope this clarifies the reproduction conditions and the distinction
between the kernel command line and the QEMU device layout.

Best regards,
Zheng Zheng
