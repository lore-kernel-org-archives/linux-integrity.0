Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:37057 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdJBOxk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 10:53:40 -0400
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>
CC: <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
References: <20170927221653.11219-1-mjg59@google.com>
 <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com>
 <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <05dd27bc-753e-c2c0-88ce-8654f04ad3d5@huawei.com>
Date: Mon, 2 Oct 2017 16:53:26 +0200
MIME-Version: 1.0
In-Reply-To: <1506711726.5691.141.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/29/2017 9:02 PM, Mimi Zohar wrote:
> On Fri, 2017-09-29 at 11:09 -0700, Matthew Garrett wrote:
>> On Thu, Sep 28, 2017 at 5:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>> Without the inode included in the HMAC calculation, the same file
>>> could exist as a different file name on the same file system.  No need
>>> for the two files to be on different file systems.
>>
>> But if I create a hardlink to an existing file then I get the same
>> file with the same inode number and two different names on the same
>> filesystem, and so security.evm would still match?
> 
> True, with a hard link that would be the case, but by the same file, I
> meant a copy of the original file, not a hard link to the file.
> 
>>>> One of the reasons we're interested in allowing the use of signatures
>>>> rather than HMACs is to avoid the case where a machine being
>>>> compromised would allow an attacker to obtain the symmetric key and
>>>> drop new appropriately HMACed binaries on the system that would
>>>> persist even if the kernel was updated to fix the vulnerability.
>>>
>>> Assuming you're using a trusted key (TPM based key) to encrypt/decrypt
>>> the EVM key (trusted key), then such an attack would require root
>>> privileges with the ability to read kernel memory.  The EVM key is
>>> never exposed to userspace in the clear.
>>
>> That's a case that we need to be worried about. Trusted boot means we
>> can ensure that a system boots an updated kernel, but if the attacker
>> has been able to drop a modified sshd with a valid hmac onto the
>> system then we have fewer guarantees about the integrity. We could
>> continue using signatures for security.ima to avoid that, but then we
>> lose the performance benefits of the hmac and also don't have the same
>> level of guarantees around the other security metadata.
> 
> I think you mean "secure boot", not "trusted boot", in this case.
> 
> The original understanding was that IMA/EVM would enforce integrity
> and not enforce mandatory access control (MAC).  The LSMs (eg.
> SELinux) would be responsible for MAC.  Separation of duties.

To enforce integrity at runtime, IMA must be able to capture all
integrity relevant operations and allow the TCB to read only high
integrity files (Biba model). But, if it is left to LSMs to decide
if a file can be written or not, then IMA alone cannot determine
which files should be appraised or not. It could happen that IMA does
not appraise files which have an impact on the integrity of the TCB.

For example, with the current appraisal policy, IMA appraises files
owned by root but does not consider permissions assigned to others.
What it could happen is that, if a file owned by root is writable
by others (which is possible with DAC), a process outside the TCB
reads a file not owned by root (not appraised), becomes compromised,
and writes to a file owned by root (appraised), which is read by
a process in the TCB. The integrity of the TCB becomes low.

The problem is that, with an IMA policy based on LSM labels or DAC
permissions applied to files, IMA relies on the fact that LSMs
or DAC would preserve the integrity of the files belonging to
the TCB, while the policy might not be designed to meet this goal.

To avoid this issue, IMA could instead enforce integrity depending
on process credentials (similarly to measurement). An HMAC is added
to a file, or updated, only if the initial state is known (the file
is signed, or it belongs to a digest list), and if it is written
only by processes in the TCB. Writes by processes outside the TCB
are denied.

Files with valid HMACs could be excluded from measurement.
If enforcement is not enabled, IMA should not update the HMAC if
a file is written by a process outside the TCB, and should create
a new measurement entry if a process in the TCB accesses it.

Roberto


> With that understanding, if the LSM allows a file to be "dropped" onto
>   the file system of a running system, IMA/EVM will hash and hmac the
> permitted file.
> 
> I don't understand where you're going with this train of thought.  If
> you're trying to make a case for EVM to run with only security.evm
> signatures, then you wouldn't refer to the HMAC benefits.  If you're
> trying to make a case for EVM signatures, with the inode they're not
> portable, without the inode, they are susceptible to a cut and paste
> attack.
> 
> Mickhail's proposed patches resolves this by having a portable EVM
> signature that is never written to disk, but converted to an HMAC.
> 
> Mimi
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
