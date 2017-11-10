Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752023AbdKJOnl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 09:43:41 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAEge72092590
        for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2017 09:43:41 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e5ddsa9sp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2017 09:43:41 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 10 Nov 2017 14:43:39 -0000
Subject: Re: IMA secure_boot rules and the kernel_lockdown manpage
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:43:35 -0500
In-Reply-To: <32623.1510324279@warthog.procyon.org.uk>
References: <1510319414.3359.27.camel@linux.vnet.ibm.com>
         <28799.1510313926@warthog.procyon.org.uk>
         <32623.1510324279@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510325015.3359.51.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-11-10 at 14:31 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > This initially enforces kernel modules, firmware, the kernel kexec
> > image, and the IMA policy itself are signed.
> 
> "Initially" meaning that this can be changed?

No, I was intending to allow the meaning of the "secure_boot" policy
to change over time.

There's already support for the initramfs to be signed.  With Thiago
Baurmann's "Appended signatures support for IMA appraisal", which is
initially meant for the kexec'ed kernel image, the initramfs can be
signed with an appended signature as well.

Once IMA support for appended signatures is upstreamed, we could
extend the "secure_boot" policy to require the initramfs to be signed
as well.

Mimi 
