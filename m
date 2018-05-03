Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:49392 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECV7F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 17:59:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <87r2mso5up.fsf@xmission.com>
        <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
Date: Thu, 03 May 2018 16:58:56 -0500
In-Reply-To: <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
        (Matthew Garrett's message of "Thu, 03 May 2018 20:39:48 +0000")
Message-ID: <876044l7tr.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Matthew Garrett <mjg59@google.com> writes:

> On Thu, May 3, 2018 at 1:13 PM Eric W. Biederman <ebiederm@xmission.com>
> wrote:
>
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>
>> > In environments that require the kexec kernel image to be signed,
> prevent
>> > using the kexec_load syscall.  In order for LSMs and IMA to
> differentiate
>> > between kexec_load and kexec_file_load syscalls, this patch set adds a
>> > call to security_kernel_read_file() in kexec_load_check().
>
>> Having thought about it some more this justification for these changes
>> does not work.  The functionality of kexec_load is already root-only.
>> So in environments that require the kernel image to be signed just don't
>> use kexec_load.  Possibly even compile kexec_load out to save space
>> because you will never need it.  You don't need a new security hook to
>> do any of that.  Userspace is a very fine mechanism for being the
>> instrument of policy.
>
>> If you don't trust userspace that needs to be spelled out very clearly.
>> You need to talk about what your threat models are.
>
> kexec_load gives root arbitrary power to modify the running kernel image,
> including the ability to disable enforcement of module signatures.

No.  It does absolutely nothing to the running kernel image.
Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
booting something different.  It is argubably a little more efficient
than writing to a file to direct the bootloader to boot something
different and then calling reboot.  But it is not fundamentally
different.

> Given
> that it weakens other security mechanisms that are designed to prevent root
> from disabling them, it makes sense to allow the imposition of an
> equivalent restriction.

Say what.  You are saying a lot of words without any specifics.  Not a
specific threat mode.  Not which security mecahnisms you are worried
about weakening.  Not what classes of problems you are trying to defend
against.

I absolutely hate this nonsense.  I thought you already went 20 rounds
with Linus and learned you need to be upfront with what you are
concerned about.

I believe reasonable situations can be constructed.  But I am not seeing
that happen here.

My hand wavy argument to go with yours is that code paths that are root
only are not audited for security properties.  As such the number of
exploitable bus you can find in them is larger than normal.  It might be
a little harder to mount xfs or another filesystem with an exploitable
file system image but I expect it exists.

Further nothing I have seen you involved with has been about truly
hardening the system against a hostile root.  I have for the last
several years been chipping away at that and you have been nowhere to be
found.

So please be specific.  Talk about which threat you are worried about.
Because so far this looks like someones effort to look like they were
doing something without actually caring about real world threats.

Eric
