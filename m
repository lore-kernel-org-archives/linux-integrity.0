Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752485AbdJSRom (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 13:44:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JHiW5s131299
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 13:44:42 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dpxype0wg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 13:44:41 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 18:44:40 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JHiZDF26083340
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 17:44:37 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JHiQGQ024282
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 04:44:26 +1100
Subject: Re: [PATCH] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Thu, 19 Oct 2017 13:44:31 -0400
In-Reply-To: <CACdnJuuaLJ0g0-o567YsEU8pxs4c1xMZLU2viU6FFG6_t9uh3Q@mail.gmail.com>
References: <20171018180111.13021-1-mjg59@google.com>
         <1508417552.4510.131.camel@linux.vnet.ibm.com>
         <CACdnJuuaLJ0g0-o567YsEU8pxs4c1xMZLU2viU6FFG6_t9uh3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508435071.3268.36.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> >> Admins should note that creating portable signatures that do not include
> >> the security.ima xattr would allow these signatures to be applied to any
> >> file with the same owners and security labels, which would allow
> >> subversion of EVM's security guarantees. The kernel does not attempt to
> >> enforce this.
> >
> > As much as possible IMA and EVM should work independently of each
> > other.  But in this case, I think we need to blur the lines a bit.
> >
> > Currently, before writing a new security.evm value, the existing
> > security.evm value is verified.  To do this it has to read the
> > security xattrs to calculate the hash/hmac.  How hard would it really
> > be to verify that a security.ima xattr exists, before writing this new
> > EVM signature?  How hard would it be to make sure that security.ima is
> > included in the calculation on verification?
> 
> I don't think it would be especially hard to ensure that security.ima
> is present if the portable digsig format is used, but as you say it
> would blur the lines a little.

I'd rather err on the side of caution, preventing an unnecessary
possible attack.  In this case, I think it is warranted.
