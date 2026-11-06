Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992302;
	b=n5li6fFyGJKKqK7/AcaRA2n6DZzgFVyZCv3KuO5Jqma/TLYEx0EqVPSDW4NtwI0iIB/Q
	 mPPv6+S+6rFvi3ZpKfoJxqP3MS+NS2WG7bxb9tDiQmrhAKL6hirnjmWGAYyRBhYit9/bV
	 vYQv39aDE0ZWpTaZZlUf6PFCZGnWhZpGD11rZrpM4w2hBWcMe3c5sEkenS4eNQv8AOLeD
	 bqFckMPrycL9afvqj9510xVoKb8az1/iqEGnc0QRLtfBENa0W1sLZfMPjlpnUWJzPCnbu
	 uX5YL0lUtEnM0rBrTdbTirM9InrfIx+4ug1oG+/lHoJMlUb3vucMBZaua3JYPxlWTcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iJ3ILXBb2WiRD6Y0qOdyLy7aeo25WK+LpFUCy2w6CHs=;
	b=q6+EGNm20tiTsDSipO9j22pfoXG8sTAAORwOUWhTYRsduJmxbWdUTM4AMVhqBE8+Azhh
	 Cd9HIkX8qEPM+E2XjFFuWPtL9pokSfEjBUPCSz3lc7koz3xFXq5pRjzAWO9kh5WHMUNxT
	 Hlvvq4TZ/6e9fL/D9VRwxcxFFEPfl9KMRefWKnTBzxWxlGH22pJ2L6J1NPPcQFNrvCKfL
	 xhyXNa6dH3XDQKwKwDlvMvcd3YhjYFjNvN3eb1/N51zakaKZb5xyfcpz9AXzRHLsWx0ol
	 J2Uoj0IeRD+8qgbzOL1O5SNwp+sT/leq4kwu+yV9md72XF/1OT9LK5ENoA8oGW0Ky8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L0yiS75L;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEB606A326;
	Fri,  6 Nov 2026 19:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FEEB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L0yiS75L
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IEKM03164004;
	Fri, 6 Nov 2026 19:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iJ3ILXBb2WiRD6Y0qOdyLy7aeo25WK
	+LpFUCy2w6CHs=; b=L0yiS75LUmoKnTcz1IwoXQ+LT7331IVVJNywCjP5FlmEh6
	gGwBniaZH9YhIZw+APzgbDZXkr8N25ihptSbWFu6g50sEo1Aet5RfaO37QSaokOB
	1VtNdAa1mgr/fOuuRL1pkhg/sDXHU2HXMOkopArdHobrre9H6QfxMhney0reAijv
	6ZmQlh8XjnhSXwFvhSik/OBR1ppYgXMNup2MzxM5DECjzIzydkztJU8Rr1PhdfnA
	xsoG1vpXl0S1XsvZIA75nCV7xgh5TjOfAlVI+qRLf0OvwXCCtJZQJv2ugxnj6xdH
	b6N/xUM3z00osmEHLGX5jv665DRxzN142z9uq8IA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r97a14-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 19:11:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6I4ufn3799799;
	Fri, 6 Nov 2026 19:11:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9muska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 19:11:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6JBaoS29360858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 19:11:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0571358043;
	Fri,  6 Nov 2026 19:11:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C09E58053;
	Fri,  6 Nov 2026 19:11:35 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 19:11:35 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------Syx5W06y7a1cQ4mP5qbOQP80"
Message-ID: <012799b9-aa35-4990-86df-23b012ab94e6@linux.ibm.com>
Date: Fri, 6 Nov 2026 14:11:34 -0500
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aee266a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=D29xYjkRxZuJNa9kVpMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FyPcNnP9kskpo84z5W0A:9
 a=B2y7HmGcmWMA:10
X-Proofpoint-ORIG-GUID: wgK6YaRDnKBeL00ifK7hyqLbJINxyu2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfX9EdpSQFTs1hj
 T3miGLYH9QVx3XHwbBIpOaScE+hjPW6trWasmCrma6LJrU75HT1Tklr9zsEC4NSGHkBXYYO81kW
 XLqv62MJtoOeGdEN8g6QkiiOdWWrk5+4XPAH2ZpCjS+XkHNlDQKhJ5fio40RTst3p5WKoShfEW+
 WzPIs4C0Y3x9YT45VSSLpOgtW3p1tXQ0lBfX4atD8G+403gZi+AEg0058CsyMHLQp3BkIPnMlsU
 oFG+c7yBsvvX3D2t5VSfhHQhHJp7fwk51U8kIx7ve7UP/zPcLoqfSOUwIMKCEeMqrzZBBtVEocK
 0ULCQvDuYymobwDfd9q2lO6KFMlrWcCPxrubvehQ8+GYC5YYMQs3F9AZ+f6hkG5hFH9YJiUJrgo
 l58uigfu4Jy6phEs2f1mBcu2ALyvmIFy0wK6iiU2trGlWVqR3h8Jd2pwXfn7VlAbIe+zkxmvs3W
 2b+V5sIV9zaRklcPjFQ==
X-Proofpoint-GUID: rTX19c9zGaFxucDB6mLDnafeMSV7_ZQd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXwzCS+C2SsVRC
 N1JcBanjjw718OnOLMhWQ8KGsm8gv4xmRbl02eUV91k3lCVCyCKG9N1OgaPGveieso2ka5kIO2W
 if9YKZxygWaqi1Z60cR0O3xCDk8xZ28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060074

This is a multi-part message in MIME format.
--------------Syx5W06y7a1cQ4mP5qbOQP80
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/1/26 12:36 PM, Jarkko Sakkinen wrote:
> On Sun, Nov 01, 2026 at 09:22:30AM +0800, 铮 wrote:
>> Hi Peter, Jarkko and Jason,
> >>
>> Question
>> --------
>> vtpm_proxy_tpm_req_canceled() already exists and the driver marks the
>> device as being torn down before flush_work(); from the captured dumps
>> I cannot tell why the wait nevertheless persists for minutes. Should
>> the release path be bounded, or should the in-flight chip-register work
>> be ended more promptly once the proxy is being torn down? I am happy to
>> test proposed patches.

I have tried to reproduce this now but cannot. The kernel fails for me 
like this when booting with the suggested QEMU command line:

[    3.224399][    T1] Timer migration: 2 hierarchy levels; 8 children 
per group; 1 crossnode level
[    3.239948][    T1] smp: Bringing up secondary CPUs ...
[    3.243980][    T1] smpboot: x86: Booting SMP configuration:
[    3.246035][    T1] .... node  #0, CPUs:      #1
[    3.252255][    T1] .... node  #1, CPUs:   #2 #3
[    0.076393][    T0] ------------[ cut here ]------------
[    0.076393][    T0] sched: CPU #2's llc-sibling CPU #0 is not on the 
same node! [node: 1 != 0]. Ignoring dependency.
[    0.076393][    T0] WARNING: arch/x86/kernel/smpboot.c:329 at 
topology_sane.isra.0+0x97/0xb0, CPU#2: swapper/2/0
[    0.076393][    T0] Modules linked in:
[    0.076393][    T0] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 
7.3.0-kernsight-kasan #1 PREEMPT(full)
[    0.076393][    T0] Hardware name: QEMU Ubuntu 26.04 PC (i440FX + 
PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[    0.076393][    T0] RIP: 0010:topology_sane.isra.0+0xa3/0xb0
[    0.076393][    T0] Code: 07 00 44 89 ef e8 ed fa 07 00 44 89 e7 89 
c3 e8 e3 fa 07 00 41 89 c0 48 8d 3d 79 4e 3e 10 41 89 d9 44 89 e9 4c 89 
fa 44 89 e6 <67> 48 0f b9 3a eb a5 66 0f 1f 44 00 00 90 90 90 90 90 90 
90 90 90
[    0.076393][    T0] RSP: 0000:ffffc900001afde0 EFLAGS: 00010092

The first thing I was going to try is whether this has something to do 
with the 'STATE_OPENED_FLAG' flag. There's one location where this is 
set and that's after the anon_inode_getfile() was called. For a server 
side device to be able to access the device, udev would have to run. 
Maybe udev does run between anon_inode_getfile() and the server side 
opens the device and the immediately closes it and resets the flag 
BEFORE current vtpm_proxy_fops_open() sets the flag and makes the client 
think that there still is an server-side app responding to requests. So, 
let's reverse the order and set the flag before the inode gets created 
and the flag can be reset - patch also as attachment:


diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c 
b/drivers/char/tpm/tpm_vtpm_proxy.c
index b81fd2a537df..245a8f959bc7 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -197,10 +197,8 @@ static __poll_t vtpm_proxy_fops_poll(struct file 
*filp, poll_table *wait)
   *
   * Called when setting up the anonymous file descriptor
   */
-static void vtpm_proxy_fops_open(struct file *filp)
+static void vtpm_proxy_fops_open(struct proxy_dev *proxy_dev)
  {
-	struct proxy_dev *proxy_dev = filp->private_data;
-
  	proxy_dev->state |= STATE_OPENED_FLAG;
  }

@@ -550,6 +548,9 @@ static struct file *vtpm_proxy_create_device(
  		goto err_delete_proxy_dev;
  	}

+	/* simulate an open() on the server side */
+	vtpm_proxy_fops_open(proxy_dev);
+
  	file = anon_inode_getfile("[vtpms]", &vtpm_proxy_fops, proxy_dev,
  				  O_RDWR);
  	if (IS_ERR(file)) {
@@ -558,8 +559,6 @@ static struct file *vtpm_proxy_create_device(
  	}

  	/* from now on we can unwind with put_unused_fd() + fput() */
-	/* simulate an open() on the server side */
-	vtpm_proxy_fops_open(file);

  	if (proxy_dev->flags & VTPM_PROXY_FLAG_TPM2)
  		proxy_dev->chip->flags |= TPM_CHIP_FLAG_TPM2;




--------------Syx5W06y7a1cQ4mP5qbOQP80
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tpm-tpm_vtpm_proxy-Set-STATE_OPENED_FLAG-before-inod.patch"
Content-Disposition: attachment;
 filename*0="0001-tpm-tpm_vtpm_proxy-Set-STATE_OPENED_FLAG-before-inod.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkNmMyN2IwMDVkZmNhMzU2ZmEzMzUzMDY5NmUyMTI1MWQ5MTQyMWI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4Lmli
bS5jb20+CkRhdGU6IEZyaSwgNiBOb3YgMjAyNiAxMjo0Mzo1NiAtMDYwMApTdWJqZWN0OiBb
UEFUQ0hdIHRwbTogdHBtX3Z0cG1fcHJveHk6IFNldCBTVEFURV9PUEVORURfRkxBRyBiZWZv
cmUgaW5vZGUgaXMKIGNyZWF0ZWQKClRoZSBzZXJ2ZXItc2lkZSBpbm9kZSBpcyBjdXJyZW50
bHkgY3JlYXRlZCBiZWZvcmUgdGhlIFNUQVRFX09QRU5FRF9GTEFHCmlzIHNldC4gVGhlb3Jl
dGljYWxseSwgYW4gYXBwbGljYXRpb24gY291bGQgb3BlbiB0aGUgc2VydmVyIHNpZGUgZmls
ZQphZnRlciBhbm9uX2lub2RlX2dldGZpbGUoKSByYW4gaW4gdGhlIGRyaXZlciAoYW5kIHVk
ZXYgY3JlYXRlZCB0aGUKZGV2aWNlKSBhbmQgdGhlbiBpbW1lZGlhdGVseSBjbG9zZSB0aGUg
ZmlsZSBkZXNjcmlwdG9yIGFuZCBjbGVhciB0aGUgc3RpbGwKdW5zZXQgU1RBVEVfT1BFTkVE
X0ZMQUcgdGhhdCBjdXJyZW50bHkgZ2V0cyBzZXQgYWZ0ZXIKYW5vbl9pbm9kZV9nZXRmaWxl
KCkuIFRoZXJlZm9yZSwgcmV2ZXJzZSB0aGUgb3JkZXIgc28gdGhhdCB0aGUgZmxhZwpuZXZl
ciBnZXRzIHNldCBhZnRlciBpdCB3YXMgYXR0ZW1wdGVkIHRvIGJlIGNsZWFyZWQuCgpJZiB0
aGUgZmxhZyBpcyBzZXQgd2hpbGUgbm8gc2VydmVyLXNpZGUgYXBwbGljYXRpb24gcmVzcG9u
ZHMgdG8gcmVxdWVzdHMsCnRoZSBjbGllbnQtc2lkZSBtYXkgd2FpdCBmb3IgYSByZXNwb25z
ZSB1bnRpbCB0aW1lb3V0LgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEJlcmdlciA8c3RlZmFu
YkBsaW51eC5pYm0uY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1fcHJveHku
YyB8IDkgKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1fcHJv
eHkuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1fcHJveHkuYwppbmRleCBiODFmZDJh
NTM3ZGYuLjI0NWE4Zjk1OWJjNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1f
dnRwbV9wcm94eS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1fcHJveHkuYwpA
QCAtMTk3LDEwICsxOTcsOCBAQCBzdGF0aWMgX19wb2xsX3QgdnRwbV9wcm94eV9mb3BzX3Bv
bGwoc3RydWN0IGZpbGUgKmZpbHAsIHBvbGxfdGFibGUgKndhaXQpCiAgKgogICogQ2FsbGVk
IHdoZW4gc2V0dGluZyB1cCB0aGUgYW5vbnltb3VzIGZpbGUgZGVzY3JpcHRvcgogICovCi1z
dGF0aWMgdm9pZCB2dHBtX3Byb3h5X2ZvcHNfb3BlbihzdHJ1Y3QgZmlsZSAqZmlscCkKK3N0
YXRpYyB2b2lkIHZ0cG1fcHJveHlfZm9wc19vcGVuKHN0cnVjdCBwcm94eV9kZXYgKnByb3h5
X2RldikKIHsKLQlzdHJ1Y3QgcHJveHlfZGV2ICpwcm94eV9kZXYgPSBmaWxwLT5wcml2YXRl
X2RhdGE7Ci0KIAlwcm94eV9kZXYtPnN0YXRlIHw9IFNUQVRFX09QRU5FRF9GTEFHOwogfQog
CkBAIC01NTAsNiArNTQ4LDkgQEAgc3RhdGljIHN0cnVjdCBmaWxlICp2dHBtX3Byb3h5X2Ny
ZWF0ZV9kZXZpY2UoCiAJCWdvdG8gZXJyX2RlbGV0ZV9wcm94eV9kZXY7CiAJfQogCisJLyog
c2ltdWxhdGUgYW4gb3BlbigpIG9uIHRoZSBzZXJ2ZXIgc2lkZSAqLworCXZ0cG1fcHJveHlf
Zm9wc19vcGVuKHByb3h5X2Rldik7CisKIAlmaWxlID0gYW5vbl9pbm9kZV9nZXRmaWxlKCJb
dnRwbXNdIiwgJnZ0cG1fcHJveHlfZm9wcywgcHJveHlfZGV2LAogCQkJCSAgT19SRFdSKTsK
IAlpZiAoSVNfRVJSKGZpbGUpKSB7CkBAIC01NTgsOCArNTU5LDYgQEAgc3RhdGljIHN0cnVj
dCBmaWxlICp2dHBtX3Byb3h5X2NyZWF0ZV9kZXZpY2UoCiAJfQogCiAJLyogZnJvbSBub3cg
b24gd2UgY2FuIHVud2luZCB3aXRoIHB1dF91bnVzZWRfZmQoKSArIGZwdXQoKSAqLwotCS8q
IHNpbXVsYXRlIGFuIG9wZW4oKSBvbiB0aGUgc2VydmVyIHNpZGUgKi8KLQl2dHBtX3Byb3h5
X2ZvcHNfb3BlbihmaWxlKTsKIAogCWlmIChwcm94eV9kZXYtPmZsYWdzICYgVlRQTV9QUk9Y
WV9GTEFHX1RQTTIpCiAJCXByb3h5X2Rldi0+Y2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxB
R19UUE0yOwotLSAKMi41Ni4wCgo=

--------------Syx5W06y7a1cQ4mP5qbOQP80--

