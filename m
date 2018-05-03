Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:32828 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeECWvQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 18:51:16 -0400
Received: by mail-it0-f66.google.com with SMTP id t7-v6so3292504itf.0
        for <linux-integrity@vger.kernel.org>; Thu, 03 May 2018 15:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87r2mso5up.fsf@xmission.com> <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
 <876044l7tr.fsf@xmission.com>
In-Reply-To: <876044l7tr.fsf@xmission.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 03 May 2018 22:51:05 +0000
Message-ID: <CACdnJut4R-BQCYcT5_OuFezf8046-HmvvdEP4g7=ADgAW+qdeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
To: ebiederm@xmission.com
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 3, 2018 at 2:59 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Matthew Garrett <mjg59@google.com> writes:
> > kexec_load gives root arbitrary power to modify the running kernel
image,
> > including the ability to disable enforcement of module signatures.

> No.  It does absolutely nothing to the running kernel image.
> Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
> booting something different.  It is argubably a little more efficient
> than writing to a file to direct the bootloader to boot something
> different and then calling reboot.  But it is not fundamentally
> different.

It absolutely does - https://mjg59.dreamwidth.org/28746.html gives an
example. The payload just needs to return.

> > Given
> > that it weakens other security mechanisms that are designed to prevent
root
> > from disabling them, it makes sense to allow the imposition of an
> > equivalent restriction.

> Say what.  You are saying a lot of words without any specifics.  Not a
> specific threat mode.  Not which security mecahnisms you are worried
> about weakening.  Not what classes of problems you are trying to defend
> against.

I have a kernel configured with module.sig_enforce enabled - root is unable
to load kernel modules that are unsigned, and since sig_enforce is
bool_enable_only, root is unable to flip that back. Any number of security
models may be implemented with that assumption. However, root still has
access to kexec_load(), and can therefore kexec into a dummy payload that
flips that byte back to 0 and permits loading unsigned module code.

There may well be other mechanisms that permit root to gain arbitrary
ability to modify kernel code. My argument is that we should treat those as
bugs, not use their existence as a justification for leaving open known
cases.
