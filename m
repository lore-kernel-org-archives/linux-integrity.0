Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105927;
	b=Db6H0AUw8hMdCULFahmAlRffD+DzFzL0M1at1isyJUh2sePdKHNq6ZGuQUWVpNfCUWMc
	 qDzLW6HGiG/Bbw0begpwqCg/xblv9n2eWHak0YlApJRpwPc7m29sNIFG0A8zsTsD7U/CY
	 yMSJD7m10JbAL2FJI4a3ZVI+FxKYWVZmOJwB29RS+KYVzDuoTHDhi6iPGwqfbxYRuA5Aa
	 B19BlUJlddJ50ukBJQco+lg7bUDisK5jlnh8qEj0fElaKmtlOqGmDb1EEcpJWtzdS/ZUm
	 XO07S2cRPMqFTxkRQS5OV8QziGzMAhnA/xTcG7La5NAK/s/4iFJhPQUgJ76q1Sm4g0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=sPfYIUokIobAVOy+Kt3MNId0nKysTKl6bqq2JLMUxOQ=;
	b=QWFfEvBiesscSLnRpEIHEp9iVDG3GrxhIIR69VkUO2a49v3m/H8xcNPEvyei9JwBefX4
	 r8KFNFwa5YNZQy6PEM4WoqQu8x4SlDvPNgjplLBB8zlKqjXszj5Cwj1ny0A5Noog9Hu4t
	 C0ocavJyfHpbKaPqq38Ua31myEQ6LCt2bM8iIgKdS2mIqNNn8es/fqtYqOsNklWgnggvO
	 NMWWJibawwnGyVuz/EAw43gcqPsIm53P/z2oHHPsywFDjlSpW0LFBvkz9VwM/Vk8K8N88
	 wIYDDNP8UIROrPyJAspjBAINEdhIu0D0O2pWyRMMoRliZimmnXYDLhUwiUIYIIsAl7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="So8z+vM/";
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC4606A32A
	for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 16:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BEC4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=So8z+vM/
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c506a231b88so356147466b.3
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795105925; x=1795710725; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sPfYIUokIobAVOy+Kt3MNId0nKysTKl6bqq2JLMUxOQ=;
        b=So8z+vM/8W1etK2lXhPLs68JSCWaVLPdSv50z1uEQnrt520rYGfTckmRLUQEJRABYs
         l60Q515EiyTXENaXCX/A8Q0B3ZCn1Ya6B4v/SGEdYmjEMdO8TJQqX31kPi7PfntHHGkq
         cw6ECr2Y8PYSNFqdXs4E4nkfvdSeVPKHoDiU1c2BTfw5bApc6BY8z2fEvldnKBFHRbNd
         JqcjIIPu6JHjutqlsxo5w0TE1traCJiet2ulVvpzHkK83kIk66S/WnBqFK+/PY8KIglL
         jgWmrgUDIV/j+jX3jEa/A6HxuHqtR0E6lvbg/uJ7Ur04QjNXyc7owkIz864Thfns+1Cg
         T3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105925; x=1795710725;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPfYIUokIobAVOy+Kt3MNId0nKysTKl6bqq2JLMUxOQ=;
        b=UVQZ6MFYHs9A25dQ++pFhdwhDu+Ux5tHBzi5xin1q7lbfwgQWZnpSn+DZ5qnZVusyQ
         OZVrxDGV2J+tcLwtlJf85roPfjqxmJjHHZEb42Y+QWte0uF/cbpjtXHdgD3jBVR+tRi8
         2DlMukIEpkBE15Y7pLYhFbEENgBnxyD5CNekCyGavFVVZJZh3SotuECzKLg4jHhgnLRQ
         XH4EmZw0IARfwMhs3LUmyZu2TJe7//k8GBthrjSxhb0dGpgoQW1jfeHiRLwFLO95UrjU
         fingb6Wxejec4xUAgMDjm61k5U8IHQ4vuXZv54+7iJRUylGh3aLa6t0qAIfkZqxUgc/y
         4KeQ==
X-Forwarded-Encrypted: i=1; AL+hErEFtvWF/HCu/ERsWWrsBrjsqTdF1DJPqJogNSHwsUKY2dXAI2iG1yrRYfka3sgOiI8uuBcX5ZGQh328C5cS66I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kHCv6WDLt2RI1I7fj30Z+5eNzITRkbIFBHEil8VVUQ/5uVYuy
	TF4ZmBH7tV4W+522OET2gYlTCy0E41norhmZpncHpsNnfHIxte6VE5sCkgKMJKa1K5s=
X-Gm-Gg: AYBFou2HD9NthzHTyjWqzWDxjDy7TqiBlxQCTCuBIskh7/AblHaYH6qBSBd9tUB8YKK
	6ygk2B/ns0+opal4a/lTCCzh+Iihs9evKfs6YcZtfyyerHLJW/jJwtt1JsSu/srtqu7DbjH1F/y
	muW1kMI9Zlk3zEdti2vfLZOcIRwem/q2JFy3ln2il2ju+wOQvINcipA/GsKbZje+VYF48/HQlty
	LVjAVaOeK8mjsZ1ey+YF1b1WoqnJq/zWLG3i4cOPqHFQ7sXy4J2lO/6d0JDHRUpQ3IOklSfGX7y
	E77yg59LxjViCKw0iAaBtWdA8i15hfYSmJ/N1fOgI5dxaY1IK9If/UXLTwuaV1Qnn2O2HE+t9wS
	zfXF7KZXdL3gwpaIs5s/TMQH7y/p6e2xEsO9K3PIDfsdYZREhWJZQsZC08aJE6diyUrH1a9yl8x
	Cdx47wzEX3UnRxnUpoewBHjjZGk98oDOSVtb2MsazcxmFERqWdV4cZTBFQsTv09i1qr22nikkOh
	RCIdUW7UGOsPBwfWeV4oZOVk18YewiQLPDlL83deksCugEk1TqexzuP+Lv8WeCK6ZvlchlhywRx
	oL4qI4WbXsOyQjYSkE3z0KosrezTia2/7Ze4lq6e4ZWoztz4ZRQD6zbRY55aDWjDrXbMxq3zICG
	3/miQB1Hkda1sTV9csIgCZG8wc2Hfw5O/Ub4Hl2kNn0/zX17EqqE=
X-Received: by 2002:a17:907:da02:b0:c2d:c247:5400 with SMTP id a640c23a62f3a-c513a8493eemr50358366b.27.1795105924717;
        Thu, 19 Nov 2026 08:32:04 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42easm14164466b.60.2026.11.19.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 08:32:04 -0800 (PST)
Message-ID: <3b37565a-4dd7-454d-99b7-108b8e4e7133@suse.com>
Date: Thu, 19 Nov 2026 17:32:03 +0100
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
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: shyckless@gmail.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 sstabellini@kernel.org, linux-integrity@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org> <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
 <av8kIqYC04D5QdXf@kernel.org>
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
In-Reply-To: <av8kIqYC04D5QdXf@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rS9qJzvGq5TEYjY8RSxuDc5I"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rS9qJzvGq5TEYjY8RSxuDc5I
Content-Type: multipart/mixed; boundary="------------9iDCYuhIjWzTJQZqas7jrhKH";
 protected-headers="v1"; hp="clear"
Message-ID: <3b37565a-4dd7-454d-99b7-108b8e4e7133@suse.com>
Date: Thu, 19 Nov 2026 17:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: shyckless@gmail.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 sstabellini@kernel.org, linux-integrity@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
 <av8Tr2jTQaOBOEid@kernel.org> <8c988944-34e3-4fc9-a323-daca101c1bab@suse.com>
 <av8kIqYC04D5QdXf@kernel.org>
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
In-Reply-To: <av8kIqYC04D5QdXf@kernel.org>

--------------9iDCYuhIjWzTJQZqas7jrhKH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTEuMjYgMTc6MzAsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gT24gVGh1LCBO
b3YgMTksIDIwMjYgYXQgMDQ6MzU6MDJQTSArMDEwMCwgSsO8cmdlbiBHcm/DnyB3cm90ZToN
Cj4+IE9uIDE5LjExLjI2IDE2OjIwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+Pj4gT24g
VGh1LCBOb3YgMTksIDIwMjYgYXQgMTE6MjA6MzNBTSArMDAwMCwgU3V5dWFuIFdhbmcgdmlh
IEI0IFJlbGF5IHdyb3RlOg0KPj4+PiBGcm9tOiBTdXl1YW4gV2FuZyA8c3RldmV3b25nQGh1
c3QuZWR1LmNuPg0KPj4+Pg0KPj4+PiBXaGVuIHRoZSBiYWNrZW5kIG1vdmVzIHRvIENsb3Np
bmcgb3IgQ2xvc2VkLCBiYWNrZW5kX2NoYW5nZWQoKQ0KPj4+PiB1bnJlZ2lzdGVycyB0aGUg
ZGV2aWNlIGFuZCB0aGVuIGtlZXBzIHVzaW5nIGl0Og0KPj4+Pg0KPj4+PiAJZGV2aWNlX3Vu
cmVnaXN0ZXIoJmRldi0+ZGV2KTsNCj4+Pj4gCXhlbmJ1c19mcm9udGVuZF9jbG9zZWQoZGV2
KTsNCj4+Pj4NCj4+Pj4gVGhlIHhlbmJ1cyB3YXRjaCBjYWxsYmFjayB0aGF0IGNhbGxzIGJh
Y2tlbmRfY2hhbmdlZCgpIGRvZXMgbm90IGhvbGQgYQ0KPj4+PiByZWZlcmVuY2UgdG8gdGhl
IGRldmljZS4gVGhlIHRwbV9jaGlwIHJlZ2lzdGVyZWQgYnkgeGVuLXRwbWZyb250IGhhcyBk
ZXYNCj4+Pj4gYXMgaXRzIHBhcmVudCBhbmQgaG9sZHMgYSByZWZlcmVuY2UgdG8gaXQsIGJ1
dCB0cG1mcm9udF9yZW1vdmUoKSBkcm9wcw0KPj4+PiB0aGF0IHJlZmVyZW5jZSB3aGVuIGl0
IHVucmVnaXN0ZXJzIHRoZSBjaGlwLiBTbyBkZXZpY2VfdW5yZWdpc3RlcigpIGNhbg0KPj4+
PiByZWxlYXNlIHRoZSBsYXN0IHJlZmVyZW5jZSBhbmQgZnJlZSB0aGUgeGVuYnVzX2Rldmlj
ZSwgYW5kDQo+Pj4+IHhlbmJ1c19mcm9udGVuZF9jbG9zZWQoZGV2KSB0aGVuIGFjY2Vzc2Vz
IGZyZWVkIG1lbW9yeS4NCj4+Pj4NCj4+Pj4gVGFrZSBhIHRlbXBvcmFyeSByZWZlcmVuY2Ug
YmVmb3JlIHVucmVnaXN0ZXJpbmcgYW5kIGRyb3AgaXQgYWZ0ZXINCj4+Pj4geGVuYnVzX2Zy
b250ZW5kX2Nsb3NlZCgpLiBUaGlzIGtlZXBzIGRldiBhbGl2ZSBmb3IgdGhlIGxhc3QgYWNj
ZXNzIGFuZA0KPj4+PiBrZWVwcyB0aGUgZXhpc3Rpbmcgb3JkZXIsIGluIHdoaWNoIFRQTSBv
cGVyYXRpb25zIGFyZSBzdG9wcGVkIGJlZm9yZQ0KPj4+PiB0aGUgZnJvbnRlbmQgaXMgbWFy
a2VkIENsb3NlZC4NCj4+Pj4NCj4+Pj4gRm91bmQgd2l0aCBhIHN0YXRpYyBhbmFseXNpcyB0
b29sIGFuZCBjaGVja2VkIGJ5IGhhbmQuDQo+Pj4+DQo+Pj4+IEZpeGVzOiBlMjY4Mzk1N2Zi
MjYgKCJkcml2ZXJzL3RwbTogYWRkIHhlbiB0cG1mcm9udCBpbnRlcmZhY2UiKQ0KPj4+PiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4+PiBDby1kZXZlbG9wZWQtYnk6IEthaXh1
YW4gTGkgPGthaXh1YW4ubGlAbnR1LmVkdS5zZz4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogS2Fp
eHVhbiBMaSA8a2FpeHVhbi5saUBudHUuZWR1LnNnPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBT
dXl1YW4gV2FuZyA8c3RldmV3b25nQGh1c3QuZWR1LmNuPg0KPj4+PiAtLS0NCj4+Pj4gQ29t
cGlsZSB0ZXN0ZWQgb24geDg2XzY0IChXPTEsIG5vIG5ldyB3YXJuaW5ncykuIE5vdCBydW4g
d2l0aCBhIFhlbiB2VFBNDQo+Pj4+IGJhY2tlbmQuDQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2
ZXJzL2NoYXIvdHBtL3hlbi10cG1mcm9udC5jIHwgMyArKysNCj4+Pj4gICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3RwbS94ZW4tdHBtZnJvbnQuYyBiL2RyaXZlcnMvY2hhci90cG0veGVuLXRwbWZy
b250LmMNCj4+Pj4gaW5kZXggM2MwY2NlNTdjNGFlLi4xYmU5MjVjY2E1MzUgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvY2hhci90cG0veGVuLXRwbWZyb250LmMNCj4+Pj4gKysrIGIv
ZHJpdmVycy9jaGFyL3RwbS94ZW4tdHBtZnJvbnQuYw0KPj4+PiBAQCAtMzk3LDggKzM5Nywx
MSBAQCBzdGF0aWMgdm9pZCBiYWNrZW5kX2NoYW5nZWQoc3RydWN0IHhlbmJ1c19kZXZpY2Ug
KmRldiwNCj4+Pj4gICAgCWNhc2UgWGVuYnVzU3RhdGVDbG9zaW5nOg0KPj4+PiAgICAJY2Fz
ZSBYZW5idXNTdGF0ZUNsb3NlZDoNCj4+Pj4gKwkJLyogZGV2aWNlX3VucmVnaXN0ZXIoKSBj
YW4gZHJvcCB0aGUgbGFzdCByZWZlcmVuY2UgdG8gZGV2ICovDQo+Pj4+ICsJCWdldF9kZXZp
Y2UoJmRldi0+ZGV2KTsNCj4+Pj4gICAgCQlkZXZpY2VfdW5yZWdpc3RlcigmZGV2LT5kZXYp
Ow0KPj4+PiAgICAJCXhlbmJ1c19mcm9udGVuZF9jbG9zZWQoZGV2KTsNCj4+Pj4gKwkJcHV0
X2RldmljZSgmZGV2LT5kZXYpOw0KPj4+DQo+Pj4gTm90IGEgTkFLIGJ1dCBtYWtlcyBtZSB3
b25kZXIgd2h5IHRoaXMgaGFzIG5vdCBoaXQgdGhlIHdhbGwgZXZlci4NCj4+Pg0KPj4+IEku
ZS4gImZlZWxpbmcgY29uZnVzZWQiLg0KPj4gSXMgdGhlcmUgYW55IHZ0cG0gYmFja2VuZCBv
dGhlciB0aGFuIHRoZSBzdHViZG9tIGJhc2VkIG9uZT8NCj4+DQo+PiBJZiBub3QsIHRoZW4g
aXQgaXMgcXVpdGUgZWFzeTogdGhpcyBiYWNrZW5kIG5ldmVyIHN3aXRjaGVzIHN0YXRlIHRv
DQo+PiBYZW5idXNTdGF0ZUNsb3Npbmcgb3IgWGVuYnVzU3RhdGVDbG9zZWQuDQo+Pg0KPj4N
Cj4+IEp1ZXJnZW4NCj4gDQo+IFNob3VsZCBpdCBiZSByZW1vdmVkIHVzZSB0aGUgZGVmYXVs
dC1mYWxsYmFjaz8NCkkgZG9uJ3QgdGhpbmsgc28uDQoNClRoZXJlIG1pZ2h0IGJlIG90aGVy
IGJhY2tlbmRzIGluIGZ1dHVyZSwgc28gZm9sbG93aW5nIHRoZSBub3JtYWwgWGVuIFBWLWRl
dmljZQ0Kc3RhdGUgbWFjaGluZSBzaG91bGQgYmUga2VwdC4NCg0KDQpKdWVyZ2VuDQo=

--------------9iDCYuhIjWzTJQZqas7jrhKH--

--------------rS9qJzvGq5TEYjY8RSxuDc5I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr/JIMFAwAAAAAACgkQsN6d1ii/Ey9N
2gf+Pao/6gxwMq53WtLQZGg0rt7LxQlMzgUrZUfCvGwBnRWijzoAdOuCktBwjdhIa/kDFtI+0UD1
zJC4DVDWOGZJ34dbA4adOwTpBx1BagvWrbZpOtxjJMAGug1OF+Bl5CtpD278hS4Da9vkVjvUTo+D
xdfJydn03dgIJqA8C5jERa0WvRfhFqeQi6fgXWWcV80qGa/fY8De0A+2eUEVly/S++3gtYbJ0vFk
DCUis3njGMqm2Ls7y2Xi9wm7As7lA2FCDvzK+G7xNgew1gYqL+R1g+Zp19YckJyAo5WNTOGE3LMg
C6iyQ06fJF71R/Afgc1XzaLmlZrOBWyv3i1NNAzKLw==
=97I1
-----END PGP SIGNATURE-----

--------------rS9qJzvGq5TEYjY8RSxuDc5I--
