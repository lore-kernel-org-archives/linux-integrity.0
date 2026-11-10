Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324639;
	b=BkGgZUmyq3Vb4HANcUQQpMYUhcn31SOvn2BCQXgml7cf75P3KaKkpNtR7X4x19WLgCIT
	 7lo++G/Y7zSUuR5yU7W0FJejk5/kl6vy8wxzLCQYbFOmBQVpRc3FZJMONCF6ojM7sKLRI
	 gfQsLvreKBEBKQ40+YAIBEX4I4SkSK+D19vwU5pFvxzBupslOdq9TXukP6FkCBk6F45Ag
	 vfxdTisaCZay8TPWaikViX02W5JQst851XWIMtwgKVSEuEn9g27eTuBJK4kT0tVtjfvAZ
	 prtJehpRO76BdZNhtjK5Fnq4bzy7p+Gt7wiYAmdc+49lsSu+kMEqlHR4UMJARi/9PyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324639;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bYXFGx1B95Uafj+39AjXfi2s0Mbiqnm8xfFJ8dBijug=;
	b=OLZ6G/wKr2ka6I7iu4I5Ewdr3qAGmsItW1XTxaJSV3yIOqKgkKzZ/1cGZcO7Tvf6rL2q
	 X6PZoIwD65YYcA3+DSceuTblUtxiplyFgzG+E7dBpITuMN/qP3IPfsdJ8dYsshbL6eIiv
	 jMO8/sLpmfyZVM+koBXN/nGSn1O1+CbT9dcMtn4qTDv/HV/7LQvRtuEGgvL3mPB2safrp
	 rJLr05UeasAUXvCbUFLbArRq/h2Jf7b+Tllo7Nzjx53SgG+sepUB3t3RA0Ng8aYfrTvsV
	 gKk+oHLlKV6O/+qNosfivMhml276x8shdRJAWLLjLJlNpQQ6pE0pSY35extUvaBfWxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IoIprcnl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2160A2620;
	Tue, 10 Nov 2026 15:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A2160A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IoIprcnl
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFE9CO2666984;
	Tue, 10 Nov 2026 15:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bYXFGx1B95Uafj+39AjXfi2s0Mbiqn
	m8xfFJ8dBijug=; b=IoIprcnltp/8fm1PsrzQN2DxGFQL86/O2WfI/3iPynulQY
	1l2WKLQBjQazZOF0J3AxD9aLBHSx61vu5xbYVjDyP00cqxc9qjWPIuD73SsDwL1v
	Dz71vIZ+O87iNFfJW9FZa1MkNgDCg9wULVrf73C8x+aSnGhZ2xGuerP97ASV2IcT
	lIwHtRfhwalDZZgxFu4Xw0SCCmKzJZn8Hr6vndqtKYVyosO/+MZiX6JYPtLo1sMI
	Ov/DVEUCrADPKnhuzI+kV4KkdF6hT8C/Am8F+kON30zG/cawobRKz1AOHjJUTdFm
	Fr6wnFzo0S0c8dxGenw9WDU3QTPVUDqomqJ2Bw/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuvwdh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:30:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFJxSA1972202;
	Tue, 10 Nov 2026 15:30:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvy88v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:30:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAFUYDM18481794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 15:30:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A41A58061;
	Tue, 10 Nov 2026 15:30:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90DC5805A;
	Tue, 10 Nov 2026 15:30:33 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 15:30:33 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------8fha0YHSRmhg3C0ISGSEhsrK"
Message-ID: <5552ccf5-87aa-4d29-b6f6-01e48674d443@linux.ibm.com>
Date: Tue, 10 Nov 2026 10:30:33 -0500
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
Subject: Re: [BUG] tpm: prolonged stall in vtpm_proxy_fops_release() on Linux
 7.3
From: Stefan Berger <stefanb@linux.ibm.com>
To: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
References: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
 <aud4isATIt0JOOL_@kernel.org>
 <012799b9-aa35-4990-86df-23b012ab94e6@linux.ibm.com>
 <CAO-4RZ0Od63iUeFkoPznV4vd84Ghjii4CGo+khybQckCv=EXkQ@mail.gmail.com>
 <931108a5-e880-4b74-b5e1-8625307af8a9@linux.ibm.com>
 <CAO-4RZ3mtXVty2dhjcT=ZX9mGnsDsYrvYe4Mx_u1TBgF5yi9PA@mail.gmail.com>
 <404c3349-1a9f-4bd3-b75a-187407855a39@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <404c3349-1a9f-4bd3-b75a-187407855a39@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfX8+lOKDb2PkSe
 VasUKj4pRVacR/FmY5CWBBgB8KIexMpftaS+zJyThev/GArF9imcOl2Jga30TGPB3M0VcFDYC92
 WCRuxabiW9Twe4tqde9zCq21on4hGis=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af3389b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=Bau4-PFvkfs7xET1opIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=VkyE-FT4N_lJajCC7C0A:9
 a=B2y7HmGcmWMA:10
X-Proofpoint-GUID: RGxF8TLwFSgmIxGXmbx1yo8zyIoQUUGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfX6FXNDQKUkhLZ
 tCBgDqxjZ5CMxsoWZi3QH5VUpdlp/PgcJrPdlNjXcHinqHgylcA0uOj7M1PgZCLMKMnjR3MUc+f
 WZXsVjde1R7EOGBeuvKPKOIUANxLu8pAIZ6pi3UtsjOtBwohs1ASluVEtwm03Py1vkSpAKNmfHF
 7XMfkejYbwaZ3I5tu+SK/MLs87ALdS2iwwYJN67HPN91mp3t52SossT993O/SAnCwEv7kIuBGb1
 hI01O3n1bUWGC+oecyReAndI7Zy1v85IFnhrgbnx/MZPOhV0h/jMek3clvKaIIGrp745XzUcTPl
 OjpuTtS2erAW0ToETs7JDvgc8FeQQoZVsH/3aycpqwKL9q1IsthiPm67TeLsOIDs1zcZ3qps8Qv
 yod/E58JZkB20kN1wDE1QDxei0EhdXrr/8iYfmYNgE8iNCqAHlmZdQVNc4RNoD+KE0HBjjf0po+
 WZ5Lu3bAFv681ssIm8w==
X-Proofpoint-ORIG-GUID: CPTMS1b1HVnNkJYdSv31g_FNQcElj5FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100060

This is a multi-part message in MIME format.
--------------8fha0YHSRmhg3C0ISGSEhsrK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> 
> On 11/10/26 1:42 AM, 铮 wrote:
>> Hi Stefan,
>>
>> Thank you for your question about closing the server-side fd.
>>
>> Short answer: yes, the server-side fds are released when the
>> reproducer exits, and the hang occurs during that release. The hang
>> reproduced in 4/4 recorded exit-time release attempts (three with N=32
>> and one with N=4). However, our separate tests that explicitly call
>> close() on every ioctl-returned fd did NOT reproduce the hang.
> 

Thanks, your supplied C-program made reproducing this issue 
straight-forward. A patch resolving this issue is attached.

    Stefan

--------------8fha0YHSRmhg3C0ISGSEhsrK
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tpm-tpm_vtpm_proxy-Try-to-disable-queued-work-before.patch"
Content-Disposition: attachment;
 filename*0="0001-tpm-tpm_vtpm_proxy-Try-to-disable-queued-work-before.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2YzRlZTg0YTI5ZDY1MmM2NTcxNGRjMDZmM2NlZjY3NGY2YWM2MTI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4Lmli
bS5jb20+CkRhdGU6IFR1ZSwgMTAgTm92IDIwMjYgMDk6MDU6NTQgLTA2MDAKU3ViamVjdDog
W1BBVENIXSB0cG06IHRwbV92dHBtX3Byb3h5OiBUcnkgdG8gZGlzYWJsZSBxdWV1ZWQgd29y
ayBiZWZvcmUKIGZsdXNoaW5nIGl0CgpJZiBhbiBhcHBsaWNhdGlvbiBvcGVucyBtdWx0aXBs
ZSBzZXJ2ZXItc2lkZSBUUE0gZmlsZSBkZXNjcmlwdG9ycyB1c2luZyB0aGUKaW9jdGwoKSBv
biAvZGV2L3RwbXggYW5kIGRvZXMgbm90IGNsb3NlIHRoZW0gaW4gdGhlIG9yZGVyIHRoZXkg
d2VyZSBvcGVuZWQsCnRoZW4gdGhlIGNsb3Npbmcgb2YgYSBmaWxlIGRlc2NyaXB0b3Igd2ls
bCBydW4gaW50byBmbHVzaF93b3JrKCkgYW5kIGJlCmJsb2NrZWQgdGhlcmUgYmVoaW5kIG90
aGVyIHBlbmRpbmcgd29yayBhbmQgY3VycmVudGx5IGFjdGl2ZSB3b3JrLiBBcyBhCmNvbnNl
cXVlbmNlLCB0aGUgY3VycmVudGx5IGFjdGl2ZSB3b3JrLCB0aGF0IGlzIHdhaXRpbmcgZm9y
IGEgcmVzcG9uc2UgdG8KaXRzIFRQTSByZXF1ZXN0LCB3aWxsIGhhdmUgdG8gd2FpdCBmb3Ig
dGhlIGNvbW1hbmQgdG8gdGltZSBvdXQgc2luY2UgaXRzClNUQVRFX09QRU5FRF9GTEFHIHdp
bGwgbm90IGJlIHJlc2V0LiBUbyByZXNvbHZlIHRoaXMgaXNzdWUsIHRyeSB0byBkaXNhYmxl
CnBlbmRpbmcgd29yayBmaXJzdCBiZWZvcmUgZmx1c2hpbmcgaXQuIFRoZSBkaXNhYmxlX3dv
cmsoKSByZXR1cm5zIHF1aWNrbHkKYW5kIHVucXVldWVzIHdvcmsgZm9yIG1vc3Qgb2YgdGhl
IGNsb3NpbmcgZmlsZSBkZXNjcmlwdG9ycy4gSWYgaXQgcmV0dXJucwpmYWxzZSwgdGhlbiBy
dW4gZmx1c2hfd29yaygpLCB3aGljaCBtYWtlcyBzdXJlIHRoYXQgb25nb2luZyB3b3JrIGVu
ZHMsCndoaWNoIGFsc28gaGFwcGVucyBxdWlja2x5IHNpbmNlIGl0cyBTVEFURV9PUEVORURf
RkxBRyB3YXMgY2xlYXJlZC4KCkZpeGVzOiA2Zjk5NjEyZTI1MDAgKCJ0cG06IFByb3h5IGRy
aXZlciBmb3Igc3VwcG9ydGluZyBtdWx0aXBsZSBlbXVsYXRlZCBUUE1zIikKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEJlcmdlciA8c3RlZmFuYkBsaW51eC5pYm0uY29tPgotLS0KIGRyaXZl
cnMvY2hhci90cG0vdHBtX3Z0cG1fcHJveHkuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
aGFyL3RwbS90cG1fdnRwbV9wcm94eS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdnRwbV9w
cm94eS5jCmluZGV4IDI0NWE4Zjk1OWJjNy4uYzUzOTE4M2FjYjAzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2NoYXIvdHBtL3RwbV92dHBtX3Byb3h5LmMKKysrIGIvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdnRwbV9wcm94eS5jCkBAIC00NjUsNyArNDY1LDggQEAgc3RhdGljIHZvaWQgdnRw
bV9wcm94eV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHN0YXRpYyB2b2lkIHZ0
cG1fcHJveHlfd29ya19zdG9wKHN0cnVjdCBwcm94eV9kZXYgKnByb3h5X2RldikKIHsKIAl2
dHBtX3Byb3h5X2ZvcHNfdW5kb19vcGVuKHByb3h5X2Rldik7Ci0JZmx1c2hfd29yaygmcHJv
eHlfZGV2LT53b3JrKTsKKwlpZiAoIWRpc2FibGVfd29yaygmcHJveHlfZGV2LT53b3JrKSkK
KwkJZmx1c2hfd29yaygmcHJveHlfZGV2LT53b3JrKTsKIH0KIAogLyoKLS0gCjIuNTYuMAoK


--------------8fha0YHSRmhg3C0ISGSEhsrK--

