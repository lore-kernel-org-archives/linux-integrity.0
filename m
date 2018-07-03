Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753068AbeGCNIC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 09:08:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63D4QRS091065
        for <linux-integrity@vger.kernel.org>; Tue, 3 Jul 2018 09:08:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k09821ph0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 09:08:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 14:07:57 +0100
Subject: Re: [PATCH v5 3/8] ima: based on policy require signed kexec kernel
 images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Date: Tue, 03 Jul 2018 09:07:39 -0400
In-Reply-To: <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
         <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530623259.3452.28.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-07-02 at 11:31 -0700, J Freyensee wrote:
> 
> On 7/2/18 7:37 AM, Mimi Zohar wrote:
> > The original kexec_load syscall can not verify file signatures, nor can
> > the kexec image be measured.  Based on policy, deny the kexec_load
> > syscall.
> 
> 
> Curiosity question: I thought kexec_load() syscall was used to load a 
> crashdump?

kexec is used to collect the memory used to analyze the crash dump.

> If this is true, how would this work if kexec_load() is 
> being denied?  I don't think I'd want to be hindered in cases where I'm 
> trying to diagnose a crash.

For trusted & secure boot, we need a full measurement list and
signature chain of trust rooted in HW.  Permitting kexec_load would
break these chains of trust.

Permitting/denying kexec_load is based on a runtime IMA policy.  Patch
6/8 "ima: add build time policy", in this patch set, introduces the
concept of a build time policy.  With these patches, you could
configure your kernel and/or load an IMA policy permitting kexec_load.

Mimi
