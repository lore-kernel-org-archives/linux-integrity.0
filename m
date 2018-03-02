Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933531AbeCBVKZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Mar 2018 16:10:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w22L9KFv094047
        for <linux-integrity@vger.kernel.org>; Fri, 2 Mar 2018 16:10:24 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gfcsbb2x7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 02 Mar 2018 16:10:24 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 2 Mar 2018 21:10:22 -0000
Subject: Re: [PATCH v2 3/4] ima: fail signature verification based on policy
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Date: Fri, 02 Mar 2018 16:10:15 -0500
In-Reply-To: <20180228153015.GA30654@mail.hallyn.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519335184-17808-4-git-send-email-zohar@linux.vnet.ibm.com>
         <20180227223545.GB18767@mail.hallyn.com>
         <1519817938.3737.72.camel@linux.vnet.ibm.com>
         <20180228153015.GA30654@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520025015.10396.142.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-02-28 at 09:30 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > On Tue, 2018-02-27 at 16:35 -0600, Serge E. Hallyn wrote:
> > > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > > This patch addresses the fuse privileged mounted filesystems in
> > > > environments which are unwilling to accept the risk of trusting the
> > > > signature verification and want to always fail safe, but are for
> > > > example using a pre-built kernel.
> > > > 
> > > > This patch defines a new builtin policy "unverifiable_sigs", which can
> > > 
> > > How about recalc_unverifiable_sigs?
> > 
> > Cute, I really like that name, but in this case we're failing the
> > signature verification.
> > 
> > > It's long, but unverifiable_sigs
> > > is  not clear about whether the intent is to accept or recalculate them.
> > > 
> > > (or fail_unverifiable_sigs like the flag)
> > 
> > Could we abbreviate it to "fail_usigs"?  Or perhaps allow both
> > "fail_unverifiable_sigs" and "fail_usigs".
> 
> That sounds good.  Or fail_unverified?  But so long as 'fail' is somehow
> clearly implied by the name.

None of these names mean anything to anyone but us.  How about
"fail_safe"?  That at least has some meaning to some people.

Mimi
