Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F36431E71;
	Wed,  7 Oct 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380454; cv=none; b=XMqeVLDasVhwgFjvvOHM9rIFh/xa4fBeB5id4hHkKovvrbE08XJc44v4xgmGN4UiW/L7qZnO/8ziGVJHfiAjcxK3zg9Tr8ItWn+f9mr2ByjPPHCR/QCeIvmYTl/Zpb/MuhDm72HWYfpl2NgtvKoPXDHfoMe72K71IhTzQo0YXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380454; c=relaxed/simple;
	bh=gsRxFqm+EzbIUJOT1wgGnw7SvjE6GxUMt3WSHeGGv2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEa4z+NJgLUnP1a20up1KempYf0etM/TOmIxkuAEt/N0rdy91WFzQknWmVwXvTJ0vpBaGXHu0C/jhE2U1SJ9x5zTYPdvGlTVDAwlZpUEOdcBgtL14AcjU07ld8btM7A6rNK9qHK7ndegwnsGy5v0jjWjAwM+DXJYcemjAqBNu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz4t1791380416t8179b403
X-QQ-Originating-IP: PWpttXQ3DOBp5n0jZQWtZkD4nf5QeEN4Sg0ISfK7Tas=
Received: from [127.0.0.1] ( [180.159.160.209])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 Oct 2026 21:40:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9570977485540682427
Message-ID: <401F87C23DE9A910+997f9376-6810-4066-ae0a-686af834c0bd@radxa.com>
Date: Wed, 7 Oct 2026 21:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sophon@radxa.com
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: zeroknots <zeroknots@protonmail.com>, amirreza.zarrabi@oss.qualcomm.com,
 jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca,
 linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 peterhuewe@gmx.de, sumit.garg@kernel.org
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
 <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
 <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nwz8Cs33/LprCyUngGnDPDz76MMJbtGvdpcrxzzbKaz9OhNrmyhZ3qwz
	ogA8HofiDNDceuivQk2ZWfi12W5687ljXZNpP43pRu/GKC4c6ZP+xnDmKWSo8b662K73JWf
	vnq3OFVoIaV0WmDifuZzvHG1PgCWUMBVe4WEZPw7W1RKzl7qDwNVxIE+b9jhQLKV1GJ75HN
	OrC0cObdc8pynhZW3Rq0/XzPGa1jlc4Zk3zGfB9Hf7NnhiaWMG76JHon30YkXVAemN0tXM9
	4vBunyfLCtqgeU8oGmTCqOhGFuXDUzIKUng/u9Yz93OWPF1f556Sm+mADEg779eUUl5jPLH
	BYPIKfBA125qvqSG6pVcKURQDS2RKpEj3ZpVzPZ78k/EE8IXgFOr9FnopJTLsZIJPT/du9b
	6hXtbTBJAZ89SBVjVwUMoImOMNfucYauKbeflfOm0DIIv+F2/FCrfJpjAvqsFOcUiP/Li7B
	UX4a/EjazGD1rIB+V6IGRgW6aVNmmVWk7Ax3etsQpBswPACc1EEYHG1KBtXVCxyF9yvMrcr
	BQGMejx00MCCAgaxwXqMaTL8kujUbpxHiUClzWE5j2NQc7A9c7OwrH1lPFyVxvV8P6RRwxR
	CaaHF92L9yu7xxzPySpg2a9gYnLXw0jDpuNGf1gKZVv5x0o/vgy8/PYY4ndYdP3koXaA5mz
	+T0beuwOtlAfhqUrUxQzi/26x+ni1/yTKDQ31BOzBAbIWii30g1Tpk3vCetKAbSBlsrBT5d
	JpUEtSfFTE9jtnquZfGztxWifxrXdrUPtGbiMDtC3JQyBch5VMsulgnOvmyKyo/H1khzgLH
	BD+FrSUIo6PFedzshgFzw1Au6WBOOk5Xuqiq2kycSawJuMtJZuygQ75OuVLWcv9DkxSTimC
	F6wygT25Vr5TLNIqgRJWgxfFzs78U7R5nZ6nLKFtnzy1QyY1rdxP6LPZWWZJXR8SnJxlmkB
	Qeq0vWEBtbXxtYJosRAurfSJGGKC/1i7Jw0WKhXMyxUD/UgIvdHHw5DOSR44FKSml+NIqSV
	d4vzOqvQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On 10/5/2026 3:24 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 05, 2026 at 12:27:40PM +0530, Kuldeep Singh wrote:
>> On 01-10-2026 11:20, zeroknots wrote:
>>> Hi Kuldeep,
>>>
>>> A data point from retail hardware, in case it is useful for this
>>> series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
>>> UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
>>> is present as the QSEECOM application "qcom.tz.tpm".
>>
>> Thanks for reaching out, Kindly check below.
>>
>>> With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
>>> version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
>>> (UEFI secure app). On the same boot, qseecom (version 0x1402000) works
>>> and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
>>> lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
>>> -ENOENT.
>>>
>>> The Windows driver for this machine agrees: QcTrEE8480.inf configures
>>> the TPM service with AppName="qcom.tz.tpm", SecureApp=1, LoadApp=0
>>> (preloaded by firmware). The EFI configuration table carries the
>>> TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.
>>>
>>> Through that app, using a QSEECOM transport (based on Xilin Wu's
>>> out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
>>> CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
>>> manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
>>> PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
>>> verify, and a sealed object that persists across reboots.
>>>
>>> So, as far as I can tell, retail Glymur laptops may ship firmware on
>>> which this driver finds no TPM, while the same TA is available over
>>> QSEECOM.
>>>
>>> The same applies to the prerequisite series that moves uefisecapp to
>>> QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
>>> work only through the QSEECOM uefisecapp. If the QSEECOM path were
>>> dropped for Glymur, efivars would stop working on this machine, so it
>>> would be good to keep it as a fallback when the QTEE service is not
>>> found.
> 
> No, the existing paths are not going to be stripped.
> 
>>>
>>> Two questions:
>>>
>>>   - Is service 81 expected to appear on retail firmware through an
>>>     update, or is it specific to the CRD firmware?
>>
>> Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
>> publish as QTEE side changes were already merged long back.
>> Roughly it takes ~1month(ideal scenario) to get firmware changes
>> available but somehow it's taking more this time.
>>
>> I think i should have captured this dependency info in my series cover
>> letter to avoid any confusion.
>>
>> With the changes, service uid 81 will be available and won't see qcomtee
>> driver issue log there.
> 
> You are responding to the user who uses a COTS commercial device. Are
> you suggesting that the user can somehow update the firmware on that
> device?
> 
>>
>>>   - Would you consider a QSEECOM-based path for such firmware? I am
>>>     happy to test this series, or any other service UID you would like
>>>     checked, on this machine, and to share the transport code.
>>>
>>
>> Qseecom-based firmware path is not recommend approach as it's not
>> generic and less scalable leaving less room for expanding featuresets.
>> qcomtee uses mink-ipc based model which does all interaction with TA
>> with just 2 scm calls and is very much scalable compared to qseecom.
>>
>> So, we are planning to use mink-ipc based qcomtee path only and I'll
>> drop an update once QTEE firmware changes are available in meta builds.
>> I'd be happy you to try it out and give any suggestions!
> 
> I feel it really sad that the team (again) ignores existing available
> devices. Yes, QSEECOM is legacy, etc., etc. However we must make sure
> that devices are being sold can be used.
> 
> I guess, at this point, the best course of action would be for Xilin Wu
> to submit the QSEECOM driver upstream. Xiling, could you please do it?
> 

I'm also sad to hear that the proposed qcomtee path isn't even supported 
on Glymur, and yet the Qualcomm team is ignoring QSEECOM, which is used 
on all the devices currently being sold. I might submit the driver 
upstream, but I can't promise anything.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>

