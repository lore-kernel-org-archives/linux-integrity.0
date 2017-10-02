Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750739AbdJBTyi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 15:54:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v92JsHSi019644
        for <linux-integrity@vger.kernel.org>; Mon, 2 Oct 2017 15:54:38 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dbtbq4k4k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 15:54:37 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Oct 2017 05:54:35 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v92JsV4M37355706
        for <linux-integrity@vger.kernel.org>; Tue, 3 Oct 2017 06:54:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v92JsWkS004799
        for <linux-integrity@vger.kernel.org>; Tue, 3 Oct 2017 06:54:32 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Mon, 02 Oct 2017 15:54:28 -0400
In-Reply-To: <CACdnJuv11cjDHac6M+iofB7yA=on2N5ZiqXz8onZZPtGFgo7yA@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
         <1506646397.5691.64.camel@linux.vnet.ibm.com>
         <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
         <1506711726.5691.141.camel@linux.vnet.ibm.com>
         <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
         <1506715304.5691.151.camel@linux.vnet.ibm.com>
         <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
         <1506825397.5691.186.camel@linux.vnet.ibm.com>
         <CACdnJuv11cjDHac6M+iofB7yA=on2N5ZiqXz8onZZPtGFgo7yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506974068.5691.300.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-02 at 10:09 -0700, Matthew Garrett wrote:
> On Sat, Sep 30, 2017 at 7:36 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2017-09-29 at 13:09 -0700, Matthew Garrett wrote:
> >> If the security metadata is different then copying another
> >> security.evm will fail, surely?
> >
> > A copy of the file could exist with a valid hmac on the system with
> > different security xattrs.  Without the inode/uuid, the xattrs could
> > be cut & pasted.
> 
> So we have /usr/bin/a and /usr/bin/b, which are identical but have
> different security contexts. Outside some unusual cases, if I have the
> ability to modify /usr/bin/b's security.evm, I can delete /usr/bin/b.
> I can then also just do:
> 
> ln -f /usr/bin/a /usr/bin/b
> 
> and /usr/bin/b now has the same security context as /usr/bin/a,
> including security.evm.

All true, but instead of /usr/bin/a and /usr/bin/b, which most likely
have the same LSM labels, think of it in terms of /home/bin/b.  An
offline attack wouldn't require access to the EVM HMAC key or any
privileges.

Mimi
