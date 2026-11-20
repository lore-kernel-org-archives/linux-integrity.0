Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217668;
	b=Uao5eTVTr7LY/r6f2IPcd6dyaimNVF5zsx5VIYnbW3YpJdmDIGyKniYkxIbzs6fKnbM6
	 vzpnZZ9keEbWyZ3NKSD7DvzcJxHwSPniRJg27BusI/R+PTBRK8ALX1eibRlchsjro0dNb
	 Pa4NbVTBsaxAcokiJJXaPwL0CCTAilb4d+b6KnPzMijHjEXBXs3sMl9oqHGqGhG1dfS/T
	 MHL3rDwMK2gw5aOyBYFnoOrJ0unB1Tbl/njOa4XoruhlC627kZ2XjzqqVLL+KSX/rkCIz
	 cCXz4p6YYN73EHNtYbm00jOKMwdKizBiVZ8EsMSMMEXer72G1QGB3uVm2ABHlzkfayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217668;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=d5UxhRENKrjN2WqdptUK5eL7RckbgwjJ8al7suyNLmw=;
	b=GnpTW0LIrRbo731Mt6+8VL/0tWyKdD4zB8bsznjfZsPk4lD4sKz1Aak9A4LZFsnotY9m
	 1YaUS9T3yW2/8+vOqkfQlYpsIzXWpibvPPbyZNnedDTM0Xs1jom8IrcNzvs7dijjplHrB
	 sj+S3orKhm/L85UWZPHEyh+NFb5oPwZ3cBGUkhze9XlDhNfd2YFT52aWKDyB4swBe5Xer
	 8XrhCKZ7LfHAfvoCfg+lmJULoIuso9075ieaghO/BOaW/efMTbB6Cq5ohPEL+XN6Vj4eO
	 Pan+OzSw9c20tQn0/r0zgvlnZjVhx22Dw+xy+KPHVNivpsOXYoEBKgPvfzk8LxKU9wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2PEt20h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE8606A338;
	Fri, 20 Nov 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2PEt20h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5987C1F000C4;
	Fri, 20 Nov 2026 23:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795217667;
	bh=d5UxhRENKrjN2WqdptUK5eL7RckbgwjJ8al7suyNLmw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Y2PEt20hYB0QZOMD0OeEAk5QiWb5GsEhbQISV/J8JRgTMESexeBZSyyBn/GJ7Dkts
	 BPSScWrUW4D1lPyP/Yl5Opvhc+rCtmL17H2wYb4MSvy3n/VQsb+il/Ypn53lFhXRrn
	 KDtZ1sUs+OLaBOmSxUq3gDsNkEkfQFsoAO5hWTJ2hDC9Nh5MHGLnR8BklKbwmJvStD
	 xiNhjBu6WXTQkoeY2Y8gUHJsskeLwfs+5J5BF1A1CYMGHGTRiJMleuVQqJkAaUv4fv
	 zpJ6OdWgJkcGGcWkt3vEJziGVWFSEv/ryhiZ2il04mqK2P13/HHJyGwI9ustKvp893
	 mSJXDE0GySgqg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 93458198003A;
	Fri, 20 Nov 2026 18:34:23 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 20 Nov 2026 18:34:23 -0500
X-ME-Sender: <xms:-tgAa40WMd_EPWFNg07JZwyPJcDR9Hl4neZG2sZ60S43JjZakvJQFw>
    <xme:-tgAa94btA2FcjGmKSDp7fs53-xd9zJUgeojcI1BpmZaQ8Kz0eLzPAdMkS9qQ_7FU
    OZr59jIhg8MHlYyQnwbZeEYlF7PpV4Vxlr8KoLe3U5t0r5NWyCYNKk>
X-ME-Proxy-Cause: dmFkZTFL9seTInIL2hUW1OvhO1WNW9/yDQMQ3sNpaBykWH23VqJykrvUISWN+rBSHQ+5bq
    /JQwHxFYPIkL2Xu86dfOWtqtRPVNB/qIKe2+3mjFHHflxOdiuobuj78Hw/FMM8RVcs5xMb
    dS/DET/rxsPx6SEKm1JZ2K/buPZvqwh9FNjgcHALkKy/XLVkevo5sDDIARq2Z//kZnp9CA
    rSEoHmeWmhoezQror9Ty81ka79pfF/gOgXmZ1GkKqAi2/yxezmh6ijdV1UEGYFqsznmeWL
    g6Y1Onmgdfw7a6cltPUu6V6KYEQymMJvNVprAPmF42FlCo/F4k4Y9IbQe/ue2Z+ZHcN6bR
    AVBfQNgkF9KQh6PxBWA+qfee9aUYQOqptwYa8VjqHfwnjVYok5TV5bLTBLvGn0rIl/+57i
    WO2CFNlMLurWUHycX9pn9FDh03suHQbu/a60gn8A1Unl1x/x+0E2LPeaCXK7ov30TPL9HY
    o2ezFIxHQHCXTJI7edwpEegWtCs0Eg73XGWZUHhg6NY3KaNTAF6vI4OBcklGStE1NtEpHe
    N3vHrVedPTfuvnZlHDtl4lFSJEfm8EUJI7Pvrs07l9xMCrxgGBfUi29jmIbjOM3Gg8ZgCg
    sI/r+DEJkCrbUJ/3Cs8u1BxQF8UUwcuBBDKvKM9/eCBqk19JS3CGIDZU1VMg
X-ME-Proxy: <xmx:_9gAa8qH40BxQBQvJaXjFARB-PhdRsMar2JTklrPA3z4SJQHVTmxBQ>
    <xmx:_9gAa3xjvPAkaVp2Sku5NRZNcCLQid1uQn0F3mHKuHRTI4Ze8YW5dw>
    <xmx:_9gAa4fNmE8P0lI-MJYK8bBx9g6OJsEHDExPpHD4o_STbil2bs93ag>
    <xmx:_9gAa7et2LQJdchwIic0GV_SClr-FVPrJ93hKkhrIDg8-j26-Wdt_A>
    <xmx:_9gAaya0K8B0H7iHsoh_BofrwBklH8I5ogjHkW64OyKf3gN1PHCDP1na>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CDCA4F80093; Fri, 20 Nov 2026 18:34:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 21 Nov 2026 00:33:58 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Justin Stitt" <justinstitt@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, "Mark Rutland" <mark.rutland@arm.com>,
 "Bill Wendling" <morbo@google.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Will Deacon" <will@kernel.org>
Cc: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>,
 linux-integrity@vger.kernel.org, patches@lists.linux.dev,
 =?UTF-8?Q?Piotr_Kr=C3=B3l?= <piotr.krol@3mdeb.com>,
 "Ross Philipson" <ross.philipson@gmail.com>
Message-Id: <243c6d70-7c81-4ad3-9a67-eb8cfbf454d9@app.fastmail.com>
In-Reply-To: <3-v3-22d1a1eb7d2e+17de-arm64_drtm_jgg@nvidia.com>
References: <3-v3-22d1a1eb7d2e+17de-arm64_drtm_jgg@nvidia.com>
Subject: Re: [PATCH v3 03/11] efi/libstub: Have efi_kaslr_relocate_kernel() handle
 extra_size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jason,

On Fri, 20 Nov 2026, at 18:51, Jason Gunthorpe wrote:
> extra_size is additional memory required that must be immediately after
> the image.
>

Given how extra BSS memory is essentially free at boot, is there no way
we can establish a worst case upper bound for this memory, and just add
it to the image unconditionally for DRTM capable kernels?
