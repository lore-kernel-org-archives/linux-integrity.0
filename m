Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750962AbeEAWVc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 18:21:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41MFruG117989
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 18:21:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hpyx8t2ww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 18:21:31 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 23:21:29 +0100
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 01 May 2018 18:21:25 -0400
In-Reply-To: <CACdnJut41527gX5xh8em8i2sZhEwYno3hN37mhNqhk7Jmtb-9g@mail.gmail.com>
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
         <26787.1519902415@warthog.procyon.org.uk>
         <8106.1525201247@warthog.procyon.org.uk>
         <1525205707.5669.91.camel@linux.vnet.ibm.com>
         <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
         <1525211403.5669.141.camel@linux.vnet.ibm.com>
         <CACdnJut41527gX5xh8em8i2sZhEwYno3hN37mhNqhk7Jmtb-9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525213285.5669.152.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 21:59 +0000, Matthew Garrett wrote:
> On Tue, May 1, 2018 at 2:50 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > On Tue, 2018-05-01 at 21:02 +0000, Matthew Garrett wrote:
> > > Hm. My concern is that distributions are going to ship IMA in a
> > > configuration that allows users to add their own keys at boot time (it's
> > > difficult to use it in a generic way otherwise), and that's going to
> allow
> > > kexecing of arbitrary images without requiring physical access. I think
> > > kexec_file_load() needs to be relying on non-IMA signatures.
> 
> > I don't see how.  Unless the kernel was built with extra room for a
> > local CA public key (CONFIG_SYSTEM_EXTRA_CERTIFICATE), which would be
> > loaded onto the builtin keyring, there is no way of adding keys to the
> > IMA keyring.  Adding the extra public key would require the kernel to
> > be resigned.
> 
> Oh, is kexec verified off the _module keyring? We still end up with the
> problem that distributions don't have a mechanism to ship IMA signatures
> yet, but that avoids the user modification problem. I've just posted a
> patchset to debian-dpkg, we'll see how that goes.

I'm not aware of a _module keyring.  With IMA-appraisal, the signature
verification of the kernel image (kexec_file_load) uses the trusted
IMA keyring.  Nayna Jain posted a patch that defines a new platform
keyring[1], which would only be used to validate the kernel image and
initramfs signatures.

Your review would be much appreciated!

I really do hope that some version of including file signatures in
Debian packages will be upstreamed soon.  Good luck!

[1] https://lkml.org/lkml/2018/2/28/1089

Mimi
