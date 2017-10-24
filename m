Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:38483 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdJXMiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 08:38:12 -0400
Subject: Re: [RFC][PATCH 2/2] ima: don't measure files in the TCB if Biba
 strict policy is enforced
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>
References: <20171020154138.23635-1-roberto.sassu@huawei.com>
 <20171020154138.23635-3-roberto.sassu@huawei.com>
 <1508791257.3639.211.camel@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <5045bc1d-0547-0895-9874-c837167c4b75@huawei.com>
Date: Tue, 24 Oct 2017 14:38:04 +0200
MIME-Version: 1.0
In-Reply-To: <1508791257.3639.211.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 10/23/2017 10:40 PM, Mimi Zohar wrote:
> On Fri, 2017-10-20 at 17:41 +0200, Roberto Sassu wrote:
>> The Biba strict policy prevents processes outside the TCB from modifying
>> appraised files. Then, since the integrity of those files is preserved,
>> because only processes in the TCB can write appraised files, it is not
>> necessary to measure them each time they are accessed by the TCB.
> 
> The builtin appraise_tcb appraises all files owned by root.  With this
> patch you've redefined TCB to be any currently loaded IMA policy.

Root processes are part of the TCB. Since a policy can be uploaded only
by a root process, it will be always appraised. Digital signature could
be required specifically for the POLICY_CHECK hook.


>> This solves one of the main problems of binary attestation: when a
>> modified file is accessed by the TCB, it was necessary to measure it
>> because verifiers cannot determine from the measurement list if the
>> writer belong or not to the TCB. Verifiers find an unknown digest
>> and have to consider the whole system as compromised.
>>
>> If the Biba strict policy has been selected, and appraisal is in enforce
>> mode, IMA measures files at first access, if they have a digital signature.
>> Then, for subsequent accesses, files are not measured again, unless the
>> appraisal status changes.
> 
> Signed files aren't changing, so there should only be one file
> measurement in the measurement list.  So this only affects mutable
> files.  We're going through a lot of effort to re-measure mutable
> files after they change.

If appraised files can be written only by processes in the TCB, it is
not necessary to report the new digest, after their content changes,
because their integrity is preserved. It is sufficient to correctly
update the extended attribute.

Roberto


>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   security/integrity/ima/ima_main.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 6e85ea8e2373..16c2da0e32d9 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -200,10 +200,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   			goto out;
>>   	}
>>
>> -	if (ima_integrity_policy)
>> +	if (ima_integrity_policy) {
>>   		policy_violation = ima_appraise_biba_check(file, iint,
>>   						must_appraise, &pathbuf,
>>   						&pathname, filename);
>> +		/* do not measure mutable files, if they are appraised */
>> +		if (ima_integrity_policy == BIBA_STRICT &&
>> +		    (ima_appraise & IMA_APPRAISE_ENFORCE))
>> +			if (iint && (iint->flags & IMA_APPRAISED))
>> +				action &= ~IMA_MEASURE;
>> +	}
>>   	if (violation_check)
>>   		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
>>   					 &pathbuf, &pathname);
>> @@ -246,9 +252,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
>>   		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
>>
>> -	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK))
>> +	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
>>   		rc = ima_appraise_measurement(func, iint, file, pathname,
>>   					      xattr_value, xattr_len, opened);
>> +		if (!rc && ima_integrity_policy == BIBA_STRICT &&
>> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
>> +			iint->flags &= ~IMA_MEASURE;
>> +			if (!(iint->flags & IMA_DIGSIG))
>> +				action &= ~IMA_MEASURE;
>> +		}
>> +	}
>>   	if (action & IMA_MEASURE)
>>   		ima_store_measurement(iint, file, pathname,
>>   				      xattr_value, xattr_len, pcr);
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
