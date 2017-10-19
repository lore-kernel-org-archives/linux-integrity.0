Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751680AbdJSLnj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 07:43:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JBhb6X139236
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 07:43:39 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dptma2qtp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 07:43:38 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 12:43:30 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JBhQ4D20381726
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:43:27 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JBhJ6o030424
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 22:43:19 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 19 Oct 2017 07:43:22 -0400
In-Reply-To: <CACE9dm8P=Y9D1j2JM+9Rj_ZLmRst2ayXiC6CtaweaWmWqpCUrA@mail.gmail.com>
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
         <1507572900.3748.21.camel@linux.vnet.ibm.com>
         <CACdnJuvOW0Pc42Nuh4QVy4xdYsaUa=H9i=YZW+XB+bg-YnDCUQ@mail.gmail.com>
         <1507574441.3748.40.camel@linux.vnet.ibm.com>
         <20171009232314.545de76a@totoro>
         <1507583449.3748.46.camel@linux.vnet.ibm.com>
         <20171010003326.6409ae23@totoro>
         <1507585253.3748.57.camel@linux.vnet.ibm.com>
         <20171010021052.47d42db6@totoro>
         <1507662460.3420.18.camel@linux.vnet.ibm.com>
         <CACE9dm-4SaL0sn_gnHy8Uj2pwVA2ztD1YcEj9Zy7TNEmx1Tb8Q@mail.gmail.com>
         <CACE9dm_Ja8Y8vSCpbaZUnanZJ9msTm1x4dki2+F4g8040OokWw@mail.gmail.com>
         <1508358623.4510.35.camel@linux.vnet.ibm.com>
         <CACE9dm92snkpP4vM_Jq0M10F9mHOFu5Zce8GB_HesmNDG9h=Rw@mail.gmail.com>
         <1508360841.4510.64.camel@linux.vnet.ibm.com>
         <CACE9dm8P=Y9D1j2JM+9Rj_ZLmRst2ayXiC6CtaweaWmWqpCUrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508413402.4510.103.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-10-19 at 13:14 +0300, Dmitry Kasatkin wrote:
> On Thu, Oct 19, 2017 at 12:07 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Hi Dmitry,
> >
> > On Wed, 2017-10-18 at 23:37 +0300, Dmitry Kasatkin wrote:
> >> May be Mikhail could share GIT url to look somewhere.
> >> To see latest bits.
> >
> > Please bottom post in the future.
> >
> > Summary:
> > Mikhail's patches were posted earlier this year.  His patches defined
> > a portable EVM signature, which was never written out to disk, but
> > after being verified, was written out as an HMAC.  This was based on
> > my understanding that the i_ino/uuid is required to prevent a cut &
> > paste attack.
> 
> I checked Mikhail patches. In his patches, immutable is normal evm
> signature but not replaceable with hmac.

Mikhail's version the EVM signature does not contain the i_ino/uuid
and is never written to disk.  On installation, an HMAC is written
out.

> 2) portable EVM digsig version, aimed to protect archived file's meta
> data from manipulations.

Right 
 
> What is the case of manipulation? hmac protects that..

Better would be to write out the portable signature on disk, assuming
it is safe to do so, and not replace it with an HMAC.

> > In the recent discussions, Matthew wanted to know why the i_ino/uuid
> > is required.  After going around and around discussing it, it turns
> > out including security.ima is equivalent to including the i_ino/uuid.
> >  The i_ino/uuid is only necessary to prevent a cut and paste attack,
> > when security.ima is not included in the security.evm hmac/signature.
> >
> 
> If I recall, we had such discussion in the chat about i_no/uuid.
> 
> if I recall right, not including them was a compromise for "portability"?
> Archive could be unpacked with xattrs and signatures are still valid.
> tar --xattrs
> cp --preserve=xattr
> 
> But how security.ima will protect against cut and paste attack?
> Attacker can take any other file together with metadata and it will be
> valid one.

Only if the file hash included in the EVM signature matches, right?

Mimi

> > We're at the point of making the portable EVM signature immutable. By
> > immutable, we mean that it isn't re-written as an HMAC.  It is based
> > on your ima-evm-utils support.
> >
> > Mikhail, Matthew, did I leave anything out?
> >
> > Mimi
> >
> 
> 
> 
