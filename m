Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932085AbeGCMgC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 08:36:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63CTRUM051524
        for <linux-integrity@vger.kernel.org>; Tue, 3 Jul 2018 08:36:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k08vvh89m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 08:36:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 13:35:59 +0100
Subject: Re: [PATCH v5 1/8] security: define new LSM hook named
 security_kernel_load_data
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
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Tue, 03 Jul 2018 08:35:41 -0400
In-Reply-To: <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
         <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530621341.3452.5.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-07-02 at 11:45 -0700, J Freyensee wrote:
> 
> On 7/2/18 7:37 AM, Mimi Zohar wrote:
> > Differentiate between the kernel reading a file from the kernel loading
> > data provided by userspace.  This patch defines a new LSM hook named
> > security_kernel_load_data.
> 
> If this patch series is re-done, can we tweak the description here 
> please?  From what I understood of the code in this patch, I'd tweak it as:
> 
> "Differentiate between the kernel reading a file specified by userspace 
> and the kernel loading a block of data provided by userspace.  This 
> patch defines a new LSM hook named security_kernel_load_data()."
> 
>  From the description, I got a tad confused if the the kernel
> reading a file was also provided by userspace (I know it may be 2nd-
> nature to people on this list, I'm still learning this kernel
> module).

Could we replace "a block of data provided by userspace" with just
"data provided by userspace"?

Mimi
