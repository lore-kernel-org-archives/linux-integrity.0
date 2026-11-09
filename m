Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248127;
	b=fUKDfMEWHNQTxSlEy/LdOXJeMiWeNIxWLPA3Lbn7IeM1CIT73RlRQGVBoVzhl+PYe6Yc
	 T5ltyJPQekSqBWayYNjGnfqeYKOXcO0MDyR08xktV6LH1nSg3Gi4tSd2GWEEvG0b7XvBG
	 MUBnllrFIXBS9utVnBKGEoct4BL9vtN/irgXd0eiqF0cbbtxgBueTGNL8W3Wg5OphDyFu
	 eBgXv68XyCx6+pHhmx6s27A+Ji8GqUE1/lYc5ubfgSX5PZFBY5X4LKnqeYhkNB7tharxt
	 3ntzq4MqQ3KyzfCgdRZVBBaapCcJXcpiaH5zy/zdVcmBvi51IXJKkiSVI6qZdB2VBHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248127;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QOGAxVORIKoSEY+zTHFpf5NJugQeCAGs7Y19X5OX6SQ=;
	b=4aH7hrYaH8CeN/FntcbuMl+pYgLi7kuwMx0k68/1/8MUcHCmgSrkJgRkRVc6hvQBe3Oe
	 L5kAmU0UDvRC8DUiM9rdhZETUs038aV7cC+GI1ZZuy7UHiWgfJIKp/vcs3+vTJAa4Jbrz
	 uUqA38ju4ztfZXxDGtBUkaM4MrGyJ5EUBKC3MhGetfg0O0DQBPWVJO1psn+0ebtGRFUyS
	 6nQWdLcQqaPoXo3F4cfjOQKdcv4tMkphvglg/NuB5lhHZui10NB+/ndOanAIpOnaxGfyL
	 8ZRzlaUbZQptd5iScjwfZK+gGbX9Y1xPAQwIk1n/qB7xYKnlH9rE5849uyGaaKLyZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UzEELR4e;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E98606A31C;
	Mon,  9 Nov 2026 18:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UzEELR4e
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HiGHW3000769;
	Mon, 9 Nov 2026 18:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QOGAxV
	ORIKoSEY+zTHFpf5NJugQeCAGs7Y19X5OX6SQ=; b=UzEELR4evDP/i9Ih1lNhhe
	erZR0lwwHlM8c25CS2bgahJ0uDL0nmgt1t5j0A+SFMu1UZlo14Iroi9+ox2TJkSx
	nkSAc7DpMmTa6tlAbUtFL49ZxJLKdIofXL0Gl86Ngiv8bfHiDgz+fm7zU9g2YdVA
	aiO2BC5bY/uSc5NcNEu86pYEmnImtdeUNz8hh1L9YEgYPV2ecaiXLCrnSbi231XJ
	6vXufBlaxxbglljhHTq6o7UQ61esclI+lRbTjW9gMxLYNeQu0NNQtX6rMY1Cm8T1
	jUtr0+rCa6gcZVnxxDDbiwqiwxyqo7QbPEbqHWAJPFxKo4iwwltyb11dw4JzHqJw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfyyn6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 18:15:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HKX85482206;
	Mon, 9 Nov 2026 18:15:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y240h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 18:15:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9IFLdQ27263624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 18:15:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7871B5805F;
	Mon,  9 Nov 2026 18:15:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46395805D;
	Mon,  9 Nov 2026 18:15:20 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 18:15:20 +0000 (GMT)
Message-ID: <931108a5-e880-4b74-b5e1-8625307af8a9@linux.ibm.com>
Date: Mon, 9 Nov 2026 13:15:20 -0500
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
To: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
References: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
 <aud4isATIt0JOOL_@kernel.org>
 <012799b9-aa35-4990-86df-23b012ab94e6@linux.ibm.com>
 <CAO-4RZ0Od63iUeFkoPznV4vd84Ghjii4CGo+khybQckCv=EXkQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAO-4RZ0Od63iUeFkoPznV4vd84Ghjii4CGo+khybQckCv=EXkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af20dbb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=x6uE0WptQeE1m4LxGL8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MiBTYWx0ZWRfXyUW3i0RknXUF
 raS8l3Ry/4dDYEDhyHKllGVJ8d0qda1M8PyaaC6doxsij9JvxJUijq08VH5EqkbP2tD+C7bD0oa
 WQjV8lRNf9RMHZqEmuBJ0RNFT4L5NRM4NBbFkhikXwjHnQVuGoZoC7dQ6eHiz6QAeb22ZdHkfJh
 O/hCkDoiHKFUsDZSE9a+vifZA6jEzOevIpbuVpjGsdunDpf49jnt1ZoWfwoFQK8Z8ANPZ5O0yMJ
 amAdvgCNTqJTgaJ+77uCu22OopFNH5DtEyjYtdubIh8wpfEIadYedy8lHZn63peGCfMAyLvQX44
 +YnCBgGrToqMUCT2jgLCIvwiypjbYwAmkCyGUYocYC+25CdDOG0lAgd19106wlHuzButF4FZZi2
 Yci4SRRSynl+rrWFmtmgmMA+JpekT/BIYvwbDu2YMvy3bWrxktVwiO3mz9oGJXaGjAYiXf7PCNY
 jB0LKXFhGwOJ4S+k7pA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MiBTYWx0ZWRfX1czYllJczNuO
 BaKSdoAj3Oy494CJAX+tYQry16avLSVoac4Qq1cdvX3Uan3sm6dRBZktQRIiIdbfOlCqMTekFfs
 TVlpt3FcaAXWOfwc+MzplAw7UJBQYxQ=
X-Proofpoint-GUID: 5ShWpHk0MzBRw9ysdUkXSKbyCK7Hg1zw
X-Proofpoint-ORIG-GUID: FH1QuUAwHWdD25ZcLNplgbw5Z_bJDo6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090072



On 11/8/26 12:15 PM, 铮 wrote:
> Hi Stefan,
> 
> Thank you for the patch
> ("tpm: tpm_vtpm_proxy: Set STATE_OPENED_FLAG before inode is created").
> We applied and tested it, and we have also reproduced the boot warning
> Stefan reported and identified a sufficient condition for
> it (running without KVM acceleration). Two findings first; "Where to
> look" at the end points to the exact files in our repository.
> 
> 1. Your patch does not change the outcome of the hang
> 
[...]

> 
> v7.4-rc1 is affected as well: drivers/char/tpm/tpm_vtpm_proxy.c is
> unchanged between v7.3.0 and v7.4-rc1 (empty diff), and the same
> reproduction hangs there 1/1 (t=402s, same signature).

I have a hard time reading these .prog files. Are you closing the server 
side file descriptor you are getting back via the ioctl to /dev/tpm? 
Have a look below. If not, that could be the reason why its hanging. If 
you close it, it should clear the STATE_OPENED_FLAG and wake up any 
client waiting for a response.

/**
  * struct vtpm_proxy_new_dev - parameter structure for the
  *                             %VTPM_PROXY_IOC_NEW_DEV ioctl
  * @flags:	flags for the proxy TPM
  * @tpm_num:	index of the TPM device
  * @fd:		the file descriptor used by the proxy TPM
  * @major:	the major number of the TPM device
  * @minor:	the minor number of the TPM device
  */
struct vtpm_proxy_new_dev {
	__u32 flags;         /* input */
	__u32 tpm_num;       /* output */
	__u32 fd;            /* output */    <--- this one here
	__u32 major;         /* output */
	__u32 minor;         /* output */
};


   Stefan

