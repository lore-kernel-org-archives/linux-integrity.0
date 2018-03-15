Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751824AbeCOADq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 20:03:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2ENx51a137532
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 20:03:46 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gqcn3agad-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 20:03:45 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 18:03:45 -0600
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com> <20180314202020.3794-4-bauerman@linux.vnet.ibm.com> <20180314214045.GC14289@mail.hallyn.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
In-reply-to: <20180314214045.GC14289@mail.hallyn.com>
Date: Wed, 14 Mar 2018 21:03:36 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efkmjjc7.fsf@morokweng.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Hello Serge,

Thanks for quickly reviewing these patches!

Serge E. Hallyn <serge@hallyn.com> writes:

> Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  	}
>>  
>>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
>> -	if ((status != INTEGRITY_PASS) &&
>> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
>> -	    (status != INTEGRITY_UNKNOWN)) {
>> -		if ((status == INTEGRITY_NOLABEL)
>> -		    || (status == INTEGRITY_NOXATTRS))
>> -			cause = "missing-HMAC";
>> -		else if (status == INTEGRITY_FAIL)
>> -			cause = "invalid-HMAC";
>> +	switch (status) {
>> +	case INTEGRITY_PASS:
>> +	case INTEGRITY_PASS_IMMUTABLE:
>> +	case INTEGRITY_UNKNOWN:
>
> Wouldn't it be more future-proof to replace this with a 'default', or
> to at least add a "default: BUG()" to catch new status values?

I agree. I like the "default: BUG()" option.

>> +		break;
>> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>> +		cause = "missing-HMAC";
>> +		goto out;
>> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>> +		cause = "invalid-HMAC";
>>  		goto out;
>>  	}
>> +
>>  	switch (xattr_value->type) {
>>  	case IMA_XATTR_DIGEST_NG:
>>  		/* first byte contains algorithm id */
>> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else if (status != INTEGRITY_PASS) {
>> +		/* Fix mode, but don't replace file signatures. */
>>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>>  		    (!xattr_value ||
>>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>>  			if (!ima_fix_xattr(dentry, iint))
>>  				status = INTEGRITY_PASS;
>> -		} else if ((inode->i_size == 0) &&
>> -			   (iint->flags & IMA_NEW_FILE) &&
>> -			   (xattr_value &&
>> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
>> +		}
>> +
>> +		/* Permit new files with file signatures, but without data. */
>> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>
> This may be correct, but it's not identical to what you're replacing.
> Since in either case you're setting status to INTEGRITY_PASS the final
> result is the same, but with a few extra possible steps.  Not sure
> whether that matters.

Good point. I'll have to defer this one to Mimi though.

>
>> +		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
>>  			status = INTEGRITY_PASS;
>>  		}
>> +
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else {


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
