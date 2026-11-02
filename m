Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628164;
	b=W34XfMZ+ntDB3o0tYnbLhOQ2nt2NnTp15XqQq7w4fx4af/GgllD7BNkQagDhgUP4bYVx
	 q4Oqu2HVjUTYefZ+kDxKT7DORdvKTWfqCkbqbdMRaLBBhwCXNVtAars1Ozf5yFw95CYL0
	 2jG8a7AsbydWt6Cw8hpoDh3ObZLAkgNZp+3G/oN7+FLDXOj0hrGsQMC5J1GJYmrLGQd3w
	 +GpEJbR/TUwFz4WrepmwQXX5no8eeeZBGiD3HVF+9fWSlomXpeN5zIxleIHx7dNwm1pef
	 +p1e5JlP7BIH1lyLzCpfAGof/Vd34YqKB7lC7zZamb004t/Y0jq9CZ/N5xbYa+7f/Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cNpPgmusTsUT/nCch8mbmLMMTgP0TQIZobL/6Lkhyy4=;
	b=Iow0j59uV3RyrF1IJuuQo0UAO6QBGxf+nh8DFLrXSuMRwnbzeahansQmUl6xCztzGC82
	 3ECMi/mR2UGCp43GGkacnwtJSWquwMs3g7qtnLW4y1JKkVwy9IhVUpXK9jOAOLDxUP2bv
	 cZkjPzz4O84NfudqoYzaIBJRMFUO5yAIZPhq8LWjTxKkFfuShAesbnWxXvOlPIG75aonG
	 ZIfNqQpJHQIznVgG6pldg43EfrLpJfoy2xLMYFJU/On7NnXrZ4Y15jgkqMQZCSe2RnL5p
	 LfWFl01QP6QHCRnyMSn33XR/3dPlYvzsZ3SO4fzh7tXJAlaABNo1N66TkAY/5FKDMAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eorhFOqh;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DB606A329;
	Mon,  2 Nov 2026 14:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eorhFOqh
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DENag2987661;
	Mon, 2 Nov 2026 14:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cNpPgm
	usTsUT/nCch8mbmLMMTgP0TQIZobL/6Lkhyy4=; b=eorhFOqhcTnODDzZafK9ea
	xN4H0htW9IGjYw7/kfZArtAsOzWgE2V90aC0knxWxSK1txIs3fNX15ZgCmxyUOmA
	fOnBlx1TF1wCXWv8FagmhcU7H9uiZ7qab0tIdMJ0aanDhLPNUtyzUWPCQoyXrUsw
	lXhYUe/dncRA7rG2FKTtcpTYJWfjKcWA3gSNCKLxLkEaypjhosKaI0DdcV8QFJMe
	fnawllOiytbHWeTXefikMeM864ELchXzisGsylfXF05/ICRzDXPhGWAW3WnK2UWf
	pDvZzEb+lqnwgobocEOf+PTkh9DqwTpRMbKykfrfhChHUEjE5QAj4cy5FxjeR5pg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrrqw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:02:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpI3h932340;
	Mon, 2 Nov 2026 14:02:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjx30q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:02:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2E2Zx78585864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 14:02:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B4658067;
	Mon,  2 Nov 2026 14:02:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317335805D;
	Mon,  2 Nov 2026 14:02:35 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 14:02:35 +0000 (GMT)
Message-ID: <1c0d3129-e1f7-40b0-81f5-9cf4c481aabb@linux.ibm.com>
Date: Mon, 2 Nov 2026 09:02:34 -0500
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
To: Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?B?6ZOu?=
 <fengaojigui88@gmail.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <CAO-4RZ2EzuShr1dNEQt+CEjqan8SSyD=-E9g6RW1oocah+chcQ@mail.gmail.com>
 <aud4isATIt0JOOL_@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aud4isATIt0JOOL_@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae897fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7h1wsfEz7Zp3rl062pYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfXyLqXvQut3Vax
 EFF4IqZn1MszJy/QkV1ntvTfZ1dFbaLwIxvGfFAWdfxB8awBcqtU7DFDJFFyHi0mFbrpV+vvgrG
 +dZ/m2DMvIGr5B+PN+0Aqt3W3X8vVds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX1cOtdLeMcvW/
 S5e16pDw+lT2kHUjb64hFEnzeduz6kGQnCSCVsPBPXTXCvosQdvCrgeAnOIMG5A5RwpduthaK/5
 dgsqFNLXkPHrGTLU0Z90IkTNgih0TAZ3vc7yckmnU7N+obppFg/4yDjkZxkfJOdgP9IRy3obCvt
 ikZ1m26Wtpt6hxURSSYg4Qp6ISd1BbTkaobPTHb2euW2Sfg56eBDR/2u2XOc0nvDa2ih2/Kdmir
 Q8eRFP+Dwi5XRPibzy++GMNSjsO0kgv4TEQ2BesTPKkn1RnDfCURfSZg/V/m2xkRyVz/WVD82q3
 sgu1XwTWNidKUqJVz2shEEMeAQYlMPS6ALX0XcaB8OUYwpYeHjSvUoJIfTWv5o+TCLqXNGSOfrK
 lUIJ8V0rFHl1qhp1oLhtPdCb8ZKAkY/ARILTXs/JMQG1WhVmbITp3Ds4A9o4J5q5K5upfE+4URP
 yrPNsdssu2s2n9mhltA==
X-Proofpoint-GUID: i-tWqe5cblnPEW_HXeswspYAshEjGrKU
X-Proofpoint-ORIG-GUID: -xDvIwhHUkp1JqeTApZfCHZ72uhOJmMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020054



On 11/1/26 12:36 PM, Jarkko Sakkinen wrote:
> On Sun, Nov 01, 2026 at 09:22:30AM +0800, 铮 wrote:
>> Hi Peter, Jarkko and Jason,
> 
> Adding Stefan.
> 
>>
>> I observed a task hang in vtpm_proxy_fops_release() while fuzzing the
>> vTPM proxy with syzkaller. I reproduced it on Linux 7.3.0: the campaign
>> observed the hang 4 times; replaying the stored sequence reproduced it
>> once in an automated replay and three times in manual replays. In every
>> case a process is blocked for 143+ seconds in
>> vtpm_proxy_fops_release() -> vtpm_proxy_work_stop() -> flush_work(),
>> while at the same time the sysrq-t dumps show a chip-register work
>> (vtpm_proxy_work -> tpm_chip_register() -> tpm_chip_start() ->
>> vtpm_proxy_request_locality()) running on the tpm-vtpm workqueue plus a
>> backlog of further queued chip-register works. Which queued work the
>> blocked release is waiting for is unconfirmed. All logs end while the
>> task is still blocked, so I cannot say how long the stall ultimately
>> lasts; I am not claiming a permanent deadlock.
>>
>> Environment
>> -----------
>> - Kernel: 7.3.0-kernsight-kasan #1 SMP PREEMPT_DYNAMIC, built 2026-10-20,
>>    x86_64. Vanilla 7.3.0 source tarball (sha256
>>    87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f004953),
>>    built with KASAN/KCOV. No TPM changes were made for this testing
>>    (drivers/char/tpm/ matches vanilla apart from build artifacts).
>> - Guest: QEMU/KVM, 4 vCPU, 6 GiB, 8 scratch virtio disks, 2 NVDIMM/pmem
>>    devices, 2 NUMA nodes (the syzkaller standard environment). A fresh VM
>>    was used for every reproduction run.
>> - Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+
>>    (2026-09-18). The "+" denotes local KernSight integration changes
>>    (seed ordering/state feedback: pkg/kernsight, prog/kernsight_*,
>>    syz-manager/kernsight_*, pkg/execbackend, snapshot support in vm/qemu).
>>    They do not change the TPM syscall descriptions or the executor
>>    semantics.
>> - Reproduction: the campaign observed the hang 4 times; replaying the
>>    stored programs reproduced it once in an automated replay, three
>>    times as a single 50-program sequence, and once with the two-step
>>    form above (one of the manual replays is captured only as a sysrq-t
>>    dump). Four runs on a bare fresh VM with a *different kernel command

Four runs out of four?

>>    line* and without the scratch/pmem/NUMA layout recorded no hang --

Does this mean that the 'scratch/pemem/NUMA layout' is required to 
reproduce the hang?

>>    since the command line differs as well, these runs cannot attribute
>>    the effect to the device layout.

What is 'device layout'?

