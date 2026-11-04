Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=He1wUe15fl4d/6kXxE453K4y3vDpCr3h4ZQBOQ7LB/HCMzfeF8Ok//gpjZxsecZd55sC
	 b4Uhjb2AxNVn0Vewcro2NkwD/aoLXADVwroQ2yyWmSbobGzm7cc0uTzzIZ6dz/FtxxL8f
	 fJuKZQZ1jHh8THp44ByXxLGwPIRW50rW8O9xr+JTBbyFxclMCt4GdS72KUSPHTQh8qg1Q
	 OJwbzPOuxjE5TSHU/ybQHjOQH0oaiB5DWDn8T5TgzW6e2jv9gyF6XzDG/TBNx4Xk0SSKV
	 d8EZOp32BWYtDTJ/PV27rVYrOgtUrDkWaEIrFH5LY2KIAPWaoLPRjOC4O17E3X7eFCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=wkYSi5xbRkh9nbgJpmqxUeRDhi977LoIojSnwZ/zGObMsH2G3n/rZCTB54apO7+OEOlG
	 M4b8RKaUjWlPel01ltYOHk8FZlUgkGK4PSOreKz9kuQvUT0i1h0CKQ8CYmukCUhP0jJ/l
	 9h4K3RwTX8ctZ9wDYRQCQsnyly8AJu866+g2J4Zg4mutJxldsyX35ezhPOYg1/ZdzubZZ
	 N5BIrrfU5uPDK4MEWDZpzg+/p6817KUMqh5Ns9JHlgK0CIF565v7Hc2NNC1iNoaVHR0qH
	 1Pj9X/f0H5Z6Can48X3/R4tyBoVFjrP+1csKJ/kWFbgBmruRmn+zvlHoaFnZOyMBh8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147B6082BF3
	for <linux-integrity@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1147B6082BF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1adbf62dd31so1554474c88.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=V8B9eCqN5PmD4vMLEWC7O4hyuBdLnprctbtYEEb7cNgzt62tUSsar85BioP6jXTZnd
         XHR56Dg3uPkXxsM9VTgDcvBWWiGtL10Gh02tUZiRjD7c37GoS/nzlKDvA8BBlT8cs5NB
         hyZ9M2J239ro6hNzhjrZmwzFdt9u7XP3hU8zN6BPlzr0uHrmo9PlesgKBQJ0UIIM0qEw
         SC5Z2isZoXEH6a6QIcH8cy6j3IQCgO7OD6GuO42+wqt/dbT5Q7UH246y3vEqnRsL5jQ7
         N1m9Qbte+QKdYWKN2DxNh2VDqWd/elOAyBP88NErnaHjIbUbu4iamF5MMScaxff4Pl7X
         S+tA==
X-Forwarded-Encrypted: i=1; AKwUvByAlJRoKS/CiOadlQOGWUFgIxQomG6nYY+IOJSAv5oHC/GuEOQVCoJxTeCMLzNlz8eQ/ebYG6hkuOyrbwsC2hs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m0cb0T4l3YJsKEzIo0VVb+txQ0rUBKgbKIaDXirNQQ4i5Ck2r
	MG3oYYfPl7RjRLxjW2ePGlqw+MbFCLZMogcI6ohrk5GToyAzvL/Zmtk=
X-Gm-Gg: AYBFou11owobqE0kp4LwIhr+spNeBGNJNiFMuNcmnLaiyKJyPTDfYYbzDCW5VZmgOZb
	nrw1OYknmc6ULOX0UKPFoczt548njxau0C+OkVuIi8qiCLqlqdFgs4mwFNQAGoqX/6Ay4O156Yq
	w1Pp87DMbKIVnASmcs45Mtawcn/Fiqo3Q8AMICC2pWwiL2eTxy2B7SugoMeQMatwLkv/C9lJ4/7
	TNZwXNeYGXo1OxO47o2PaS3UlTHzYIh3Za4m/QEYmpy16z8nfOkalRhMyWh8h2NTUE8WefRqCFG
	2UKQmyJ1ki9zCRN/cy2KsFUF3YGpfaowgM/PbaDYxb2zbqzd4twHQj0kBN6WYUwP5NJAptfNkK9
	DvaFWO2plHnOEQ1pj4gYqwQuUp6GWp53YBUx9uNY+uZWgmoM5Al44WCzYQaURt6nMRWdDmQnct/
	GRhv3jg6ZS1+1vvF5kvNx+Cnljl0wZQrjjJxvZQZB0aeVCQ3vx6in2JXMVS+MgcjVo3rFTlpAhO
	mvYbXvBJWD1TJOL9LbkCQ+EQkLCAhQzwtHr3j58CfrvUFjsbfC44FMT8om3U+ogDi+eHc4j0vt5
	3yIrohP1vagd+huTVRJmdnMQK6/HMh6bdFQlBasXL+63Swjly/Rxki7dZsIjAUVEKg==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
