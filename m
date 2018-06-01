Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750758AbeFAXFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 19:05:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w51N3rbX066871
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jun 2018 19:05:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jbcd664ps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 19:05:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sat, 2 Jun 2018 00:05:02 +0100
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Date: Fri, 01 Jun 2018 19:04:45 -0400
In-Reply-To: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
         <20180601182107.GO4511@wotan.suse.de>
         <1527892795.13403.26.camel@linux.vnet.ibm.com>
         <20180601224617.GU4511@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527894285.13403.43.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-06-02 at 00:46 +0200, Luis R. Rodriguez wrote:
> On Fri, Jun 01, 2018 at 06:39:55PM -0400, Mimi Zohar wrote:
> > On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> > > On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > > > Luis, is the security_kernel_post_read_file LSM hook in
> > > > firmware_loading_store() still needed after this patch?  Should it be
> > > > calling security_kernel_load_data() instead?
> > > 
> > > That's up to Kees to decide as he added that hook, and knows
> > > what LSMs may be doing with it. From my perspective it is confusing
> > > to have that hook there so I think it could be removed now.
> > > 
> > > Kees?
> > 
> > Commit 6593d92 ("firmware_class: perform new LSM checks") references
> > two methods of loading firmware -  filesystem-found firmware and
> > demand-loaded blobs.  I assume this call in firmware_loading_store()
> > is the demand-loaded blobs.  Does that method still exist?  Is it
> > still being used?
> 
> Yeah its the stupid sysfs interface. So likely loadpin needs porting
> as you IMA as you did.

In this case, it doesn't look like the call to
security_kernel_post_read_file() should be changed, which means that
all the LSMs and IMA still need to support !file.
 
Mimi
