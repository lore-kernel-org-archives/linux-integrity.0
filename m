Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8F25B09E
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104173; cv=none; b=DvfdN4GS0OY9AgXM6gGX5BzfoAak+JjktRX2Fn8p342kaNe/CEVXF4V6qQmytw+tHPOSPZefDr+gyAI07VDkizzlEC9EUFamP+LQr4ChCdzdJLktyz/3GyQDdyx2uFPQi/lAt/IaxrOK/UFGXum9wiSHixrghJUsAVkPbJl4vN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104173; c=relaxed/simple;
	bh=yYGRwNpzeT/SeEaZH/6WMzRdwpj3rJDKMzyYGueU5is=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orP7fpOKiesPvsM/ADMr65AraDfZhvHTn8xJVbpyvUhT36FWLqVjQXDSui2VPtAENN50+Mm/ZwVHyvoGLjK/d9aIr+VadVRUKRDO8TXFLdc7kOG7axh493QwYoSOKMj75dhGS9ZYnNFK8u7dTgmWXbvhipzwwMaejY43rYanAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hGht15vN4z1HBtF
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 19:35:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B4B9340560
	for <linux-integrity@vger.kernel.org>; Fri,  7 Aug 2026 19:42:33 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwC3C1GjxHVq083CAA--.7818S2;
	Fri, 07 Aug 2026 12:42:33 +0100 (CET)
Message-ID: <897aa15c24fd14a30392890ffeb5aac96409f31a.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Daniel Hodges <git@danielhodges.dev>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 07 Aug 2026 13:42:24 +0200
In-Reply-To: <20260804200734.2415524-1-zohar@linux.ibm.com>
References: <20260804200734.2415524-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC3C1GjxHVq083CAA--.7818S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr15CFyDCrWfCw4rXr1rXrb_yoWxGrWDpF
	W5WayDGrWDJa1UGF9aya18Z34F9ay0yF42yryUW34SyFn7Xr1IqF4Ikw18uFy5Gr1DJw4Y
	qa1S9w1Duw4av3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGp1hG0TrQACsd

On Tue, 2026-08-04 at 16:07 -0400, Mimi Zohar wrote:
> From: Daniel Hodges <git@danielhodges.dev>
>=20
> The crypto_shash_update() and crypto_shash_final() functions can fail
> and return error codes, but their return values were not being checked
> in several places in security/integrity/evm/evm_crypto.c:
>=20
> - hmac_add_misc() ignored returns from crypto_shash_update() and
>   crypto_shash_final()
> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> - evm_init_hmac() ignored returns from crypto_shash_update()
>=20
> If these hash operations fail silently, the resulting HMAC could be
> invalid or incomplete, which could weaken the integrity verification
> security that EVM provides.
>=20
> This patch converts hmac_add_misc() from void to int return type and
> adds proper error checking and propagation for all crypto_shash_*
> function calls. All callers are updated to handle the new return values.
> Additionally, error messages are logged when cryptographic operations
> fail to provide visibility into the failure rather than silently
> returning error codes.
>=20
> Fixes: 66dbc325afce ("evm: re-release")
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Looks good to me. I confirm the Reviewed-by.

Thanks

Roberto

> Link: https://github.com/linux-integrity/linux/issues/17
> [zohar@linux.ibm.com: fixed commit 0496fc9cdc38 merge conflict,
> checkpatch.pl warnings]
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Daniel, Roberto, please review this version of the patch.
>=20
>  security/integrity/evm/evm_crypto.c | 67 ++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 16 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index 1c41af2f91a6..aef0f8f3d9d6 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -140,8 +140,8 @@ static struct shash_desc *init_desc(char type, uint8_=
t hash_algo)
>   * (Additional directory/file metadata needs to be added for more comple=
te
>   * protection.)
>   */
> -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> -			  char type, char *digest)
> +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> +			 char type, char *digest)
>  {
>  	struct h_misc {
>  		/*
> @@ -156,6 +156,7 @@ static void hmac_add_misc(struct shash_desc *desc, st=
ruct inode *inode,
>  		gid_t gid;
>  		umode_t mode;
>  	} hmac_misc;
> +	int error;
>=20
>  	memset(&hmac_misc, 0, sizeof(hmac_misc));
>  	/* Don't include the inode or generation number in portable
> @@ -176,14 +177,30 @@ static void hmac_add_misc(struct shash_desc *desc, =
struct inode *inode,
>  	hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
>  	hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);
>  	hmac_misc.mode =3D inode->i_mode;
> -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> +	error =3D crypto_shash_update(desc, (const u8 *)&hmac_misc,
> +				    sizeof(hmac_misc));
> +	if (error) {
> +		pr_err("crypto_shash_update() failed: %d\n", error);
> +		return error;
> +	}
>  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> -	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
> -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> -	crypto_shash_final(desc, digest);
> +	    type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> +		error =3D crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
> +					    UUID_SIZE);
> +		if (error) {
> +			pr_err("crypto_shash_update() failed: %d\n", error);
> +			return error;
> +		}
> +	}
> +	error =3D crypto_shash_final(desc, digest);
> +	if (error) {
> +		pr_err("crypto_shash_final() failed: %d\n", error);
> +		return error;
> +	}
>=20
>  	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
>  		 (int)sizeof(struct h_misc), &hmac_misc);
> +	return 0;
>  }
>=20
>  /*
> @@ -267,9 +284,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dent=
ry,
>=20
>  		if ((req_xattr_name && req_xattr_value)
>  		    && !strcmp(xattr->name, req_xattr_name)) {
> -			error =3D 0;
> -			crypto_shash_update(desc, (const u8 *)req_xattr_value,
> -					     req_xattr_value_len);
> +			error =3D crypto_shash_update(desc,
> +						    (const u8 *)req_xattr_value,
> +						    req_xattr_value_len);
> +			if (error) {
> +				pr_err("crypto_shash_update() failed: %d\n",
> +				       error);
> +				goto out;
> +			}
>  			if (is_ima)
>  				ima_present =3D true;
>=20
> @@ -293,15 +315,21 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
>  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
>  				 dentry->d_name.name, xattr->name, size,
>  				 user_space_size);
> -		error =3D 0;
>  		xattr_size =3D size;
> -		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
> +		error =3D crypto_shash_update(desc, (const u8 *)xattr_value,
> +					    xattr_size);
> +		if (error) {
> +			pr_err("crypto_shash_update() failed: %d\n", error);
> +			goto out;
> +		}
>  		if (is_ima)
>  			ima_present =3D true;
>=20
>  		dump_security_xattr(xattr->name, xattr_value, xattr_size);
>  	}
> -	hmac_add_misc(desc, inode, type, data->digest);
> +	error =3D hmac_add_misc(desc, inode, type, data->digest);
> +	if (error)
> +		goto out;
>=20
>  	if (inode !=3D d_backing_inode(dentry) && iint) {
>  		if (IS_I_VERSION(inode))
> @@ -409,6 +437,7 @@ int evm_init_hmac(struct inode *inode, const struct x=
attr *xattrs,
>  	struct shash_desc *desc;
>  	const struct xattr *xattr;
>  	struct xattr_list *xattr_entry;
> +	int error;
>=20
>  	desc =3D init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
>  	if (IS_ERR(desc)) {
> @@ -423,14 +452,20 @@ int evm_init_hmac(struct inode *inode, const struct=
 xattr *xattrs,
>  				   XATTR_SECURITY_PREFIX_LEN, xattr->name) !=3D 0)
>  				continue;
>=20
> -			crypto_shash_update(desc, xattr->value,
> -					    xattr->value_len);
> +			error =3D crypto_shash_update(desc, xattr->value,
> +						    xattr->value_len);
> +			if (error) {
> +				pr_err("crypto_shash_update() failed: %d\n",
> +				       error);
> +				goto out;
> +			}
>  		}
>  	}
>=20
> -	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +	error =3D hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +out:
>  	kfree(desc);
> -	return 0;
> +	return error;
>  }
>=20
>  /*
> --
> 2.55.0
>=20

