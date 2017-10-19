Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752022AbdJSUNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 16:13:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JKAYZP127125
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 16:13:55 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dq28j1qp3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 16:13:54 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 21:13:53 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JKDoWj28180506
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 20:13:52 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JKDpTG009328
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 07:13:51 +1100
Subject: Re: IMA appraisal against xz-compressed modules
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
Cc: linux-integrity@vger.kernel.org, lwang@redhat.com
Date: Thu, 19 Oct 2017 16:13:47 -0400
In-Reply-To: <20171019193101.GA2583@glitch>
References: <20171012145520.GC2495@glitch>
         <1508037063.3426.79.camel@linux.vnet.ibm.com>
         <20171018194936.GA10984@glitch>
         <1508422840.3268.7.camel@linux.vnet.ibm.com> <20171019193101.GA2583@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508444027.3268.53.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-10-19 at 17:31 -0200, Bruno E. O. Meneguele wrote:
> On 19-10, Mimi Zohar wrote:
 
> > > Right, but it's also possible to note that CONFIG_MODULE_SIG_FORCE is
> > > handled on kernel/module.c and has a kernel cmdline param,
> > > module.sig_enforce, that is read in case CONFIG_MODULE_SIG_FORCE is not
> > > set. Wouldn't be better ima_read_file depend on this cmdline param
> > > instead directly on the CONFIG? That way kernels compiled without
> > > CONFIG_MODULE_SIG_FORCE set as default would have the option to enable
> > > the kernel param and use their normal policy (MODULE_CHECK).
> > > 
> > > What do you think?
> > 
> > I wasn't aware of the module_param.  Thank you for pointing it out.
> >  "sig_enforce" is currently defined as static.  Should it be defined
> > as __initdata?
> > 
> 
> Well, at first I thought it could stay as it is and just create a
> "getter" function, like "is_module_sig_enforced()", and use it on
> ima_main.c through module.h, since this code would be called to every
> module loaded in runtime.
> 
> If it's ok to you I can try to write a patch against integrity-next and
> see how it behaves.

Thanks!
