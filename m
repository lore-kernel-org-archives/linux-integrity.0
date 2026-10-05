Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D28371041
	for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183469; cv=none; b=hdSQg6QcA14UO30gRT8ga5/FQsVOz1PbXRGjhEClEzLjAtdJp/tt9zoWbRekQsEJANETxcq2QMxFICXVTHWbGp0EhCvTPaQc7sqtZqT1oHCnFNJZ2nxMJ1WaAa4Kf5sz6JSQ90dB3zs04ik7oirJ9dkQ3NS5+zIhAlLeiB/T7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183469; c=relaxed/simple;
	bh=qbIdZAKoZiKIXm+V7iO8Tpd5L7KU17AoLK6Q9ugcdhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7hxeFPVwDVSGrLsaxI7cUmXqne/i8tFtGIcPHQt5vQRVTxegwxC9kBNUCjW9Bjkg/kZlO4voAc9rgtaObXvA0fruwrh2wgppnFv3XPUl8K7mcXnJOQQEpzNK9K8EguXo8qrhMe6q25JF/8otEzXtzZ80WPkyabTTJLAbthH1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xptj5nE1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IQfE/Pzu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xptj5nE1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IQfE/Pzu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695102bi3242295
	for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2026 06:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=; b=Xptj5nE19lKE7Uao
	lpJEc7rsV6Jk09upWLVCUdx0yv8u4fiGfUlNc1RBT/kux9OLGyOGUgZHbjM6uyPx
	4aOh/z6KTSvtSgAT0i8eIX26vHmz5/LsEtmdBiiW5I66cA6yJ6nFqQzNOxqCSFZT
	u0v8c0kQhaf0dVyPBDbptu9f9yuB/oF+gyx7PZkz0jRUpbh2d6Bj/cO4p0dvC9+P
	62xOIag0K1WKnwvWuZaI4tv3+7Ehj6YijOdFOlwmOokgxXvxwczHEhHv8YFq/p8q
	XYM0UbSfdV03qYyoo/SEPAF/etehdX9z7dUBAi8qpNmfG3QmqSofRsHg2j+p+bpt
	UuQ3VA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevnkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2026 06:57:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8886b1d3242so959060b3a.0
        for <linux-integrity@vger.kernel.org>; Sun, 04 Oct 2026 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791183467; x=1791788267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=;
        b=IQfE/PzuyZQoxwEPEGESAUdxsqVB91Jb8Gs+FAPbRw8Lnlzjo/+KC788TEzM18rz31
         bWGAd3iF79S593M0Ep42rZ09XuXU5Xqc97/WYuR6ftIOZO5h+5kVGf9VOyiKlfQ2OTNr
         YPqRfniXrIIkrxN9ct9lLbYf8LJ+ai9I8i+2zSWs5nBkxnEi5eiuYf7JTMrXt8a5CLcK
         UlnQv//+i/laGdMhFjCgQKMDO29VZQ84vuEVWZU/omnVvRW93kIS10K4zJ+1lVHtU+hm
         +bs+OCcwO7bQGaDyvpDsGY5joYBzpcpA2s4ZHzY3hEqum7L4uNq8tt9+R+PBpKUNGAl8
         SGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183467; x=1791788267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=;
        b=JVv+S972D65KmKVDJ6vbWDt167uckfpCUgUYAuY2YgdhdHz+VNS+Jb0BHVrIvVWXC4
         N7JpvWc4kdfhYio+I9lCB87oonuf0t40e/9v22Xtq4X+/OO6AT809FG1HCTtd7PaGHKt
         WYIZtozj1y7xQc95BOLdHQmb8CherOApEuM90it1KeeM2VevAdKFgWS0uMusF9wccHqe
         V2yDPC+CrWDZPeWd2O0PljdE9wsHTHc0B+SUXyAogwj7mEH2JYRo8U5Sq1egStSitdNB
         qH74tPKDtHtbnwo6P/j1wedPGXMlJTCDsnTohfCpDObBwzURGsZRHE/g38MCGtV3+D/6
         Kx6w==
X-Forwarded-Encrypted: i=1; AKwUvBxaWUvu8/Qbr8aQZEmhPavWMvMeKRfELWep/zczZGm3XSjv1JTqPEHvsknUwb5SUifsozvY4P2iugpQJArlL30=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoBx/HDxVPNFev2XwRoFFbOwHax2sG+jTSAi1pj+BDj5Rrun1m
	lcXdlXQ11UEK514OronwPheBgQYs5l70XvSj7m5LnzzIasBbtsiFmNxP82eaYrXmgZ4GX67J1Oa
	EQFh+AdB3sKhNksczjZJxiiaDOUHOWVLLt8kFy05L09EazHtKmeeq9gqMgjPw0NkZC8+RfmQ=
X-Gm-Gg: AYBFou0+CBSgMXmnDZP0nwdwJ0WKukVI/ozYf1wL0i77pLrp4xhVovuGZTJTkoEAd2n
	M2RwdzppDKiu5Dw3WFczsftLDiNOgcRCLeWZqUn532LhRyQZaaf85+H7uWrSuyiPLpQrNr3zBfJ
	zRUvIn4+z3EZnzNaKyhoEqOHqpBQWbGD+dsgWmFaqXt7Cn7HikkSpuxs2Zyrz5IUmiffvN/GZ5q
	G8W5jYqdK1BjQWx+7wO1qMze3Hpy90FAG9Muz+cty55/DUDbm4zOciMH971WYWm9MxSv4YfM52d
	qC1JGnsPF84XiZVrZ+g8ef0GA265rWSTUgFqhQ8+4KAuliuTZMZNjwpbpGJw3D4YiEKsnAxY9N/
	zGWSx9/moebk0B4ZOVTvhnoU0gW/7lA==
X-Received: by 2002:a17:90b:3b83:b0:39e:6c69:34d5 with SMTP id 98e67ed59e1d1-3a6ce95dedamr8429182a91.57.1791183466737;
        Sun, 04 Oct 2026 23:57:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3b83:b0:39e:6c69:34d5 with SMTP id 98e67ed59e1d1-3a6ce95dedamr8429177a91.57.1791183466189;
        Sun, 04 Oct 2026 23:57:46 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a5150sm9834853a91.1.2026.10.04.23.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 23:57:45 -0700 (PDT)
Message-ID: <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 12:27:40 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: zeroknots <zeroknots@protonmail.com>
Cc: amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org,
        jgg@ziepe.ca, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de,
        sumit.garg@kernel.org
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20261001055029.1960743-1-zeroknots@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 838llFn7PesRg5v8P8hGJ4hf-cdwvAI1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXx2CsXnlDSFxG
 IVXVInZyDmQWfV5+D/UmqivA4/TtewsaXJVVUXY/rwdWnulfqfutFaWtivqQeXA7VtolVepurXs
 W7H5bEpCYt/LOPcsk6K83FRpEBzcWZU=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34a6b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=MGVvYQGpb7276ASQA-MA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX6HyiWQEvGN/2
 cmHM/SjTVUb+I1iJEbSz74VD3+UYyG6f2rJ8HjG0FipuUbH9ND4dBppAj9OVUpz6hnVNoT238dF
 tn8Ftr1tYdNljRowBIdpPtgw+qSU1v6uUjH9hwf9Uh1KA0/ic8ma922uETVAROca3fvN3LiNdgS
 sMFG/1YWIC7ZxbcJyVM6lrz2JIR1ozcrtk2QFWHq+mgqnjUmz5csRQXfOdBm/qn4KeJ9wIAXEIb
 it0DSxMPZTfX7XL1nHBcEC9UXk3kc1YG8/DvUx7KSTfc6z+RssIF0Fpd2BZXcKWeVfpZ+jBv3AQ
 2ogFsKoXFfA+DMJY3oxi6uhSV5Kgjt5UuCFm0ZVElDz8x7bvkIpUBSxQvAbOkUVcZ7x3ObBWd9N
 iO6+gQ9kCVn6YdQc44hPTDpHB64b7VNJAVuQ3ljFVgdwrsiFZfqung362tR+yTSnLxuzyP57g7m
 nWMrkVZnLAtL7F9aqRA==
X-Proofpoint-GUID: 838llFn7PesRg5v8P8hGJ4hf-cdwvAI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027

On 01-10-2026 11:20, zeroknots wrote:
> Hi Kuldeep,
> 
> A data point from retail hardware, in case it is useful for this
> series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
> UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
> is present as the QSEECOM application "qcom.tz.tpm".

Thanks for reaching out, Kindly check below.

> With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
> version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
> (UEFI secure app). On the same boot, qseecom (version 0x1402000) works
> and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
> lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
> -ENOENT.
> 
> The Windows driver for this machine agrees: QcTrEE8480.inf configures
> the TPM service with AppName="qcom.tz.tpm", SecureApp=1, LoadApp=0
> (preloaded by firmware). The EFI configuration table carries the
> TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.
> 
> Through that app, using a QSEECOM transport (based on Xilin Wu's
> out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
> CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
> manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
> PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
> verify, and a sealed object that persists across reboots.
> 
> So, as far as I can tell, retail Glymur laptops may ship firmware on
> which this driver finds no TPM, while the same TA is available over
> QSEECOM.
> 
> The same applies to the prerequisite series that moves uefisecapp to
> QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
> work only through the QSEECOM uefisecapp. If the QSEECOM path were
> dropped for Glymur, efivars would stop working on this machine, so it
> would be good to keep it as a fallback when the QTEE service is not
> found.
> 
> Two questions:
> 
>  - Is service 81 expected to appear on retail firmware through an
>    update, or is it specific to the CRD firmware?

Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
publish as QTEE side changes were already merged long back.
Roughly it takes ~1month(ideal scenario) to get firmware changes
available but somehow it's taking more this time.

I think i should have captured this dependency info in my series cover
letter to avoid any confusion.

With the changes, service uid 81 will be available and won't see qcomtee
driver issue log there.

>  - Would you consider a QSEECOM-based path for such firmware? I am
>    happy to test this series, or any other service UID you would like
>    checked, on this machine, and to share the transport code.
> 

Qseecom-based firmware path is not recommend approach as it's not
generic and less scalable leaving less room for expanding featuresets.
qcomtee uses mink-ipc based model which does all interaction with TA
with just 2 scm calls and is very much scalable compared to qseecom.

So, we are planning to use mink-ipc based qcomtee path only and I'll
drop an update once QTEE firmware changes are available in meta builds.
I'd be happy you to try it out and give any suggestions!

-- 
Regards
Kuldeep

