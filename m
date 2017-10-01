Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750844AbdJACgr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Sep 2017 22:36:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v912YxmT099555
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 22:36:47 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2daat3pvfm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 22:36:46 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 1 Oct 2017 12:36:44 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v912afPi51249270
        for <linux-integrity@vger.kernel.org>; Sun, 1 Oct 2017 13:36:41 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v912afBV031486
        for <linux-integrity@vger.kernel.org>; Sun, 1 Oct 2017 13:36:41 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Sat, 30 Sep 2017 22:36:37 -0400
In-Reply-To: <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
         <1506646397.5691.64.camel@linux.vnet.ibm.com>
         <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
         <1506711726.5691.141.camel@linux.vnet.ibm.com>
         <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
         <1506715304.5691.151.camel@linux.vnet.ibm.com>
         <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506825397.5691.186.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-09-29 at 13:09 -0700, Matthew Garrett wrote:
> On Fri, Sep 29, 2017 at 1:01 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2017-09-29 at 12:17 -0700, Matthew Garrett wrote:
> >> I'm arguing that (for our case at least) the only way we can use IMA
> >> is to rely on using a digital signature - we can either have that
> >> digital signature be in security.ima, or we can have it in
> >> security.evm. Since we need that signature in any case, we derive no
> >> benefit from having security.evm be an hmac - our two reasonable
> >> choices are:
> >>
> >> 1) security.ima as a digital signature, security.evm as an hmac
> >> 2) security.ima as a hash, security.evm as a digital signature
> >
> > There's a major difference between security.ima containing a file hash
> > vs a signature.  A signature, assuming the file_check hook is in
> > policy, prevents the file from being modified, making the file
> > "immutable".
> 
> But the same is effectively true if security.evm is a digital
> signature and there's no symmetric key? For what we want to do (ensure
> that executables that are allowed to run with elevated privileges
> haven't been tampered with), that's completely ok.
> 
> >> I'm not really clear on what attacks are prevented by using the inode
> >> number. If I'm able to preserve all the other security metadata when
> >> copying a file, I can just create a hardlink to the original instead
> >> and have the same outcome.
> >
> > The issue is the ability of having different security metadata, not
> > the same security metadata. (I need to refresh my memory as to hard
> > links, and whether they can have different security metadata.)
> 
> If the security metadata is different then copying another
> security.evm will fail, surely?

A copy of the file could exist with a valid hmac on the system with
different security xattrs.  Without the inode/uuid, the xattrs could
be cut & pasted.

Ok, I agree this would be less of an issue for security.evm
signatures, since the signatures are not being generated on the
locally running system.

Mimi
