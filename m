Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA223A9BD
	for <linux-integrity@vger.kernel.org>; Tue, 11 Aug 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413470; cv=none; b=BSPWiR/rJq+5kOKm4tJ2Y9wsJH7NeJIKWqqD1NwvGDRRU4iLn1cNZLXZrw7AzQ2PFKHn1EuGrslvcN4VbEIrccX5Sr2dMgrnzLIjQO77s65wROSAkKQB2oiatHB5ukH560q3qULMh9wkSRBxmsbzr8J0gYFvTFUh0cNJgWaI1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413470; c=relaxed/simple;
	bh=v1SfX5Mvs7zvMZuDnO3b+U9BZV3fL0GBZv0nWN50PUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z4pWgDYJWOm8EyDNMHKU+8HIbomw2zXwaEMlhXLDeA34r+Sn442cOZJnXkfvpIioaITGxh7tCv0/CVw4UZ7TsiaNqu/uzdLUZsGaBu6w/IO1FydsogVBhF+9z6T7wYHQFrqwbLSiC1WJgZZBRLiiOfF7RqZsuynL39UZJVwNH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hJvL85VwTzsj4S
	for <linux-integrity@vger.kernel.org>; Tue, 11 Aug 2026 09:34:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 413624056C
	for <linux-integrity@vger.kernel.org>; Tue, 11 Aug 2026 09:40:42 +0800 (CST)
Received: from [10.153.245.119] (unknown [10.153.245.119])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwCHUNmVfXpqZcH7AA--.54656S2;
	Tue, 11 Aug 2026 02:40:41 +0100 (CET)
Message-ID: <469ed5e1-55dd-4aab-b374-2ac00e3ce9ab@huaweicloud.com>
Date: Tue, 11 Aug 2026 09:40:36 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Daniel Hodges <git@danielhodges.dev>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20260804200734.2415524-1-zohar@linux.ibm.com>
 <897aa15c24fd14a30392890ffeb5aac96409f31a.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <897aa15c24fd14a30392890ffeb5aac96409f31a.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwCHUNmVfXpqZcH7AA--.54656S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF13Ar1xWr45WFyxJFyDtrb_yoWxAw18pF
	W5WayDGr4DJFWUGF9ayan5Z34F9ay0yF10yrWUW34SyFn2vrnaqFWIkw18uF98Cr4UGw1F
	qr4I9wnruw4Sv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBGp5eOQ+8gADsE

On 8/7/2026 7:42 PM, Roberto Sassu wrote:
> On Tue, 2026-08-04 at 16:07 -0400, Mimi Zohar wrote:
>> From: Daniel Hodges <git@danielhodges.dev>
>>
>> The crypto_shash_update() and crypto_shash_final() functions can fail
>> and return error codes, but their return values were not being checked
>> in several places in security/integrity/evm/evm_crypto.c:
>>
>> - hmac_add_misc() ignored returns from crypto_shash_update() and
>>    crypto_shash_final()
>> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
>> - evm_init_hmac() ignored returns from crypto_shash_update()
>>
>> If these hash operations fail silently, the resulting HMAC could be
>> invalid or incomplete, which could weaken the integrity verification
>> security that EVM provides.
>>
>> This patch converts hmac_add_misc() from void to int return type and
>> adds proper error checking and propagation for all crypto_shash_*
>> function calls. All callers are updated to handle the new return values.
>> Additionally, error messages are logged when cryptographic operations
>> fail to provide visibility into the failure rather than silently
>> returning error codes.
>>
>> Fixes: 66dbc325afce ("evm: re-release")
>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Looks good to me. I confirm the Reviewed-by.

We got a report from Sashiko. As it pointed out, we should not override 
the error when calling hmac_add_misc() if no xattr is present
(-ENODATA).

Roberto

> Thanks
> 
> Roberto
> 
>> Link: https://github.com/linux-integrity/linux/issues/17
>> [zohar@linux.ibm.com: fixed commit 0496fc9cdc38 merge conflict,
>> checkpatch.pl warnings]
>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>> Daniel, Roberto, please review this version of the patch.
>>
>>   security/integrity/evm/evm_crypto.c | 67 ++++++++++++++++++++++-------
>>   1 file changed, 51 insertions(+), 16 deletions(-)
>>
>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>> index 1c41af2f91a6..aef0f8f3d9d6 100644
>> --- a/security/integrity/evm/evm_crypto.c
>> +++ b/security/integrity/evm/evm_crypto.c
>> @@ -140,8 +140,8 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>>    * (Additional directory/file metadata needs to be added for more complete
>>    * protection.)
>>    */
>> -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>> -			  char type, char *digest)
>> +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>> +			 char type, char *digest)
>>   {
>>   	struct h_misc {
>>   		/*
>> @@ -156,6 +156,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>>   		gid_t gid;
>>   		umode_t mode;
>>   	} hmac_misc;
>> +	int error;
>>
>>   	memset(&hmac_misc, 0, sizeof(hmac_misc));
>>   	/* Don't include the inode or generation number in portable
>> @@ -176,14 +177,30 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>>   	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
>>   	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
>>   	hmac_misc.mode = inode->i_mode;
>> -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
>> +	error = crypto_shash_update(desc, (const u8 *)&hmac_misc,
>> +				    sizeof(hmac_misc));
>> +	if (error) {
>> +		pr_err("crypto_shash_update() failed: %d\n", error);
>> +		return error;
>> +	}
>>   	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
>> -	    type != EVM_XATTR_PORTABLE_DIGSIG)
>> -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
>> -	crypto_shash_final(desc, digest);
>> +	    type != EVM_XATTR_PORTABLE_DIGSIG) {
>> +		error = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
>> +					    UUID_SIZE);
>> +		if (error) {
>> +			pr_err("crypto_shash_update() failed: %d\n", error);
>> +			return error;
>> +		}
>> +	}
>> +	error = crypto_shash_final(desc, digest);
>> +	if (error) {
>> +		pr_err("crypto_shash_final() failed: %d\n", error);
>> +		return error;
>> +	}
>>
>>   	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
>>   		 (int)sizeof(struct h_misc), &hmac_misc);
>> +	return 0;
>>   }
>>
>>   /*
>> @@ -267,9 +284,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>
>>   		if ((req_xattr_name && req_xattr_value)
>>   		    && !strcmp(xattr->name, req_xattr_name)) {
>> -			error = 0;
>> -			crypto_shash_update(desc, (const u8 *)req_xattr_value,
>> -					     req_xattr_value_len);
>> +			error = crypto_shash_update(desc,
>> +						    (const u8 *)req_xattr_value,
>> +						    req_xattr_value_len);
>> +			if (error) {
>> +				pr_err("crypto_shash_update() failed: %d\n",
>> +				       error);
>> +				goto out;
>> +			}
>>   			if (is_ima)
>>   				ima_present = true;
>>
>> @@ -293,15 +315,21 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>   			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
>>   				 dentry->d_name.name, xattr->name, size,
>>   				 user_space_size);
>> -		error = 0;
>>   		xattr_size = size;
>> -		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
>> +		error = crypto_shash_update(desc, (const u8 *)xattr_value,
>> +					    xattr_size);
>> +		if (error) {
>> +			pr_err("crypto_shash_update() failed: %d\n", error);
>> +			goto out;
>> +		}
>>   		if (is_ima)
>>   			ima_present = true;
>>
>>   		dump_security_xattr(xattr->name, xattr_value, xattr_size);
>>   	}
>> -	hmac_add_misc(desc, inode, type, data->digest);
>> +	error = hmac_add_misc(desc, inode, type, data->digest);
>> +	if (error)
>> +		goto out;
>>
>>   	if (inode != d_backing_inode(dentry) && iint) {
>>   		if (IS_I_VERSION(inode))
>> @@ -409,6 +437,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
>>   	struct shash_desc *desc;
>>   	const struct xattr *xattr;
>>   	struct xattr_list *xattr_entry;
>> +	int error;
>>
>>   	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
>>   	if (IS_ERR(desc)) {
>> @@ -423,14 +452,20 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
>>   				   XATTR_SECURITY_PREFIX_LEN, xattr->name) != 0)
>>   				continue;
>>
>> -			crypto_shash_update(desc, xattr->value,
>> -					    xattr->value_len);
>> +			error = crypto_shash_update(desc, xattr->value,
>> +						    xattr->value_len);
>> +			if (error) {
>> +				pr_err("crypto_shash_update() failed: %d\n",
>> +				       error);
>> +				goto out;
>> +			}
>>   		}
>>   	}
>>
>> -	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>> +	error = hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>> +out:
>>   	kfree(desc);
>> -	return 0;
>> +	return error;
>>   }
>>
>>   /*
>> --
>> 2.55.0
>>
> 

