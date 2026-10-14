Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC274E01F1
	for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982242; cv=none; b=hdF7YsEqXI09Co1DpSqUCq07ExjtNU/f95oabR/3c+Kd+we0Hj9l0cLj89ksuoaaRrIalnIPFOCVPJwjjoQEAebNF1FXUTH4EodIwL+UlKEDqsTigxGOYbsdNOLfsDDtfzAEKGouvLBBwML9J2v+Qfu4YGbgOVL2LlsdK2J9qFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982242; c=relaxed/simple;
	bh=6Vlv8VgId7Gtelop93HYcH8WmKrEMWKinDVVyGKDOXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1Sb0yJ7rpLqwKfGMwsLdcVuNJwFFPTDTMxOjJdbaYjIA/3KeyfC7A0kmWzRtn+06i58chLpTIzZIzZU6+o0DiaU6o2H5aWXO10K95O2ozRrzjpB1Bw3R4BpEbCXXl2NGgOmMT7AvdqHIkUPb09r6V0/+MFGxCU6pupQ1ikID7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4j4W6c4kDczpTPw
	for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 20:41:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 702634049F
	for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2026 20:49:44 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwDHdB9hes9qV9Q1AA--.13100S2;
	Wed, 14 Oct 2026 13:49:43 +0100 (CET)
Message-ID: <792ab772c88d2187f684cbd02395f51dc9d28083.camel@huaweicloud.com>
Subject: Re: [PATCH v3] ima: recover number of violations after kexec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
Date: Wed, 14 Oct 2026 14:49:35 +0200
In-Reply-To: <20261013144644.134912-1-enrico.bravi@polito.it>
References: <20261013144644.134912-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHdB9hes9qV9Q1AA--.13100S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw17Zr1kGFy7Aw1rAr1kKrg_yoW8ZFyrpa
	9Igw13JF98tF92kF9rC3WUtayrWayUGryUXw4DJw1jyan3Kr1vqrnakFySgr95Gr9YkFyI
	vF98W3s3Ca1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGrPKTk8PQABs2

On Tue, 2026-10-13 at 16:46 +0200, Enrico Bravi wrote:
> When recovering the IMA measurement list after kexec(), currently, the co=
unter
> of violations is not restored. This causes a mismatch between the real nu=
mber
> of violations and the value reported by the <securityfs>/ima/violations f=
ile.
>=20
> Restore the violations counter during the IMA measurement list recovery. =
This
> mechanism does not take into account false positives. A legit all-zeros h=
ash
> is treated as a violation.
>=20
> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Closes: https://github.com/linux-integrity/linux/issues/13
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

Thanks Enrico!

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Tested-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> ---
>=20
> Changes in v3:
> - Reworked patch title and description.
> - Reworked violations number recovery mechanism to not check for false
>   positive case.
>=20
> Changes in v2:
> - Reworked patch description as suggested by Roberto.
> - Added descriptive comment as suggested by Roberto.
> - Moved from ima_algo_array[i].digest_size to ARRAY_SIZE() as suggested
>   by Roberto.
>=20
> ---
>  security/integrity/ima/ima_template.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/i=
ma/ima_template.c
> index 7034573fb41e..daa897ccaf58 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -524,6 +524,13 @@ int ima_restore_measurement_list(loff_t size, void *=
buf)
>  				ret =3D -EINVAL;
>  				break;
>  			}
> +		} else {
> +			/*
> +			 * If the template hash found in the kexec buffer is all
> +			 * zeros, record it as a violation. Note that this can
> +			 * be a false positive.
> +			 */
> +			atomic_long_inc(&ima_num_violations);
>  		}
> =20
>  		entry->pcr =3D !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
>=20
> base-commit: 1dc317438308c79cf90a6f14d3e4116347ea3716

