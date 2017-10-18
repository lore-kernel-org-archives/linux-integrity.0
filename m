Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751800AbdJRUae (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 16:30:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9IKTtq4051507
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 16:30:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dpax6anbu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 16:30:32 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 21:30:30 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9IKURrO21823618
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 20:30:28 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9IKUVbF004434
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 07:30:31 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 18 Oct 2017 16:30:23 -0400
In-Reply-To: <CACE9dm_Ja8Y8vSCpbaZUnanZJ9msTm1x4dki2+F4g8040OokWw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508358623.4510.35.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 22:48 +0300, Dmitry Kasatkin wrote:
> Can you please point me to the patchset email?

This was the start of the lengthy discussion -
https://www.spinics.net/lists/linux-integrity/msg00035.html


> 
> On Fri, Oct 13, 2017 at 2:09 AM, Dmitry Kasatkin
> <dmitry.kasatkin@gmail.com> wrote:
> > Hi all,
> >
> > [switched to plain text]
> >
> > I will check Mikhail's patches.
> > Give me a moment.
> >
> > Thanks,
> > Dmitry
> >
> >
> > On Tue, Oct 10, 2017 at 10:07 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> On Tue, 2017-10-10 at 02:10 +0300, Mikhail Kurinnoi wrote:
> >>> For now, we don't have ready for upstream "immutable" EVM signature
> >>> format support patch. Both, Dmitry's and my, patches need more work
> >>> in order to prevent file's data changes (in case of IMA hash) and
> >>> metadata changes for files signed by "immutable" EVM xattr (same idea
> >>> as we already have for IMA digsig, that prevent file's data change).
> >>
> >> After looking at your patches again, I think we should combine the
> >> "immutable" and "portable" concepts so that the new "portable"
> >> signature type is written out and considered "immutable".
> >>
> >> Dmitry's patch does prevent the file from changing, but that code is
> >> in IMA, but should be in EVM.  I agree we can defer preventing the
> >> file from changing.
> >>
> >> Mimi
> >>
> >
> >
> >
> > --
> > Thanks,
> > Dmitry
> 
> 
> 
