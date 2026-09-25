Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBD43BDC0
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326340; cv=pass; b=BNAKcbr8IgyQt+b5ztzjso0wgvySHuucMLCFuuw3fY78yRclBADMfF18lxPF+kyfvWHZzlGCGWv8Ti88du3/62zNYGwJ56ZjYlY4u5hwO+jn/0fomNNfObSlOKXnSFlXc47vdrj/tquuy5JUV+hsxMHoZIosuRZl9HJxsB8Al+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326340; c=relaxed/simple;
	bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0x5VHdK/p8B+tCqFj85ZrAZAx46U2va6YP9CS5v2dZqTxPH2VnR57Ptm6znXZfQNAeBf8zcpwRAFTkYJ2HbekcNkcS/YjkmwVRdPV2HzMHIS2J604X+0VAUoh5oyX/nZ0xqwLmtXEWCYdY3zWh0XWlGoE6sfLycAz6Z5CYtscw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FzITLKn9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KP9Mmbsv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FzITLKn9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KP9Mmbsv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YWln1055788
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 08:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=; b=FzITLKn9j+513a4u
	xcz+VLAxyXK4L6uMXdE5jVGFkgGhD2M9DXsbY/74YqpH6wWmaR+CrZSHAkF0Juks
	EfHoRB7KfXqQvQdKrSvVx+YT1VSXtIDV3FIZNoTiKmGrufCULMfnhpWmkVz58gm1
	otnPHFn2bT8nTLW+e+u5VjRhZodGLElu1+XN8ETO8X+Lp5Sw3J7FZ1lVTDiqjGz1
	FsU8LrQGb8RmyrFaB/V8Y9DOWMPFvATvsB4uScYMV+hltaNRUoJVyq2sH9A35uPc
	Fk+bdkdplmkFPLX/W3/tY/rnYnYzymRAOC01no3h3XLzpDHe34YTe/K0H9JU2MoP
	AWzM8g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce79pqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 08:52:12 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c767e23f6so814523d50.0
        for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 01:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790326332; cv=none;
        d=google.com; s=arc-20260327;
        b=Tl681t5VEn9uvWKdcNT+wC31GnpaYc+1qflWpHcW4YZheDLaeOWxnq/d+8xWmft+1D
         ya+KsGH48RMOJUBQmCUekyc4kCqIAfEt4Zx3etolXtZ9fDChBUOFJzRplCFLZ5kUoRWa
         BpaFWncW27Om5Xb6T8xyInmeypyFsClba3u6bwmdmS3Vbwfw061WqG6vAj5U/8x0uJdD
         7C5c+IgrF4h+9Xa3ioqJWumUQLbf2BaONafkNEYtEyuzgbfE09fajfD5b/1cZI7tSPUB
         2MY5M/kCdMVaTqPZjj+Zt/jYrZ1Li3zPX4I38l7f3LjZ/aZn7b7EaaEiikRipqCjn5FO
         JsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        fh=VIY6YdbS+rQFW5u+Gl7XO+YhCry9jgVATYXOrATQMuI=;
        b=TeQV3yE/LGzBAbFlx2STdhrlDyXzeisvcdYu6j+3/3c4tSuiNq8aWSFK++xEClgqyW
         w0QnNVhuOdNMYcPPhHxwHZc+X9hW1+wNLGt7yjopk/ezRCIYGSrCEENE5DYiVdlU5442
         0iT7OhqxQ/XwQD08zMpqCjm7rHsFy87lo3rfXaViDlDCdALNmAz7SoAMAftShmVJLK0C
         Br23Yio0XNWZdsaqUGL7gP7hOsn3mzgONS3GWEeHW2uxPHWh6WtMP5vmugTRqeaUT464
         6nPJ89uLx4xNxgCsB0Il0R9K2Zk7pdI5kFo7cjDKHr6MXLjH5ZuBB5XsyTXuwSEdy8XO
         448g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790326332; x=1790931132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        b=KP9MmbsvDB85RW/B9FsaR6nHtTkU+/hu/k3r5ofovnLFDQ2CHk1ecO4Wc2B3h7/SD4
         JxpyyeK/qNwDnbyTsoU0I7D2Jj6mgmWXfFei6ejIDSndL8AGFP8uQp3VoG0mazq28cpf
         Zo7/mSAmCbYIEfeSe6iiwtARGjcgo21RkztEN0zzwHRp3FPNhpXsXzZbTJHNnrg4B1u8
         C/YjQP1V+yApsT1G9DN20SiS8iGHwVzPKZebpW1JO1iTl2BCeUi7YpHVqNt6XlK5132Z
         04tSopVI4lD2h3RaToa6N0HTya71dHp8bv/FQnME172ykAKrxxL0ITEaNvRQmPd9EUPL
         8A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790326332; x=1790931132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        b=Tb/JTU0sr8I7h9cT2WMiU6yfjJ272FtbL5qvBpq7VTG9+Xu0e6o/jlPIBBO/WpJiaK
         2hKqnSXlG2lNTT4CCRcoePW7Dr8KC0Bjh8CEdAW8d9IOADkc7FyszKzNTrr8kBdnvTW2
         UWg6x9zo2H8Wql9XIDgrqV2dAEwKsolkrP5eiG4K0FO7+J4Xv+J0ZiyNx/mzwLdCv4Xr
         VLWYh6MLXOniH08pAU6GqaDMPfxYxKO1ycX+af5Yb/EYo/dsoS0tXSZwH/unqlWisj0d
         SkG0XfEW+56ouo3qAgqywelWdg2xulgQE+ZwlaGicxGFvgrk4A/FA8nTZD8P4cfRsgo2
         LsWw==
X-Forwarded-Encrypted: i=1; AKwUvBzu8OPtQcbzkS7O2AljWO1TWv9If5R4CUjF6B4gT/mY1LtO+sLXDgMyLIkMwr6miUPSYZhwaXX+2G04MtEtz4o=@vger.kernel.org
X-Gm-Message-State: AFuF++kWD9FxGvsTmyQvuraB5XDj+623ELiXLt0mT+WfDpmntu1pbeVz
	EnxUgC7WgpN13wlkgy4cxpNQEZOFNvcbQIIl8gN1EOZ5D69m+6qCD2yGMIV9O5a+mdvNg48La3S
	zv1YaBtQ/K1I+g5MhuEG+KwfODqtOq1MbWFPZdrl7fLzBDuV/15NxqSsMc7uBnE+CnTtCENj2bM
	jgkynC9NynQ2GvsfDIwrM5lTS413/RHM8d3b4GFrnV9NOtB4pgDHeZABpc
X-Gm-Gg: AYBFou3DkFGZLFwzxkR5ujtJZ8P9EOa3mHu7gTEGj/9rG1PfmXfsJmSiYX0u8nCVgEr
	2u61ziliNQCqPLRn9oSJPodCvtxnyExtKD7jnMVf3DPohCuhtmu1EPfz0lFUwmONW5FXJxRJoUF
	9LeFkTvPb5h8ZuOHwsOqOsWkdEWS1gmyh1GhthDiqvvjmUbLWYA7p5FpA=
X-Received: by 2002:a05:690e:1916:b0:674:1968:4179 with SMTP id 956f58d0204a3-67419684d82mr52900d50.74.1790326331807;
        Fri, 25 Sep 2026 01:52:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1916:b0:674:1968:4179 with SMTP id
 956f58d0204a3-67419684d82mr52889d50.74.1790326331440; Fri, 25 Sep 2026
 01:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org> <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
In-Reply-To: <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 10:51:58 +0200
X-Gm-Features: AclHuK9gUY1vpR5SsZhMNs7YRGjFnTD3Zk58XCNLuI-MxS38RfhycehCFaCK3P0
Message-ID: <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for discovery
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Smw8D7iCFYVIu-Z-BYMZbdo2pw_UiaBs
X-Proofpoint-ORIG-GUID: Smw8D7iCFYVIu-Z-BYMZbdo2pw_UiaBs
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6363c cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=HjU7GSAyVm1pYthcWuMA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNSBTYWx0ZWRfX+T67qkYavakq
 4bt8f4KA86hLeIb02RX+oa1vvOu49nbTQ9/cShXhDkeZgGDtNO6H/WmT0mrAnBdkA5dw7zbzrFy
 1o+II23Qmki2gzI4LullAmDV9Vq+InmbPxSMkBABsfNWCt2BKHtZs6mqe8mhAi2MG2FPNHZIbnI
 moGIphFNxVKA3SnNi/f4dmycG4zYUAFzPjDrGP7jOFtJHXEGgcU5rV5Bm6Di6653ONDxlcTeatW
 gDGnpLxNWPnkILgJb6d36wv0S53dB856id11W+1sEMlo8Tnqzgj6c5xKtzTF1A+n14bgxWQ0Np/
 GI+c5Wqz5XiMjqkPUGA5IfrCMB7bq4mZmgz26ju4ZADnzpIShru9ycGoZUsMIZw6XuHAya82KJE
 CpEyV5OpyybaYxUeN4LevdSpJ6KFjlRZT/CdG+g7IOvDcRVeEWQaeNiPMx5ByQQPOWPUDjdHd1N
 /h4br0nFQo7DH+dFPdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNSBTYWx0ZWRfX6oGMFZ96Wvc/
 Nos9/ssU6PAmm39pS7ps5HhMbFLivi0NJfxxEk3hvS26Q0SrXX6pCjxMhpzAoc726kVudZul8I0
 lyJxH89GSLjK3sHSEhtVNGGTuwNO+EU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250035

Hi,

On Mon, Sep 21, 2026 at 10:10=E2=80=AFAM Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> wrote:
>
> On 18-09-2026 07:16, Jarkko Sakkinen wrote:
> > On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
> >> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> >> is enumerated as a TEE-bus device, allowing a client driver to bind to
> >> it via its generated UUID.
> >>
> >> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> [...]
>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Thanks Jarkko for the review.
> Can TEE maintainers(Amirreza/Jens?) also review this change?

Amir, please review.

Cheers,
Jens

>
> --
> Regards
> Kuldeep
>
