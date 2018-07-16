Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727405AbeGPOUW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Jul 2018 10:20:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GDn0xM141151
        for <linux-integrity@vger.kernel.org>; Mon, 16 Jul 2018 09:52:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8vbegrsw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 16 Jul 2018 09:52:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 16 Jul 2018 14:52:46 +0100
Subject: Re: [PATCH v6 7/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Mon, 16 Jul 2018 09:52:28 -0400
In-Reply-To: <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
         <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1531749148.3380.2.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-07-14 at 19:30 -0700, Kees Cook wrote:
> On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Both the init_module and finit_module syscalls call either directly
> > or indirectly the security_kernel_read_file LSM hook.  This patch
> > replaces the direct call in init_module with a call to the new
> > security_kernel_load_data hook and makes the corresponding changes
> > in SELinux, LoadPin, and IMA.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Jeff Vander Stoep <jeffv@google.com>
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Acked-by: Jessica Yu <jeyu@kernel.org>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Thanks!

Thank you for reviewing/ack'ing all the patches, not just this one.

Mimi
