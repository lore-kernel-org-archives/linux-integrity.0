Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750771AbeEAVuJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 17:50:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41Lo1X4076775
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 17:50:09 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hpvvsg2rm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 17:50:09 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 22:50:07 +0100
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 01 May 2018 17:50:03 -0400
In-Reply-To: <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
         <26787.1519902415@warthog.procyon.org.uk>
         <8106.1525201247@warthog.procyon.org.uk>
         <1525205707.5669.91.camel@linux.vnet.ibm.com>
         <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525211403.5669.141.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 21:02 +0000, Matthew Garrett wrote:
> On Tue, May 1, 2018 at 1:15 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > a) Requiring two signatures was addressed by a patch titled "lockdown:
> > fix coordination of kernel module signature verification" [1]
> 
> Ah, I'd missed that - thanks!
> 
> > There's been further discussions as to what should remain in the
> > "lockdown" patch set.  Based on the discussion here [2], it seems like
> >   "[PATCH 06/24] kexec_load: Disable at runtime if the kernel is locked
> > down" will be removed.
> 
> > Instead of preventing the loading of a kernel image (kexec_load
> >   syscall) being dependent on the lockdown flag, it could be dependent
> > on the kernel_read_file_id READING_KEXEC_IMAGE.  A version of these
> > patches was posted [3].
> 
> Hm. My concern is that distributions are going to ship IMA in a
> configuration that allows users to add their own keys at boot time (it's
> difficult to use it in a generic way otherwise), and that's going to allow
> kexecing of arbitrary images without requiring physical access. I think
> kexec_file_load() needs to be relying on non-IMA signatures.

I don't see how.  Unless the kernel was built with extra room for a
local CA public key (CONFIG_SYSTEM_EXTRA_CERTIFICATE), which would be
loaded onto the builtin keyring, there is no way of adding keys to the
IMA keyring.  Adding the extra public key would require the kernel to
be resigned.

Mimi
