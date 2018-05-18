Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:48325 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeERDhe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 May 2018 23:37:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
        <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
Date: Thu, 17 May 2018 22:37:23 -0500
In-Reply-To: <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com> (Casey
        Schaufler's message of "Thu, 17 May 2018 17:24:36 -0700")
Message-ID: <87y3ghhbws.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob() wrapper
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 5/17/2018 7:48 AM, Mimi Zohar wrote:
>> In order for LSMs and IMA-appraisal to differentiate between the original
>> and new syscalls (eg. kexec, kernel modules, firmware), both the original
>> and new syscalls must call an LSM hook.
>>
>> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
>> introduced calling security_kernel_module_from_file() in both the original
>> and new syscalls.  Commit a1db74209483 ("module: replace
>> copy_module_from_fd with kernel version") replaced these LSM calls with
>> security_kernel_read_file().
>>
>> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
>> with kernel version") and commit b804defe4297  ("kexec: replace call to
>> copy_file_from_fd() with kernel version") replaced their own version of
>> reading a file from the kernel with the generic
>> kernel_read_file_from_path/fd() versions, which call the pre and post
>> security_kernel_read_file LSM hooks.
>>
>> Missing are LSM calls in the original kexec syscall and firmware sysfs
>> fallback method.  From a technical perspective there is no justification
>> for defining a new LSM hook, as the existing security_kernel_read_file()
>> works just fine.  The original syscalls, however, do not read a file, so
>> the security hook name is inappropriate.  Instead of defining a new LSM
>> hook, this patch defines security_kernel_read_blob() as a wrapper for
>> the existing LSM security_kernel_file_read() hook.
>
> What a marvelous opportunity to bikeshed!
>
> I really dislike adding another security_ interface just because
> the name isn't quite right. Especially a wrapper, which is just
> code and execution overhead. Why not change security_kernel_read_file()
> to security_kernel_read_blob() everywhere and be done?

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Nack on this sharing nonsense.  These two interfaces do not share any
code in their implementations other than the if statement to distinguish
between the two cases.

Casey you are wrong.  We need something different here.

Mimi a wrapper does not cut it.   The code is not shared.  Despite using
a single function call today.

If we want comprehensible and maintainable code in the security modules
we need to split these two pieces of functionality apart.

Eric
