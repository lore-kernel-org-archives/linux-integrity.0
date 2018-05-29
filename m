Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:57578 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966399AbeE2Ucm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 16:32:42 -0400
Date: Wed, 30 May 2018 06:32:16 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file()
 hook
In-Reply-To: <871sdzy0nv.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805300629220.2647@namei.org>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com> <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com> <87po1k2304.fsf@xmission.com> <alpine.LRH.2.21.1805260139030.11624@namei.org> <871sdzy0nv.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 25 May 2018, Eric W. Biederman wrote:

> James Morris <jmorris@namei.org> writes:
> 
> > On Thu, 24 May 2018, Eric W. Biederman wrote:
> >
> >> Below is where I suggest you start on sorting out these security hooks.
> >> - Adding a security_kernel_arg to catch when you want to allow/deny the
> >>   use of an argument to a syscall.  What security_kernel_file_read and
> >>   security_kernel_file_post_read have been abused for.
> >
> > NAK. This abstraction is too semantically weak.
> >
> > LSM hooks need to map to stronger semantics so we can reason about what 
> > the hook and the policy is supposed to be mediating.
> 
> I will take that as an extremely weak nack as all I did was expose the
> existing code and what the code is currently doing.  I don't see how you
> can NAK what is already being merged and used.

It's a strong NAK.

LSM is a logical API, it provides an abstraction layer for security 
policies to mediate kernel security behaviors.

Adding an argument to a syscall is not a security behavior.

Loading a firmware file is.

=
-- 
James Morris
<jmorris@namei.org>
