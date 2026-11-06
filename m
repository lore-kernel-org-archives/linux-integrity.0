Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793928167;
	b=EXS+n7VSyxg9pLdmMwo15YMf+8AYaUOFdAYc4rV2I4obtL857Hyu609FhWMottstZOIp
	 Ed0bWjAI4wAFVSDnwn4iEme9yjqaauoeLg065/bmOH7x1+tUg8lK3L0+4yQWzuNqq4zSr
	 QdM90JGoFQtsMBO1moa7kAvtUDjUwH8zm/jUGTM3ExJ6STfMzTBz0cr5S7FLvYSS2ZcAs
	 W6tJ12I6nHHmywPs1PqGxgi4ReR82v9Ir9Bf5//AN3dyL3RhduBfgJ0KezpDjLWJI/JhD
	 ooLQEuA0e17mUCNP8pSvZSDCZ/Wbu2Wsp7xebXbH5+llNT1tk72aJDt0WenJzK/SCJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=IUuqjSn3bTRzGBTHD4VyLUtn0G5WTtGjvPKDKuezi/3tjN40gfsvwoWeM4KXY9j5RJ2N
	 hh89Q4IfpnhQ5590s8GjXu+WoxGbR3RQJ/8220pFXdltPOcSf8ewLic5NzRrscwPZ2l8s
	 B44HGnnoM+5F8e2ZOZFBZVyqa2ZOd/NZs2IjcbUwnq2jtiEpwwcjaBtsGlJ91l9526Zy6
	 N4Dad1VwnbsP2qcA9Gb7LG0xGzxmL7kCxl39EZOpnTp9D2IuM9KMkcRKMtclrdUmYpXit
	 JuBscFhUZ4Fi3zPVl3P+kJlZ+oMzFUnRcFqvxzOns2zNQvf4PHC5NNUC/iVdJkn+/Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=fail smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B4606A32F
	for <linux-integrity@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 465B4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b2382bf051so33735b3a.3
        for <linux-integrity@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=Vu6STKZtEkmMSNI6H8PXZOCtGMCCE/tTRtJOLHpveFMIHe2fZ/Nkyd94IWN0KLwZfe
         91rBGgIi0kD9Vo3Fg1Wk2WOERrnjBdclsn8CHqkPKvO5lC0YXl7+VhpgWAXJnijE1yX5
         QVnu8GgOC/Pk+PfBVQDRqQRvOgYsaddTrqYG7WL1hAFVjBrLwZxRRLbuzWoz56ZNwIEW
         BgdiDlD094OQSuZatT58jqdMCmPjnyFq/9TBW+wvvh/K3zYspnmR2ipLuq2QTuq83+op
         sBRhlHJGO8SNf2ytS//GwKLKHVGDxqFvXAuOmTg3ACIWlOKy3pAwK0okt/G6gMBN9PVt
         rNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=FLkQwXy+Tzt6w7MgKBN4vvs0Qq5/FdWF6NeoZQ+eFkw=;
        b=CF1AtQ0xCyquC3zM9BsH4oxBIgFNJSXdW9OK8vRkmLS+RjWVuTs5QYl5905dhYxNjE
         feq5zVmuC0WBCVFoJKA9mRQ6ThXAtfHA3f6Kv877CY8PyHp9EaV0pfjRm3tUfIX9mVFo
         t3VvFlFYIK/3gY2iOHtnYhhhAh/0Jo3hX3Q7WBhVRjh6kFe5LdggLLaki3v/58Eud78V
         kdI2pgZFvfdNsuMg2W+ibTEOlj0lLc1PkGET8CDlO4fpm8j94qoSSzLA0voqEpGDdgc1
         aOfrBxyhy8WCQaHgh2fr2/OaYs2ZQXXKRzT/Pp09qzsX86eHWftKJ1nViKZ7JFdrc9GX
         V8tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=OfZLaHfXSmmOe/fii/FawwwpyJOUsvIQBufXcKUtyeXBlUFqCQ+geYXGFCZJIsmv6M
         R/FpNx2/xNvazjK50RM3pNRiCd8CsF1q14GSS8jkL+nCm965Pc9+yXYiM/dxAzuLyGlc
         hUe0Y7NKfNVctcRT0WfDViRSPyTQjIzn/UnQWsjDLIx6wWXIO36HFKORjtWpOaiq6UoG
         prjvEGn5SrdJa8DLG+bXvaRkTqOnVoupyo9dJ7HxxQY6pV9uG6XwR6dsS6zG00evrGIQ
         lP6ynomCI9PYII8yI+gGPNbu3Q0rZDx31teN0oMYczVQ8ElXgLuRF5q8FZfEbvL80oqd
         TXcw==
X-Forwarded-Encrypted: i=1; AKwUvByO38IebLmXB4rQCXNG3lkYiXQRO1gnT3BAWkcsmn2MN1W14EbfM3LjlD/SojXVpXPmWhT4er67kADiEA81lAY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3TMNTr2YByFJvIYmwN6trHssttQagk29xTFPStNtqog8GaZBM
	1nL6Upz0fz7//ynBH1U22GlMp0DmhXowV6do5LDn9OUz4c/O2jsEJRp6vfmzGxfqg1Fj9g18PGx
	afFysN8N1Ov2Q5lT4jsgTTA4joF6ZWdu5YICp2EMn
X-Gm-Gg: AYBFou0zQVpA8GeXPqU5fpNzjedmuq9o5/cfoHLDkZL0lQR7TqZzxMWP3kMY05Y3npK
	vJQdVTqmcjTO9ROmImeEu7usbZLwBRejmJUAxRUveWZYuLNyCz8NLA1xjS26y+V/sXTpwsOV33T
	7pipxhQW1mAbPMNLE9j9lYaX61IlkUORzJUgWHT1uVrjRjndYYX94a80f6h0MrU/8OmQFdfrQHI
	7HtBpVpCf/Qmu9OfTUkp4xKJYnA6vuxZ6mo4kcvWaf/qB9LuRwSgU30oVocdsTAhdrTWAk9dt6R
	4fTsPXRS6QQ1/+L4MzFynJoBhg924oTGUGbATqCD/DbJi61mQy0Ck35WLxc+QfxQGWxPRSH1SUa
	01uv5e55WChobkDss+Bu1k1n4NBJUOyz20cqxBYAa7+JskzsaKAT9GMN/zQBJPpTtW7pS
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
