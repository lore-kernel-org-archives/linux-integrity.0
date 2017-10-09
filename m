Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751834AbdJISPK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Oct 2017 14:15:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v99I91Bm079257
        for <linux-integrity@vger.kernel.org>; Mon, 9 Oct 2017 14:15:10 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dg9s8fdtu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Oct 2017 14:15:09 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 19:15:07 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v99IF46E24444978
        for <linux-integrity@vger.kernel.org>; Mon, 9 Oct 2017 18:15:05 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v99IF4iG032487
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 05:15:04 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Mon, 09 Oct 2017 14:15:00 -0400
In-Reply-To: <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
         <1506646397.5691.64.camel@linux.vnet.ibm.com>
         <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
         <1506711726.5691.141.camel@linux.vnet.ibm.com>
         <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
         <1506715304.5691.151.camel@linux.vnet.ibm.com>
         <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
         <1507571511.3748.9.camel@linux.vnet.ibm.com>
         <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507572900.3748.21.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-09 at 10:59 -0700, Matthew Garrett wrote:
> On Mon, Oct 9, 2017 at 10:51 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> >> I'm not really clear on what attacks are prevented by using the inode
> >> >> number. If I'm able to preserve all the other security metadata when
> >> >> copying a file, I can just create a hardlink to the original instead
> >> >> and have the same outcome.
> >> >
> >> > The issue is the ability of having different security metadata, not
> >> > the same security metadata. (I need to refresh my memory as to hard
> >> > links, and whether they can have different security metadata.)
> >>
> >> If the security metadata is different then copying another
> >> security.evm will fail, surely?
> >
> > The assumption here is that security.ima exists and is included in the
> > HMAC calculation.  For files which are not included in the IMA policy,
> > the only thing binding the file data and metadata is the i_ino and
> > uuid.
> 
> Ok, that makes sense. But for cases where we do have security.ima, the
> inode doesn't seem to provide additional security but does make
> deployment more difficult. Does supporting this use case seem
> reasonable?

Yes!
