Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261D4BD344
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547658; cv=none; b=O25i02I8FNoiq/kkKJ+HrBCunBEFCiZHriOw3yeXOFLwbEx58S7SB8o1hG/sDUSoym4GKAXwaC7LzBBQTgfzNvptIfMHvBP2JQ1Gl90xDj0LWEiDFruqEFoB4Ej4ATDo5a5knIPUU+g+k6V7g3HPOhFv1JUwt3uH7F1jOCyeCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547658; c=relaxed/simple;
	bh=vTsF4GeGsAiBik7twjliwWCsHsfanVFaOWegemv1514=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGuKIe8GJ2fijWPxvbcvEzXCg7BO68uciREJRYYdSXYBFniTeV/o1hwQ8csnYnwWfbMSVVGAtTrzSZWuR7OffovxOPVx1MJrrXUBhx42ANu2p+ye2frYfZ3aqPQE2d4WpDKEw0YZmG5DFgLvsw2qO3f/+IbFrSiNZiEUj6GQOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4j1QQD3XjyzpV26
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 19:59:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DE07540559
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 20:07:25 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwAXHq722Mhqcp6+AQ--.20165S2;
	Fri, 09 Oct 2026 13:07:25 +0100 (CET)
Message-ID: <ff5d11a80c91f4079de847777cf6b70cf09a7197.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima: correctly recover number of violations after
 kexec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
Date: Fri, 09 Oct 2026 14:07:15 +0200
In-Reply-To: <20260706124454.165706-1-enrico.bravi@polito.it>
References: <20260706124454.165706-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXHq722Mhqcp6+AQ--.20165S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW7KryDCFW3Zr1rAF1rXrb_yoW5tw43pa
	90gr13KFykJFyIkrn3A3WUArWrW3yrtFWUGw1DGw15Ar13tr1Fkr1rCFySvrWkGryrXFWI
	qFyqgrs3Ca1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGrIkZ4jcQAAs4

On Mon, 2026-07-06 at 14:44 +0200, Enrico Bravi wrote:
> When recovering the IMA measurement list after kexec(), currently, the co=
unter
> of violations is not restored. This lack causes a mismatch between the re=
al
> number of violations and the value reported by the <securityfs>/ima/viola=
tions
> file.
>=20
> Restore the violations counter during the IMA measurement list recovery. =
To
> verify if a measurement corresponds to a violation, check if the correspo=
nding
> recalculated template data hash is all zeros as read from the kexec buffe=
r.
> This check permits avoiding false positives, but it does not account for =
false
> negatives. If the template data hash results in all zeros, it is not coun=
ted
> as a violation even if it could be.

Sorry for the delay, Enrico.

Yes, I think the patch is ok as it is. However, after giving another
thought, neither approach is perfect, in one case (current) we count
more, in the other case (this patch) we count less.

It is a counter mostly for debugging, it is not used for remote
attestation. Maybe, we just increment the counter on zeros to keep it
simple (please say in a comment that it is not perfect), and we
finalize like this.

What do you think?

Roberto

> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Closes: https://github.com/linux-integrity/linux/issues/13
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> ---
>=20
> Changes in v2:
> - Reworked patch description as suggested by Roberto.
> - Added descriptive comment as suggested by Roberto.
> - Moved from ima_algo_array[i].digest_size to ARRAY_SIZE() as suggested
>   by Roberto.
>=20
> ---
>  security/integrity/ima/ima_template.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/i=
ma/ima_template.c
> index 7034573fb41e..f7749c8499dd 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -430,6 +430,7 @@ int ima_restore_measurement_list(loff_t size, void *b=
uf)
>  	DECLARE_BITMAP(hdr_mask, HDR__LAST);
>  	unsigned long count =3D 0;
>  	int ret =3D 0;
> +	int i;
> =20
>  	if (!buf || size < sizeof(*khdr))
>  		return 0;
> @@ -515,15 +516,27 @@ int ima_restore_measurement_list(loff_t size, void =
*buf)
>  		if (ret < 0)
>  			break;
> =20
> -		if (memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero))) {
> -			ret =3D ima_calc_field_array_hash(
> -						&entry->template_data[0],
> +		ret =3D ima_calc_field_array_hash(&entry->template_data[0],
>  						entry);
> -			if (ret < 0) {
> -				pr_err("cannot calculate template digest\n");
> -				ret =3D -EINVAL;
> -				break;
> +		if (ret < 0) {
> +			pr_err("cannot calculate template digest\n");
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		/*
> +		 * Check if the current measurement is a violation as reported
> +		 * in the kexec buffer. In case it is, revert the effect of
> +		 * ima_calc_field_array_hash(), setting all the calculated
> +		 * digests to zero, and update the violations counter.
> +		 */
> +		if (!memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero)) &&
> +		    memcmp(entry->digests[ima_sha1_idx].digest, zero, sizeof(zero))) {
> +			for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
> +				memset(entry->digests[i].digest, 0,
> +				       ARRAY_SIZE(entry->digests[i].digest));
>  			}
> +			atomic_long_inc(&ima_htable.violations);
>  		}
> =20
>  		entry->pcr =3D !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
>=20
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6

