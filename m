Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751027AbeEAUPM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 16:15:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41KDv5o073043
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 16:15:12 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hpx19jca2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 16:15:11 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 21:15:10 +0100
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 01 May 2018 16:15:07 -0400
In-Reply-To: <8106.1525201247@warthog.procyon.org.uk>
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
         <26787.1519902415@warthog.procyon.org.uk>
         <8106.1525201247@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525205707.5669.91.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 20:00 +0100, David Howells wrote:
> Matthew Garrett <mjg59@google.com> wrote:
> 
> > (a) seems unnecessary, and (b) isn't possible in most distributions
> > (there's ongoing work in Debian, but it's not merged yet). I can see cases
> > where you'd want to enforce this via IMA, but I don't think it's
> > appropriate for all cases. Should the use of the IMA secure_boot policy be
> > gated behind a config option?
> 
> Quite probably.  Mimi?

a) Requiring two signatures was addressed by a patch titled "lockdown:
fix coordination of kernel module signature verification" [1]

b) With the coordination of the signature verification above, enabling
either method or both methods, should work properly.

There's been further discussions as to what should remain in the
"lockdown" patch set.  Based on the discussion here [2], it seems like
 "[PATCH 06/24] kexec_load: Disable at runtime if the kernel is locked
down" will be removed.

Instead of preventing the loading of a kernel image (kexec_load
 syscall) being dependent on the lockdown flag, it could be dependent
on the kernel_read_file_id READING_KEXEC_IMAGE.  A version of these
patches was posted [3].

[1] http://kernsec.org/pipermail/linux-security-module-archive/2018-April/006456.html
[2] http://kernsec.org/pipermail/linux-security-module-archive/2018-April/006419.html
[3] http://kernsec.org/pipermail/linux-security-module-archive/2018-April/006443.html

Mimi
