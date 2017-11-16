Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:44559 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932671AbdKPJXb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 04:23:31 -0500
Subject: Re: IMA appraisal master plan?
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <james.l.morris@oracle.com>
CC: Patrick Ohly <patrick.ohly@intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20171107151742.25122-1-mjg59@google.com>
 <1510766803.5979.17.camel@intel.com>
 <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
 <1510770065.5979.21.camel@intel.com>
 <alpine.LFD.2.20.1711161101360.27132@localhost>
 <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
 <1510798382.3711.389.camel@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
Date: Thu, 16 Nov 2017 10:23:22 +0100
MIME-Version: 1.0
In-Reply-To: <1510798382.3711.389.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/16/2017 3:13 AM, Mimi Zohar wrote:
> On Wed, 2017-11-15 at 16:05 -0800, Matthew Garrett wrote:
>> On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morris@oracle.com> wrote:
>>> On Wed, 15 Nov 2017, Patrick Ohly wrote:
>>>
>>>> I have some experience with SMACK, but not with Apparmor. At least with
>>>> SMACK the problem is that the LSM depends on integrity protection of
>>>> the xattrs, but the integrity protection itself depends on the LSM, so
>>>> there's a cycle. An attacker can much too easily make offline changes
>>>> which then defeat whatever IMA policy the system might be using.
>>>
>>> Isn't this what EVM is supposed to mitigate?

With the default appraisal policy, it can't. IMA determines if a file
must be appraised depending on metadata whose integrity has not been
verified yet. A root process is able to load appraised files with
i_uid = 0 and files with missing/invalid HMAC and i_uid != 0, at the
same time.

Me and Matthew are considering policies based on subject criteria rather
than object criteria. The integrity of a process can be guaranteed
because everything that process reads or executes will be appraised.


>> If the path to the loading of the LSM policy isn't fully appraised,
>> then it can be modified offline in order to permit modification of the
>> EVM xattrs at runtime, at which point the kernel will happily generate
>> a new HMAC.
> 
> Matthew, your explanation is a valid problem, but different than what
> Patrick was describing.  Your description is of protecting the LSM
> policy itself.  Patrick, correct me if I'm wrong, was describing the
> situation where the LSM labels are modified, causing the file being
> appraised not to be in the IMA policy.

If the LSM policy is parsed in user space and then uploaded by the
kernel, an offline attack would be to modify the file i_uid to be != 0,
so that any policy can be loaded. Unless, as Matthew mentioned, the
policy is included in a signed initial ram disk.


> To solve Matthew's problem requires modifying the LSMs so that instead
> of userspace reading the policy, processing it and loading it into the
> kernel, the LSMs read the policy file directly.

I agree. The same applies to digest lists, IMA parses them directly.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
