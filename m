Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751049AbeERP35 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 11:29:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4IFTdkc073122
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 11:29:56 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j1ya5xycr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 11:29:56 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 18 May 2018 16:29:53 +0100
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 18 May 2018 11:29:36 -0400
In-Reply-To: <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
         <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
         <87y3ghhbws.fsf@xmission.com>
         <1526643050.3632.127.camel@linux.vnet.ibm.com>
         <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526657376.3404.15.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-18 at 07:58 -0700, Casey Schaufler wrote:
> On 5/18/2018 4:30 AM, Mimi Zohar wrote:

> > Having to define a separate LSM hook for each of the original, non
> > kernel_read_file(), buffer based method callers, kind of makes sense,
> > as the callers themselves are specific, but is it really necessary?
> > Could we define a new, generic LSM hook named
> > security_kernel_buffer_data() for this purpose?
> 
> If there are two disparate behaviors wrapped into kernel_read_file()
> Eric (bless him) is right. It should be broken into two hooks. I think
> that if we look (too) carefully we'll find other places where hooks
> should get broken up, or combined*. My question is just how important
> is it that this gets changed?

Other than the LSM call in copy_module_from_user(), this patch set is
adding the LSM call in kexec_load() and firmware_fallback_sysfs().

Eric, the question remains whether we need distinct LSM hooks in each
of these places or can we have a single, generic LSM hook named
security_kernel_buffer_data()?

Mimi
