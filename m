Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750985AbdJRCx4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 22:53:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9I2rsGB103631
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 22:53:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dnsskjt5u-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 22:53:55 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 03:53:53 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9I2rnZV27131904
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 02:53:50 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9I2rrmk004647
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 13:53:53 +1100
Subject: Re: Writing out EVM protected xattrs while EVM is active
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 17 Oct 2017 22:53:45 -0400
In-Reply-To: <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
         <1508291395.4513.95.camel@linux.vnet.ibm.com>
         <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
         <1508292499.4513.99.camel@linux.vnet.ibm.com>
         <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508295225.4513.123.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-17 at 19:13 -0700, Matthew Garrett wrote:
> On Tue, Oct 17, 2017 at 7:08 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2017-10-17 at 19:02 -0700, Matthew Garrett wrote:
> >
> >> Is this accurate? If there's no IMA policy that covers the file in
> >> question (eg, appraise is limited to a specific security context or
> >> owner), will IMA_NEW ever be set? It looks like that codepath will
> >> only be entered if there's a rule that matches. The EVM xattr
> >> protections appear to be called regardless, which means that there's
> >> then no way to write out attributes on them at runtime.
> >
> > Updating/writing security.evm is triggered by writing or updating ANY
> > file metadata included in the HMAC calculation.  There is no
> > requirement for security.ima to exist.
> 
> In this case there's no symmetric key loaded, so security.evm won't be
> updated. Here's what's happening:
> 
> 1) Configure an IMA policy that only appraises a subset of files
> 2) Create a new file that does not match the appraisal rule.
> IMA_NEW_FILE isn't set because no rule matched.
> 3) Attempt to write security.ima, security.capability and security.evm
> on the new file. EVM blocks this because IMA_NEW_FILE isn't set. 

Are you writing these xattrs before or after you closed the file?
 Once the file is closed, even if the IMA_NEW_FILE flag had been set,
it would be removed.

This normally works because the file would have been hashed and
written out as security.ima, causing security.evm to be written out as
well.

> I may be misdiagnosing this, but as far as I can tell IMA_NEW_FILE is
> only set in ima_appraise_measurement() if action is set to something,
> and if ima_match_rules() doesn't match then this will never be the
> case?

True, but having IMA_NEW_FILE set would only help with writing the
first xattr, not subsequent ones.
