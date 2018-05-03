Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46412 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeECVjG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 17:39:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <87r2mso5up.fsf@xmission.com>
        <1525383075.3539.67.camel@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 16:38:57 -0500
In-Reply-To: <1525383075.3539.67.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Thu, 03 May 2018 17:31:15 -0400")
Message-ID: <87d0yco1vy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> [Cc'ing Kees and kernel-hardening]
>
> On Thu, 2018-05-03 at 15:13 -0500, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > In environments that require the kexec kernel image to be signed, prevent
>> > using the kexec_load syscall.  In order for LSMs and IMA to differentiate
>> > between kexec_load and kexec_file_load syscalls, this patch set adds a
>> > call to security_kernel_read_file() in kexec_load_check().
>> 
>> Having thought about it some more this justification for these changes
>> does not work.  The functionality of kexec_load is already root-only.
>> So in environments that require the kernel image to be signed just don't
>> use kexec_load.  Possibly even compile kexec_load out to save space
>> because you will never need it.  You don't need a new security hook to
>> do any of that.  Userspace is a very fine mechanism for being the
>> instrument of policy.
>
> True, for those building their own kernel, they can disable the old
> syscalls.  The concern is not for those building their own kernels,
> but for those using stock kernels.  
>
> By adding an LSM hook here in the kexec_load syscall, as opposed to an
> IMA specific hook, other LSMs can piggy back on top of it.  Currently,
> both load_pin and SELinux are gating the kernel module syscalls based
> on security_kernel_read_file.
>
> If there was a similar option for the kernel image, I'm pretty sure
> other LSMs would use it.
>
> From an IMA perspective, there needs to be some method for only
> allowing signed code to be loaded, executed, etc. - kernel modules,
> kernel image/initramfs, firmware, policies.

What is the IMA perspective.  Why can't IMA trust appropriately
authorized userspace?

>> If you don't trust userspace that needs to be spelled out very clearly.
>> You need to talk about what your threat models are.
>> 
>> If the only justification is so that that we can't boot windows if
>> someone hacks into userspace it has my nack because that is another kind
>> of complete non-sense.
>
> The usecase is the ability to gate the kexec_load usage in stock
> kernels.

But kexec_load is already gated.  It requires CAP_SYS_BOOT.

>> Given that you are not trusting userspace this changeset also probably
>> needs to have the kernel-hardening list cc'd.  Because the only possible
>> justification I can imagine for something like this is kernel-hardening.
>
> Sure, Cc'ing linux-hardening and Kees.
>
> Mimi
