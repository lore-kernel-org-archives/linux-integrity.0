Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752319AbeERLbK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 07:31:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4IBSuNE086264
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 07:31:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j1w8xa2c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 07:31:09 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 18 May 2018 12:31:08 +0100
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 18 May 2018 07:30:50 -0400
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
         <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
         <87y3ghhbws.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526643050.3632.127.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-05-17 at 22:37 -0500, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > On 5/17/2018 7:48 AM, Mimi Zohar wrote:
> >> In order for LSMs and IMA-appraisal to differentiate between the original
> >> and new syscalls (eg. kexec, kernel modules, firmware), both the original
> >> and new syscalls must call an LSM hook.
> >>
> >> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
> >> introduced calling security_kernel_module_from_file() in both the original
> >> and new syscalls.  Commit a1db74209483 ("module: replace
> >> copy_module_from_fd with kernel version") replaced these LSM calls with
> >> security_kernel_read_file().
> >>
> >> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
> >> with kernel version") and commit b804defe4297  ("kexec: replace call to
> >> copy_file_from_fd() with kernel version") replaced their own version of
> >> reading a file from the kernel with the generic
> >> kernel_read_file_from_path/fd() versions, which call the pre and post
> >> security_kernel_read_file LSM hooks.
> >>
> >> Missing are LSM calls in the original kexec syscall and firmware sysfs
> >> fallback method.  From a technical perspective there is no justification
> >> for defining a new LSM hook, as the existing security_kernel_read_file()
> >> works just fine.  The original syscalls, however, do not read a file, so
> >> the security hook name is inappropriate.  Instead of defining a new LSM
> >> hook, this patch defines security_kernel_read_blob() as a wrapper for
> >> the existing LSM security_kernel_file_read() hook.
> >
> > What a marvelous opportunity to bikeshed!
> >
> > I really dislike adding another security_ interface just because
> > the name isn't quite right. Especially a wrapper, which is just
> > code and execution overhead. Why not change security_kernel_read_file()
> > to security_kernel_read_blob() everywhere and be done?
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.
> 
> Casey you are wrong.  We need something different here.
> 
> Mimi a wrapper does not cut it.   The code is not shared.  Despite using
> a single function call today.
> 
> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

kernel_read_file() is a common, generic method of reading a file from
the kernel, which is being called from a number of places.  The
kernel_read_file_id enumeration is needed to differentiate between the
callers.  The purpose of the new security_kernel_read_file() calls is
not for the kernel to read a file, but as a method of identifying the
original buffer based methods containing a file.

Having to define a separate LSM hook for each of the original, non
kernel_read_file(), buffer based method callers, kind of makes sense,
as the callers themselves are specific, but is it really necessary?
Could we define a new, generic LSM hook named
security_kernel_buffer_data() for this purpose?

Mimi
