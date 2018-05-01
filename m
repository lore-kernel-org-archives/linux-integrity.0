Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753789AbeEARoG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 13:44:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41HYKmu029121
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 13:44:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hpsfy05j0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 13:44:05 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 18:44:03 +0100
Subject: Re: [PATCH V2] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Tue, 01 May 2018 13:43:59 -0400
In-Reply-To: <CACdnJuuXNpk+Uj6YB1KPyYiGWY+6xsb-gfT1HJZ394ui+_ZByQ@mail.gmail.com>
References: <20180427194155.41282-1-mjg59@google.com>
         <1525139784.5669.26.camel@linux.vnet.ibm.com>
         <CACdnJuuXNpk+Uj6YB1KPyYiGWY+6xsb-gfT1HJZ394ui+_ZByQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525196639.5669.51.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-01 at 17:21 +0000, Matthew Garrett wrote:
> On Mon, Apr 30, 2018 at 6:56 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > On Fri, 2018-04-27 at 12:41 -0700, Matthew Garrett wrote:
> > > +     for (xattrname = evm_config_default_xattrnames; *xattrname !=
> NULL;
> > > +          xattrname++) {
> > > +             tmp = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> > > +             if (!tmp)
> > > +                     return -ENOMEM;
> > > +             tmp->name = kstrdup(*xattrname, GFP_KERNEL);
> > > +             if (!tmp->name) {
> > > +                     kfree(tmp);
> > > +                     return -ENOMEM;
> > > +             }
> > > +             list_add_tail(&tmp->list, &evm_config_xattrnames);
> 
> > If evm_config_xattrnames[] is defined as struct xattr_list, there's no
> > need for allocating memory for the xattr_list and name.  Something
> > like in ima_init_policy() would work.
> 
> Hm. Do you mean evm_config_default_xattrnames?

Yes, or:
        for (i = 0; i < secure_boot_entries; i++)
                list_add_tail(&secure_boot_rules[i].list,
                              &ima_default_rules);

> 
> > Could we break this patch up to simplify review?  The first patch
> > would create and use the xattrname list.  The subsequent patch(es)
> > would add the new functionality.
> 
> Sure, I'll do that.

thanks!

Mimi
