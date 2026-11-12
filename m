Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461789;
	b=WssyisEsBdoIdgHbc/Cmog2dav0rjy4fhqbeB6ImPLgNGLERvcC5AW1SVsG1HBIzKEo4
	 h7VuhFFm88NFdl3TcybrkKM9Iah8gmcAuWn7qEOcJq1JWsfd89mzWyksV6PrN6fzHv+pu
	 LZejiu3iWiwIK/JiUgPLdxl8R4yosJkVy0w3wieeuprNUAnVuRCfaG/ajK0NrlOsJSwk+
	 tCuRK0Xz+Ep6T7JLnBwA8ytGSzcNDBXrKXyWlLgpHr0nr0OUOktitZEZwbjaprC/gS4KM
	 5PsQUN2reMj1rTcYAis6+aFZawvsJNlWmRsOTn5BBtN4ckQ6wpSGDT+sOoHBuBazfLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=BasTrCqg2jQe8fvxOjAcD+Gp/Q+0xMu5pAmpvPbNbhK5lOsWC7s1Wmhxi6LL7lzbzyBz
	 dHnMXRsq1H2ej+F2/a0SgdBSmF63cZNOp9hetr2yVhgV700SguZOLATQfleupX+pIpMGg
	 Iaa3okS23DkDg61Df9V+RR/fYt7oUogPh9sEmeIahmf18ICLPkfTJAfglh0IFvfs0Ukub
	 AM6fyQrnxvlFpgIKmy5MqBAXslJSfqN/QvaZwkXCTUiQ44VhZHcIu1x6DqvsmDFRK5xea
	 NkblSmIjprJ325p3S9hfO0WPuyeRUZt4SSzzqv82wpaqfCfVF6RN/rAzc37KL5Le3ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C179606A321
	for <linux-integrity@vger.kernel.org>; Thu, 12 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C179606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e6eb77f0bso350311385a.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=EzLeINlqWKLSrVyAYeG69cub/PpkhXEpvLI85c2/Wn4DBrX36De6eOjOc825yh2/s8
         /BMocYYbFGCIGlSENImF1edskqevAV/Kuf1SeaFnM5vAAp8DG8IO1FgayCsUEWs73OHL
         1RmURtZJc9D4dd17Nf7TyLA18R4yata5cpiLNB4SZ3wXp+wb6mfksV9V6NYOJLevPnzx
         KS0lFdrtd+eUvcxCI5cIGAuAdA3+x/lK/g0n6XOLpuLtAwXE7FSdI5GYz16DwRhEZcI+
         e0xi/xTmcXSNKhZMTs2dmsnafffo4Jcsb0EhR1rdi49ZUTTTqLCosCyqFBij3UK+VNvA
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=t03Ac3iJGVQ3FiEM7Uw5pxCetFyC1ySh3wPQIJ1LbcHxBunoVcGeR4FAAlI6cATrKv
         B+4/SOz3vwg3ZnEuohAEun38bUzyoouHvncfQ5CPx1XmhRduzrNmT06uUvUUxKAYEk3I
         4cmvM7LUH++G7Num6Sfkk9qtugtXlaL3TZM+e2nlGqcJKdzgnMEfbwDCr9ZLcqyA/yNv
         tvxF+OBcBQfjY1W1gdBWM+qpf7u2udLvvdgS6o1clATbeFp04UH/ldNIyvGYH5vVjwDF
         83FMPz4/3I+biynI5MMBF7ylNY/v2MNsPYHavB8F550s4QkuSjry98JgY8EgW0ieTYuZ
         dSRw==
X-Forwarded-Encrypted: i=1; AL+hErHuWBjGbisuJajpNpMqPii6uYjNkS+REuqHp6HHYGmvJF/CtyGb7swiiyTD23Hqt9h5qX5lnwGrFqMbFILGL1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HMFb5ZyABc94LKJ7xK/grqMq7d5z73KtC4ZgXA42FAJ52vpdk
	D+BvsZRaN6hMafbrPAFdzerEImcIug7rsKzNH/6oenenj/AXyFTsNxEWD9Hbx6BnNuk=
X-Gm-Gg: AYBFou1sS6kvR1xmnDBjJ1xtpirUT7ltZnMApltcxAxQiZhM9kh2kkl1iYSf4St7SZv
	awjpYHgmrsxG5FjX3bmMJZm2HWDXNHQwG/9YsuFI/KEjar6kqrKx3mcZyOv4FtJb8nk7NkR0aLd
	QvbjLsAN2miJ+9XRRcSZ29oE3wiCxjcuFZNN8dd4h+gmvDyiMgJJerB/q3EsWMQfQ9odVCRpuPV
	+op+WAVOJ6JtLeFzt6zhcnxXgqN7vt887XUgQJn3tQptGJQnfewpARXRu5pfBC282Vy+QxS5oCk
	I2+KPE4NTL8okoO2WL2OXCjcZ70VrGvd1QsEdj0VwxyhIX4naF/qL/BUiznuoEi/iU81CJGzd6C
	NVrRJMs8O6eS+WSKNack/tss8CRuHeVuCWny6fYMe/yzaTz1S5wBGkaKbbZ7MLZTcn6C7F6drcD
	KQ9u7Sdyb7GKBsWlOOyJMEtA9opXi5zBrQYVMxJ+4uXIAZlLhFQ02Sx0EjruqJtkpKSZnrCFin5
	IGdrMEgCkQYOn5C97eRq+y58JitIVQNrPE0qqvWTEYyh624G1WjSfAbVl1cCz+Uivypz+ZKWTIv
	5BE/cs9OD1xTF53dezLXCPeRsWhOIbyVeRLFply/ZHcqbcQUn++fA7u10mSZBPU0kSjJdtIZwfx
	Wqgfb0w0=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

