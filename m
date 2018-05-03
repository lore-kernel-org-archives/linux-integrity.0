Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:33106 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeECUN1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 16:13:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 15:13:18 -0500
In-Reply-To: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        (Mimi Zohar's message of "Thu, 12 Apr 2018 18:41:48 -0400")
Message-ID: <87r2mso5up.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> In environments that require the kexec kernel image to be signed, prevent
> using the kexec_load syscall.  In order for LSMs and IMA to differentiate
> between kexec_load and kexec_file_load syscalls, this patch set adds a
> call to security_kernel_read_file() in kexec_load_check().

Having thought about it some more this justification for these changes
does not work.  The functionality of kexec_load is already root-only.
So in environments that require the kernel image to be signed just don't
use kexec_load.  Possibly even compile kexec_load out to save space
because you will never need it.  You don't need a new security hook to
do any of that.  Userspace is a very fine mechanism for being the
instrument of policy.

If you don't trust userspace that needs to be spelled out very clearly.
You need to talk about what your threat models are.

If the only justification is so that that we can't boot windows if
someone hacks into userspace it has my nack because that is another kind
of complete non-sense.

Given that you are not trusting userspace this changeset also probably
needs to have the kernel-hardening list cc'd.  Because the only possible
justification I can imagine for something like this is kernel-hardening.

Eric
