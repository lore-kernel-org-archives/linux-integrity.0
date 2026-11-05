Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920680;
	b=E6WibTjw9ipECJYTwtrAPKMdLJrxSM0t2C1gGid1z5QsWlpW7NOVlxm7l1BI0i0Eier0
	 gSusNL8qhD5m6BPo+H9ic2pt9uphpup5oeLl9EGll4Ak/uFZk3jVmP/zVpzjbXS1oGmSZ
	 JhxvHUr2pmwTC+wClBAGNBjyVqol31SJMCH6QOM2CJxPG0egLAhuMwTve7D0QSEPVzukf
	 182z5lxw1/i1gju41ubYYaGjW97Fpd1VS4qU7w6qKRE4CePmPhzzGFGu5cSPNjfXQbOek
	 yiivgUSrVcHeCydiHfDBpi5bYOZXrSsDUVgNYIOfsOW4Z0QeqSJFaSFY86Nexak6wPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=tf/ZFX+ws25CIc+BwKO4l8Z0sjeWq+gCyYQc0cjGs6GS0biY+iLQv7c3dDzzvo5o2vNJ
	 XJc/oWGvwS8OYFnSFcw4nwyVYjNcSo7Tb5TU0Xkx6u98TeAWA4SmbuxDolTbb5c8WztOL
	 8D9IuB7XQCd+n7QfK1VXWou8mY5qFbv1Vq9oi1cR2CbTUdYwNaf/wXwexkxT7bHMAzJ2g
	 I08u7b2mH6tRPPF9AITSNMl0pOSgdPrQx5tI+pvTU6ecR7c3HKPbtHS7JX8iCrXTO8A0V
	 yXrF2DvaqVcUnINkbGaSGDoXHb5yKwU1yw24lkvIZw7HP9OP2WQ1Oha2UT8ZWifbMVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=fail smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186F606A330
	for <linux-integrity@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1186F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso31384a91.2
        for <linux-integrity@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwybCDAycv4V48aF8uCtnTdgjYjV9Yg6HR2uII+h/4ptu3ALTlUbYOkOOZQbfb9rwq
         xtTgyW9eDZl0Ba0TUUo1v2f6L2sZRPucYt6buSQwpIQA69U5UBcSms+FESmFndx9AplS
         F32eOYWj0wEugs502I46iFq0TiJ8TNlF4jkmLWjBJsM46MManANXumw0yHAU2jtJIjf+
         5PSJBxgyvEitWDQL2Dcpc6Qjv7euxYEcsacE0pz9adJLFRX2esPMu5FQ+qvuM7LXeGhq
         jc+R6WBL7e1kjGbSGfUTlXW+tDdCoDQAHQGtqyWN9xfDp/K41GgBCMCla/biy4YvKcgd
         yGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=L0CO1ApsL0Y43bI5M2tu2cOggVXlf/srl+CFoBrLaN8=;
        b=jqYPMhtTINlAlJ4JQwcZgUKQ7eG4SNEHhC8hhfG0tpPI7oqPZvh9iqWXLL9qFdMVCY
         dc27o7802gxgxIjDK++QwUt8eFjOiQnIYJ0iUFNthshD1WFgxKR4kZsVRUzWtTJfK1hY
         SKbC3HyjoyrDCYQqu92t54vnaW+k0/RYk+tgyieFstsBAm+lo47ZMLQAOqNQ0Bl81KaZ
         HZ1zWQVZUVsidzYcb+S9v0Bs0MnT9wbZxE/rdHgT7mf8+aQW8N3c1/yLUi3JMthuFuAH
         eZb4QvBbqH1o8oKphUnKrOTI5wbphoE8TZIbA8Pj2GfvDw90fep38j7vub9LK0j6hLlh
         vvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=AUf4rLf5yMCsOm/UXf9uv+LXrPNkKvmX9w61iQAZHwfY+0e1iJDK29Usjd/zZB3hGW
         xMneubZZE2+FdHy0zaSgVV9i3SmBsmaQ8kmqB5sMM8KNWaxQMBkxp1I7UDD3t6oGyfMz
         WthtqA9cRCvvCLgY01zMpdusyQ1cjeE+rne8PMdH0bRePFHmYdZN2ifojTKQCqcS6bFB
         XpOwg7Y9UPudqdUjD79nMedvpAE2nW1hLiJ/jtBlsgRY/pfjVI3K0bI5x6/2NyYFp34F
         z8gQdzPANLWQUk2s1wNPhkMOxIwKXM3UgyL5NZ2gpM1cYucCiSCZ+a3DHo0tRerwqOXR
         pR7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzw5jAARasII33h95u8egMVBlxMqegjZbX8JUdN/YyOHBfivwzUwMF338PDzJJrByxWshNd9h05gOSuWV3onXY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KHYwydaGm8f8prdCkdYSPn21pfsXQ/fDhjOVY/LMO0dDsXjI1
	mkDjpITcXz3fxDTOZbzZWxSoMDIbj+HiYCiMG5ONoKwQ7JxwP/1lOSDmtMi6DEUkprEAgJx2mUH
	mwyOH1BMASa0u3FhP+vwE3zGphos5GA83Z813t8Kg
X-Gm-Gg: AYBFou3/HAjPVXwamBIotNikCGYQqDNMnh2CidMm9nG/kdLcHZD1SGGH3hkMpvVxX/M
	TI1WC/5tl/5GatBOLwkYkX13HceaOg454ldXAmhF8v6ICPbwN87R75jNj+cgWvL/a+zX/lfWufL
	hZeVWN/Wn5PvChqVuFdBZO4lCqhlbrnwS7Bhzi9uyG+BeeXpz/BkhYVc9h57mxF+sG4PiF/5073
	Or7jJNhMzmp0ochedUVuQCVSOVmSyOOuvUr1pM3+s6ygS5B0/ozrrIF2izQgDkOjT6P/y9xmPYv
	wlnF5OyudVVpNLqe7IBAiVi70L6xZeovb5Cbpjngsq+N8dLD4Wt66FAxnOa4SochfErhkD6QqrL
	YVVKIAkMR7IU5X42LRwmWDB6c1z25I+0ajcjUZdlS6EfxL1V6FojwnTY5KvGFUTcuACuJ
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
