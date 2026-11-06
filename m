Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945394;
	b=sRRXMPjPFBAvpBIvp5azuWzMRsECPwPKzJE5t9dOteJ7AwXEWgdAjckfWRVrLbe2R1io
	 SnodDyI3KINBKEUw9QADl7nv60+09JC6dBzmuTrrjnbX/dVTcj1m8MEb8SnuZbuhFjfQk
	 tc3YR/Tlazdw7oMDahX6MYZ/78AJgKbJDN+UozJW2lSExwNpQaWdSj4K61Rcnil4jJnSa
	 bpEl9Tp58Ep05pu16HFpNfhX/urv0OqZkJYNbpX3CC9HfH6NF+p3C0At8u2V0guS0XEJo
	 94s7YmhihdOdcDs7A3Z3YXHFcVBLHRPHZymigRUYQLmtAbK8frnhmlix812JOLOaB3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945394;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lf0giC54COfoOdgBhV+lbp71w6egVz2uLYQE0MSpLfQ=;
	b=LDZbw77pzDN3CTQP3rKzEP08ACIq/G4nTcLNXEBvQFwyEu9AcroTByzPacYB6tNn0+se
	 +cRsxtPkOuXM8TrrSsVEOufEbXMKrSWTkozGGv6/4oZoIUqkQEAIKMm0q6FvVVWwLTHFX
	 iepKgG/wiqisj0arra2Fxi/wT6qUJXwPwPgBjuMKAqW1c9Q9UrNWVxBh254zABlSwOyZG
	 UqEncSPh6mKaXelQPUycr0e9iNXmVvS0EqzWIQ5ozl0vGLwalB416uMUqF3bTwxPcsPan
	 kFUoL6GUurc8LRlibXqmuGX31EQWaRxsIgi0b/GLB6jWZ9A9VWNiwmCf+oyW705DGLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fBum1Kjx;
	arc=none smtp.remote-ip=95.215.58.156
Received: from mta1.migadu.com (out-156.mta1.migadu.com [95.215.58.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53F606A329
	for <linux-integrity@vger.kernel.org>; Fri,  6 Nov 2026 06:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E53F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fBum1Kjx
X-Envelope-To: linux-integrity@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Lf0giC54COfoOdgBhV+lbp71w6egVz2uLYQE0MSpLfQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945391; v=1; x=1794550191;
 b=fBum1KjxXc5aHuwrSqkzF/umohLHIxRvceiC+uyAyeTwLoJU3HpQW+k+droykaRe5TgN15/C
 WGXJGaP/sHZP2OxsFJeTFqrkWqF2u7+Su4o+lPxVcNQr/dAv/ffh8yawOHorsuTyH5iU2NAwjzk
 pnhqkv9t2Vy8+XM3si0JWR5U=
X-Envelope-To: linux-integrity@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fc26a8218d0fb5f7;
	Fri, 06 Nov 2026 06:09:50 +0000
X-Mizu-Trace-ID: fc26a8218d0fb5f7
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:09:41 +0800
Message-ID: <20261106060941.44538-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:30:57PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>KSM tests VMA flags directly.
>
>The ksm_madvise() interface continues to take legacy flags for the time
>being.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
