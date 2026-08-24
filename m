Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243344C645
	for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586882; cv=none; b=WT1BLHJd9s7prnpaB3+IAD0Il3qA5ieJ6Vh0WBmWwuHEaBgZlq0wRrDoyoVilgQe30O+WjH1iEYtMbt2OuxNAcOazKcsG9w/geC2E4LdUvd8d9phlkFh1hMyTAI3MTQr9swNBSJiihJ92JsdOsUi572u2ZReKaHuU6k1EtgCbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586882; c=relaxed/simple;
	bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0YUUb9GRw5DvtNO3BTpD5ZbXwnQ1cXmZBGzmEyNMDpdQ7m+GLccippZPZj/rkJdgKli1UuTZUcek4LxvXx6eRxfS+vsnCPyGqvtEcZHWJ0KRK4XRdXTcjiSxHzee7vQeeBjYypKz4N1H8WTFSJuhgbjcAau8/MtCgMmu6wAPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khra5moO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khra5moO"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe377a217so1726675f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2026 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586879; x=1788191679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
        b=khra5moODuVomcOdNRNLMnfnBGS90sj6dadY71wnfxqBH1rOR/zIQXUjWTFoPUphPu
         30+n8ilIpIIj1/SYvLPP/822W+X8fHmBvLsgtb6HM4tnluHwhyQ63yDw/Fj0ewBKnXla
         zOqgXR1BENOy6GlY+sqomVCxbBqs/HZVTWz5nwJgDqr3ICxgkLOQYcRTeAfsN0cz8SlG
         hDziQ1Y3A/Fq0Xydib//uO7t1UYouDNWVcEgcPfBKEEr8jxfIj9k9+5wR0vx57AkVxkD
         Dbie2V/nxCvjtFtWMzmsFZk1nVSr0N7zOg9fhFoVdLU+0KRINLa0Ilsu5OzR2+C1CDuq
         te4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586879; x=1788191679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=USKnBafwqRFKdKWqRWkjXfXuzVpNsWO7NRgRGSeCXa4=;
        b=T4k8iLE18eIJqAdZmmyToBEAi4AQAsrxiIncf+O79rQmBJ2BBLzK69UpSN12Jjy/zX
         LUbSbhZGRHwlamg1SepqoNw7hcwPf33S53XYTEntxlx/GgBGr2+i2yqWtOdrn1ZXzEXp
         RkOBdBzVoOMC5g00BG6Moc3sH2IzNgKrrTDmEX/rxNtLB0Sb4wXunAIFZg0/t2cH4LyE
         hlbXk7kAZ/OVJmzBQb7tMN7PTlUUsExxrlKHaGyFgpT68zdwHXD4buGhSBo0EBAVc+X4
         oFnq2fnLBmGEzcBs7eLAQcOgQ7g+LW/Qbj3zD0CdkpF7KoVriVx2jwqotT9i4mZp+ZYO
         z3Bw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkme7Hnjw6zWPZ+bIlO2Mo+TYGgMBGhwtARUJjGEZJqPCjK9beS7i8xTLVExW7mvscqAnHVEaXOBpLsuDQqsM=@vger.kernel.org
X-Gm-Message-State: AFuF++l3XeUG17v9xf9qugB0OKTseFvPkVGmFnus0h8eLScqkxEY4Z5X
	sRqtORz6iHL7j7Z1LzYY8iQuaR4//NvDsi9t4eu3i7jHbaICcoCxy+vv
X-Gm-Gg: AR+sD11vG6D6T3GNqvbYzq8BTqr8nMorX5G73fkMdxavkWQNhuyXejOA2gPOBCSUUoJ
	ZmkbU98My/TrbvlsyUcqTSWsxMyKXnmP4rZVwH+EYaOcVMABbRNc2g5E7BfytzQNBRjyzHR+sW5
	rwUtW1SdswLwstWfZiy5RrXhfqb008HXJrzFNQcK0t5bkF6rRLil0HdJPUpMq0e0RWK4ffAsKoy
	QHvr654WrFUwUJsrPZ1wqbLbTfVanvwUnrbNAlGp5y4yogHq4t7lUkMruieKrQMZTeRny/33Izm
	e37GDm3CPmmglaqqVAYLeajJevYpI6eVeGjYzm4Ks4SKZnJ2nkTpCip0Z6SqhBtufFEcNlOXaS4
	Qo/sH2LCEb6NfW0iq/axV2k622+kp4vFYQf0bz7HrYWVct6X+ALthIqZ+/krlP0GOCL3q+egK3+
	YvJSSq3HB+ZEby4G8W5hNHfIcV9AnNTgUPurJ03XD9mBOAPk44ZDUvF/hOmhoF74b7FJn2y8GIG
	iuL+Revv40neJtvsXX0maoXRamaNOIGUXxhq9V69hBAuqEEF760mOPHrAdI1HMW0aQ=
X-Received: by 2002:adf:e193:0:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482c0ba3a3amr38819620f8f.18.1787586879357;
        Mon, 24 Aug 2026 08:54:39 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c14dadsm8734743f8f.37.2026.08.24.08.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:54:38 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com>
Date: Mon, 24 Aug 2026 16:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: clean up IMA_MEASURE_PCR_IDX in Kconfig
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822001545.354195-1-julianbraha@gmail.com>
 <ca87a913bece92019d04ffb2f795f8365fde4a87.camel@linux.ibm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <ca87a913bece92019d04ffb2f795f8365fde4a87.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mimi,

On 8/24/26 16:00, Mimi Zohar wrote:

> The PCR index can be specified as a Kconfig IMA_MEASURE_PCR_IDX
Thanks for the info, this means that there's a bug in the kconfig,
rather than the range just being dead.

I'll send a different patch to add a prompt to this IMA_MEASURE_PCR_IDX
option.

- Julian
