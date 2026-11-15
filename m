Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716871;
	b=lRoe++Fbx6kSg7U8O4cmBsluJKO1LGHYRYd2wydgMUSVmVI0NZhFgkky2dML5PHLFyEV
	 Fx8bJw7MLXZn2RdyFIUViJNB7UuYlkcIwxejC+JbLlGmJdvEhk6gRgd4kHfVaWbdJHen4
	 bCnx4yoIWTQoaIq7Ltk76gdCwXk23HX+G7L/xWIZNkKEKj1X7xNkM5r4dLjJfIv1OBZW5
	 yAF+BsHtU+rnT3NMZVJlIP4V9EjsbUewPkn/1qqJIoc/vIMBkL0LOgYHtH6Qpm8/qU353
	 09Xxfl7tO1Sd/36dhJtzFk+S2bcl2qUoJL8wWKh1UhJQh++/sliv+t97n5WthBfQ4fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	b=ga+EQqX9fyWGa2WeH/u4pdEqlFX2J+SaMlVAxigRH8XvCmo77eQnsTxLA3qq/nK5fTiU
	 ohJrnXw6ipmGgeOBKN2quUEtBF+g7WCOQfIE99oWv/GgY3Ce5q4GdCYwChww29FL15sEl
	 z2h5cvLFwGAW5RVSalV8lFRPoF0+SBM5/URdtGX91LFZGxInueHhcpE1CSPgS826Yw/US
	 maxYvFFq4jMEqPiVCLqkEACjEsS8BXsmPLaFCZ0Wfab720epSzWNz4H5tySt2ZzI82m4k
	 WOPjhV6jR+vMp8gVUjMUEIRR6/F6242dzIOJn5Y7CjF4B1CX59of4M7EPSescSMlrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55333606A32F
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 04:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55333606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so3364577c88.0
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=rrlCOM14U7o+M+TZUPRKm/0B5X33KfTWozBYOwW7G1T5mICv5uiTGRDZ8N/E/WkgPs
         Slt3WdfVhPxLW/Dfkkb7/xGjvq8CIoTpYPwhvbdCG6Yvw1BgA2N1EVe8mN0kEHKHXyef
         8tQmPjoZ87TzHMHH5DbiUhIVkAX/fu7oGi34+wAuHuH/TAi5YSfzTR1lg6qENJCTh/vf
         bWlX56f+34OBBzkIC9iYt9wgmDyB8Cq+Fbc85HrZX5UgurcmY8nnkwgd3auzrRPvQadc
         V+9t/jgoM5TmoX0d5ZETJARldRFhGcH0iXCu8yq6U0k0i+/1+kk//+frMRudpsSSkh05
         Ua9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=VAeGb8ekQHHje6iACBDfDO3pmn+6zauqnmpjmh27B2/fjWp4EEyYJVDJWAt231hZRX
         rZ/Zr/oPO78Z/lKwlCirK/McP/reLvan3ramAtOfPmm1ei3nt1ogRzn44TTwfy37+IXK
         Wm8OhLVTSbdbje72KOAth/oZ4/pde70V3NJDN1L941lanJhlVTDc7OBe3JF1PsnA0IPw
         o6V3iQVPgMwO92VqbawY6oElDXv2cBReMSt5urhVfub8oS+3t71TulKhecBQNJ99pyNs
         Dlal6+r1+0m+kIR9EmTfvQvmYyxaVtXMGj0zM/B/MOj9Ywqx7qnLm/yxLezdxwe9xXvx
         +Kbw==
X-Forwarded-Encrypted: i=1; AL+hErHRMJeIm/e4X2qfukn/asQL5cgiUDHOFOua49KpcORd3HZ+Wd74CHT8u24toBA2X1e77uF7Phc6bNuFudY1wIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L7cwLHu3bRtWrO0TORj7XMq7MhY+2Gwa2fn01Y6AAknGQK/dn
	y2Qj/OTU1tlYWSHf3QDycDO2Zc+TnDPTxcyXG/Vs/4Dudxpw5uHj21n7
X-Gm-Gg: AYBFou3dsIhooEUhdKPvxA3yim6MaQgTRlUOm+Oyo8/0/qdnKdke5zF/+McJDA35gcE
	BuDqU6UjIC5P+zCh1QE3EI9XurYHqcuDVlYSOGGDkChmIXqq8Ogh/XA8gY9LOyfffMP5MtAohyH
	QDgWsh9qVdkvTbN7Rt4ySvk5sMZG2Y+xBFpsGFYGC6lKKemkJZK6/vNJGGM3Ht9YynOpSCbsBL0
	JCk8F90tEv7mbsRKIF0OOOK7YKWKxwrcy2EErl22arJ/IhNGXTeZKoXzgP13t5byT1MVzkGhpjy
	8gGfVLgQ6vHnzQfl5f3ccPqbrmBgvDVsV9MOW5pR2RfIPNCHS4HloN2LPX4yaUI/T7IbGuWNlid
	a0BelMaBkm+tPKeCYetc5Cg52fpuRA78njpbXtTMKne6JcmHvf0sxxIv0+hw8+Jaor+iXWXmEoN
	4IIZccgAChi+WdHSumC8Da7Qv4yQaXawXp3bCGqCd62aFPhPGCi3Pzsl/ssiMbUonkXg1g3z2v1
	DPR4Cc8jKm1NnliLFbs1jdKjhtIlXLsEnhJh38fP9FHwDvLMmTDaoU6ev5WlFwLNVCe7jPaznxq
	Y3KkAv0PDZHNW7RXFh6BBP5Sxno=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh
