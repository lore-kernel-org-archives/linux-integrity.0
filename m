Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:44093 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933907AbeE2VKf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 17:10:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Morris <jmorris@namei.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
        <87po1k2304.fsf@xmission.com>
        <alpine.LRH.2.21.1805260139030.11624@namei.org>
        <871sdzy0nv.fsf@xmission.com>
        <alpine.LRH.2.21.1805300629220.2647@namei.org>
Date: Tue, 29 May 2018 16:10:30 -0500
In-Reply-To: <alpine.LRH.2.21.1805300629220.2647@namei.org> (James Morris's
        message of "Wed, 30 May 2018 06:32:16 +1000 (AEST)")
Message-ID: <87y3g2kw1l.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

James Morris <jmorris@namei.org> writes:

> On Fri, 25 May 2018, Eric W. Biederman wrote:
>
>> James Morris <jmorris@namei.org> writes:
>> 
>> > On Thu, 24 May 2018, Eric W. Biederman wrote:
>> >
>> >> Below is where I suggest you start on sorting out these security hooks.
>> >> - Adding a security_kernel_arg to catch when you want to allow/deny the
>> >>   use of an argument to a syscall.  What security_kernel_file_read and
>> >>   security_kernel_file_post_read have been abused for.
>> >
>> > NAK. This abstraction is too semantically weak.
>> >
>> > LSM hooks need to map to stronger semantics so we can reason about what 
>> > the hook and the policy is supposed to be mediating.
>> 
>> I will take that as an extremely weak nack as all I did was expose the
>> existing code and what the code is currently doing.  I don't see how you
>> can NAK what is already being merged and used.
>
> It's a strong NAK.

We are either not understading each other or you have just strong NAK'd
part of the existing LSM api.  Not my proposal.

> LSM is a logical API, it provides an abstraction layer for security 
> policies to mediate kernel security behaviors.

The way it deals with firmware blobs and module loading is not logical.
It is some random pass a NULL pointer into some other security hook.

> Adding an argument to a syscall is not a security behavior.
>
> Loading a firmware file is.

It is a firmware blob not a file.  Perhaps the blob is stored as a file
on-disk, perhaps it is not.

The similar case with kexec never stores all of the data in a file.

Why module_init (which does not take a file) is calling a file based lsm
hook is also bizarre.


Perhaps that means all 3 of these cases should have their own void
security hooks.  Perhaps it means something else.  I just know the name
on the security hook, how it is getting called, and how it is getting
used simply do not agree.

Eric
