Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102507;
	b=YpLgVjKccWCnA/pE7+jJ43Cqn11eJQlW7GX+eEzEAk9/zOulRIPrzVqsfgW0BluVaItG
	 MBp+7Xn1CzEBjuTL/v39ytt99FNO0hPVvGcMN+HNGJpSvUcpZwIsIrjOuW46kO96JVZ/F
	 Io0Ft2bE/8/fThsVrb1YXBg3yLbe9nYTIiYid6aDcQ/CzBD303EXhjoHVlYSZl3jA9nfT
	 6c6kb0N4nKYryw4CtFvhl+QKaMsyJ1kD1u1TcQJ4kLN80q6fT4gvb3+E2hSwe75JpE7ML
	 WwX9nIHtWc2nK9shzH7v96neW6R5oTEG89061vRUGu2TdwL0Y5T1S0g3ZNsIm78hsOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=l2fraaeZZuCrhIVUAx9Trfdkb2PBtBgevRLUOrK5tZ0=;
	b=ZjDuPoBGoASVVqyHrJmV7EnwdIRxkZAFacUP+7A1GtzRYTQmTjCfYI37vyFERf6x3Xu0
	 VjKNDVRBeWwOrkyeksWnCmYfkHAf1XZMWZlal6iGNuW5CHPzufL5zMsat1PXrq+X8nSJ3
	 7u4S80RQfmqoQyiLeowIw/P+lhRcnjG1k5eiQY4biLppmg7wXs38DaFfAIGh/AMQu3o5O
	 QA+KQhNVSsk/obWGXprDMIrD4qol0qxIPnJ4tlkq4BtLM9JTu5Kv9ivG4pTOcbL11lK7P
	 wCm5u6ock1Ew9at5izhtGrw3X9AG8HS7gpCN0dIc33UxuW2xFflz7lAHd6tjHGSZgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ASIUD6xm;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2B60A3802
	for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A2B60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ASIUD6xm
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c506a231b88so341927366b.3
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795102504; x=1795707304; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l2fraaeZZuCrhIVUAx9Trfdkb2PBtBgevRLUOrK5tZ0=;
        b=ASIUD6xmmQFWmsI0zmKaZjjq4Y5W0tEgzh17ilJSKi9RLW0hVlpx9tRi5GSTLMSe2D
         /pzA6NOfPT7vhR1115Rta9R3JIWYFPfgfXRHRBPk6IAWCMVUbcq2Ah0dOykl2+ztoZ+v
         sWCIaG/X4i14KdWV36IQoWSfB6AGI67TTAhQvHtPt0Wb43Ifk6I0/3d2AzLGEk+7vwIz
         7KZceMEnkyzEuMfOONvS9w0s4wYkDp9UnFJLj3LnRrpSBK5Wu9CHutn3s+2SG1h8Zpfc
         r5oaYLQUARTsyfZEdMo4SsWcQvXv8DMe7s86aywjgRyKpQvNoq9FuoqN0edGeelsD7sI
         ESUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102504; x=1795707304;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2fraaeZZuCrhIVUAx9Trfdkb2PBtBgevRLUOrK5tZ0=;
        b=QrZqTorIrTIic+XRASayNdkAg2WFQ1S3ufFWkHeCDoWNNLE9s9KS1SurqXBMHwd2P0
         FAbqq4EI+PR6tdNKy+61OX3QQtMBs//eVcyUWvEdV5BQXSkPKZT8ZHMUl7J0RKMqnMMw
         nJm765XvMBc3UMSrR6cJ4N0NVPM6Y1otLf+w87Ejz3FFfv38LVKArOIBOpZGYuSK6q7r
         e2gOVODtNxloxZNI0SV99nZ8nA0NoMfUCJFfY0AZEcUmrm2hJ1/XH6peun+yCDzG0l+F
         TErSgK56CHDvRQaBvtwS32s1XJUHRrw34EcxIQiKARX4QvRlb7dGg0e+DNVcP8mXLdPq
         JCxw==
X-Forwarded-Encrypted: i=1; AL+hErFKrGYd4d+HEDYIqV0VRbYW/naBFRrk+cvjpnqgP9JmFdP4muyA3egBpejkk64i6jLCJQvx+3nsYSsLrGfH/z4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u+DXLvRs/REnVSIyZYCX3J/RYIcVhsRdViXCZZ80fxB9hAcIw
	HVBEykbyjtJR+JcIm2ZSkdXdRV9M/73+bu/dZqt3w02st0wgLfR4U4RaKxDiQEKAN8k=
X-Gm-Gg: AYBFou1tuawA/IaL8jwLVRa+UICVwCMeHofc+1KQ6HTFXN9F69b7D3xmGhVC/TFgKM5
	hLJJwE5OhyfF0KY7jxZsMrlDD/ppOT/fDsvKMumC6uzDs8Mi/MYAOLI9exPJqr9L8gxc5C9qm+i
	1AwvFulekGSyz4o+MR0Qw+6YKBVQhAgO7/mbnQAYEmCaJLAZQY9RPECqcRPmNkkvklvA/YR9wlz
	Pd8GXK0Oe7ZzfkLAQx/jotVqK2WV0ZKqOQr2dozt0+RpYcSd+fawDQSprxQ0TwohHBXOmqFC4aG
	of3Xc+CLITiSDJm7HpmfBSlobA1TuD+DN0B9SesugQ4aj31PuBAxCpu8srg17LlEBE3RuWXqXzi
	ct8KuJ1VbBAmVW0XBalNodz+U2aguOrpt7pgg+zQt5NumfzOnkscjxpn7tqPypQdp97BmClrKmt
	yw4swSO/FtWssW5X8xgE36TQutgNlmGcxJe8JWkRgbS5Yl5hbmTqnJdYCw32kLstTI2/89gJZ0N
	wf0PKz/i9xw+V/G//bgHoddMtZr41H1zdRyCG1a36qUfD3IWKDxzrrmo7VXQINM9TOtcc0KTPxz
	pJ56Uh1KpNhbH6Vnpv3BPHyAG/b0EwI5cXeZTZsC0/3CvKkTjrDy1sS4CwJjALBuJTNiZeZm3no
	I++Mc8SYuzaPSAIpz2RLprucFU26zsCXJ9HaStV28rEGU1+Z/ZVc=
X-Received: by 2002:a17:907:fd15:b0:c40:9e84:942a with SMTP id a640c23a62f3a-c513aade153mr24375566b.48.1795102503812;
        Thu, 19 Nov 2026 07:35:03 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm5773366b.86.2026.11.19.07.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:35:03 -0800 (PST)
Message-ID: <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
Date: Thu, 19 Nov 2026 16:35:02 +0100
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
To: Jarkko Sakkinen <jarkko@kernel.org>, shyckless@gmail.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, sstabellini@kernel.org,
 linux-integrity@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <av8Tr2jTQaOBOEid@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fDlGYcNdJOxk4nbdRiWMkwtx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fDlGYcNdJOxk4nbdRiWMkwtx
Content-Type: multipart/mixed; boundary="------------YQWrW0Sgy6gdJch8qIvr0Lmp";
 protected-headers="v1"; hp="clear"
Message-ID: <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
Date: Thu, 19 Nov 2026 16:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
To: Jarkko Sakkinen <jarkko@kernel.org>, shyckless@gmail.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, sstabellini@kernel.org,
 linux-integrity@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <av8Tr2jTQaOBOEid@kernel.org>

--------------YQWrW0Sgy6gdJch8qIvr0Lmp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTEuMjYgMTY6MjAsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gT24gVGh1LCBO
b3YgMTksIDIwMjYgYXQgMTE6MjA6MzNBTSArMDAwMCwgU3V5dWFuIFdhbmcgdmlhIEI0IFJl
bGF5IHdyb3RlOg0KPj4gRnJvbTogU3V5dWFuIFdhbmcgPHN0ZXZld29uZ0BodXN0LmVkdS5j
bj4NCj4+DQo+PiBXaGVuIHRoZSBiYWNrZW5kIG1vdmVzIHRvIENsb3Npbmcgb3IgQ2xvc2Vk
LCBiYWNrZW5kX2NoYW5nZWQoKQ0KPj4gdW5yZWdpc3RlcnMgdGhlIGRldmljZSBhbmQgdGhl
biBrZWVwcyB1c2luZyBpdDoNCj4+DQo+PiAJZGV2aWNlX3VucmVnaXN0ZXIoJmRldi0+ZGV2
KTsNCj4+IAl4ZW5idXNfZnJvbnRlbmRfY2xvc2VkKGRldik7DQo+Pg0KPj4gVGhlIHhlbmJ1
cyB3YXRjaCBjYWxsYmFjayB0aGF0IGNhbGxzIGJhY2tlbmRfY2hhbmdlZCgpIGRvZXMgbm90
IGhvbGQgYQ0KPj4gcmVmZXJlbmNlIHRvIHRoZSBkZXZpY2UuIFRoZSB0cG1fY2hpcCByZWdp
c3RlcmVkIGJ5IHhlbi10cG1mcm9udCBoYXMgZGV2DQo+PiBhcyBpdHMgcGFyZW50IGFuZCBo
b2xkcyBhIHJlZmVyZW5jZSB0byBpdCwgYnV0IHRwbWZyb250X3JlbW92ZSgpIGRyb3BzDQo+
PiB0aGF0IHJlZmVyZW5jZSB3aGVuIGl0IHVucmVnaXN0ZXJzIHRoZSBjaGlwLiBTbyBkZXZp
Y2VfdW5yZWdpc3RlcigpIGNhbg0KPj4gcmVsZWFzZSB0aGUgbGFzdCByZWZlcmVuY2UgYW5k
IGZyZWUgdGhlIHhlbmJ1c19kZXZpY2UsIGFuZA0KPj4geGVuYnVzX2Zyb250ZW5kX2Nsb3Nl
ZChkZXYpIHRoZW4gYWNjZXNzZXMgZnJlZWQgbWVtb3J5Lg0KPj4NCj4+IFRha2UgYSB0ZW1w
b3JhcnkgcmVmZXJlbmNlIGJlZm9yZSB1bnJlZ2lzdGVyaW5nIGFuZCBkcm9wIGl0IGFmdGVy
DQo+PiB4ZW5idXNfZnJvbnRlbmRfY2xvc2VkKCkuIFRoaXMga2VlcHMgZGV2IGFsaXZlIGZv
ciB0aGUgbGFzdCBhY2Nlc3MgYW5kDQo+PiBrZWVwcyB0aGUgZXhpc3Rpbmcgb3JkZXIsIGlu
IHdoaWNoIFRQTSBvcGVyYXRpb25zIGFyZSBzdG9wcGVkIGJlZm9yZQ0KPj4gdGhlIGZyb250
ZW5kIGlzIG1hcmtlZCBDbG9zZWQuDQo+Pg0KPj4gRm91bmQgd2l0aCBhIHN0YXRpYyBhbmFs
eXNpcyB0b29sIGFuZCBjaGVja2VkIGJ5IGhhbmQuDQo+Pg0KPj4gRml4ZXM6IGUyNjgzOTU3
ZmIyNiAoImRyaXZlcnMvdHBtOiBhZGQgeGVuIHRwbWZyb250IGludGVyZmFjZSIpDQo+PiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBLYWl4dWFu
IExpIDxrYWl4dWFuLmxpQG50dS5lZHUuc2c+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLYWl4dWFu
IExpIDxrYWl4dWFuLmxpQG50dS5lZHUuc2c+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTdXl1YW4g
V2FuZyA8c3RldmV3b25nQGh1c3QuZWR1LmNuPg0KPj4gLS0tDQo+PiBDb21waWxlIHRlc3Rl
ZCBvbiB4ODZfNjQgKFc9MSwgbm8gbmV3IHdhcm5pbmdzKS4gTm90IHJ1biB3aXRoIGEgWGVu
IHZUUE0NCj4+IGJhY2tlbmQuDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9jaGFyL3RwbS94ZW4t
dHBtZnJvbnQuYyB8IDMgKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS94ZW4tdHBtZnJvbnQu
YyBiL2RyaXZlcnMvY2hhci90cG0veGVuLXRwbWZyb250LmMNCj4+IGluZGV4IDNjMGNjZTU3
YzRhZS4uMWJlOTI1Y2NhNTM1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS94
ZW4tdHBtZnJvbnQuYw0KPj4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS94ZW4tdHBtZnJvbnQu
Yw0KPj4gQEAgLTM5Nyw4ICszOTcsMTEgQEAgc3RhdGljIHZvaWQgYmFja2VuZF9jaGFuZ2Vk
KHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsDQo+PiAgIA0KPj4gICAJY2FzZSBYZW5idXNT
dGF0ZUNsb3Npbmc6DQo+PiAgIAljYXNlIFhlbmJ1c1N0YXRlQ2xvc2VkOg0KPj4gKwkJLyog
ZGV2aWNlX3VucmVnaXN0ZXIoKSBjYW4gZHJvcCB0aGUgbGFzdCByZWZlcmVuY2UgdG8gZGV2
ICovDQo+PiArCQlnZXRfZGV2aWNlKCZkZXYtPmRldik7DQo+PiAgIAkJZGV2aWNlX3VucmVn
aXN0ZXIoJmRldi0+ZGV2KTsNCj4+ICAgCQl4ZW5idXNfZnJvbnRlbmRfY2xvc2VkKGRldik7
DQo+PiArCQlwdXRfZGV2aWNlKCZkZXYtPmRldik7DQo+IA0KPiBOb3QgYSBOQUsgYnV0IG1h
a2VzIG1lIHdvbmRlciB3aHkgdGhpcyBoYXMgbm90IGhpdCB0aGUgd2FsbCBldmVyLg0KPiAN
Cj4gSS5lLiAiZmVlbGluZyBjb25mdXNlZCIuDQpJcyB0aGVyZSBhbnkgdnRwbSBiYWNrZW5k
IG90aGVyIHRoYW4gdGhlIHN0dWJkb20gYmFzZWQgb25lPw0KDQpJZiBub3QsIHRoZW4gaXQg
aXMgcXVpdGUgZWFzeTogdGhpcyBiYWNrZW5kIG5ldmVyIHN3aXRjaGVzIHN0YXRlIHRvDQpY
ZW5idXNTdGF0ZUNsb3Npbmcgb3IgWGVuYnVzU3RhdGVDbG9zZWQuDQoNCg0KSnVlcmdlbg0K


--------------YQWrW0Sgy6gdJch8qIvr0Lmp--

--------------fDlGYcNdJOxk4nbdRiWMkwtx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr/FycFAwAAAAAACgkQsN6d1ii/Ey/f
6Af8D5ebzAoKT35KSzzN9fh+es2a/JQVWzRMxAM84ddWsaVaaOYBGuwvsVVxfs+tjms1UCytkb+m
3OHzZdciL0IajYaeJ7rpL79lVfAaSEKDGi6xveXXUIyPVugvtr81hF/h/Jp1ty8mqojq/pcQJTft
SJPY0H6q0m6fLyy0A+Z/BSj9BYCdNUq9xWOhzXt02SiNenmAcJh4mS7Oh7yoJnYM1pbA81G6IIGD
y7QmeVQWLPcKDvjPxzlvIxoijSdJsw5dBpqqdeIQ0tFowX4RIZnsErTB+iYlTHN7Q64UYhJccu4/
VfK1PDebVkqqzkZNLHGe1OH4X6iRFPREz1+0qO3vOA==
=j5Ao
-----END PGP SIGNATURE-----

--------------fDlGYcNdJOxk4nbdRiWMkwtx--
