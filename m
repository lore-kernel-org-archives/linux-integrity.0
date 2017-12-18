Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759166AbdLRPja (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 10:39:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBIFaZWK042818
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 10:39:30 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2exekcnm0p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 10:39:29 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 18 Dec 2017 15:39:27 -0000
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Mon, 18 Dec 2017 10:39:21 -0500
In-Reply-To: <CACdnJuvwFOeOfVqYux+nw8n7qM=VLRFk6cK4HhQe13WCoHwvtA@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
         <20171026084055.25482-2-mjg59@google.com>
         <1511902135.3473.5.camel@linux.vnet.ibm.com>
         <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
         <1511904917.3473.15.camel@linux.vnet.ibm.com>
         <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
         <1511908390.3473.30.camel@linux.vnet.ibm.com>
         <CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
         <CACdnJuvwFOeOfVqYux+nw8n7qM=VLRFk6cK4HhQe13WCoHwvtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513611561.5221.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-12-15 at 14:35 -0800, Matthew Garrett wrote:
> On Fri, Dec 15, 2017 at 2:24 PM, Matthew Garrett <mjg59@google.com> wrote:
> > Hm, sorry, missed this mail.

I was kind of wondering what happened...

> > On Tue, Nov 28, 2017 at 2:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
> >>> security_task_getsecid(current) will give the same results as
> >>> security_cred_getsecid(current_creds())
> >>
> >> Unwinding security_task_getsecid(current) looks like it is using
> >> real_cred, while current_cred() is using cred.
> >
> > Good question, and there's a current_real_cred() macro, so I should
> > just use that instead.
> 
> Hm. Actually, I'm not sure. For most checks we were using cred, and
> only using real_cred for the secid lookup. This feels somewhat
> inconsistent.

Even if it is a one line change, it shouldn't be hidden like this.
Please make it a separate patch, with the reason for the change.  We
need to make sure this change doesn't break existing systems.

thanks,

Mimi
