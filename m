Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755212AbdJISkx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Oct 2017 14:40:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v99Iefu6006094
        for <linux-integrity@vger.kernel.org>; Mon, 9 Oct 2017 14:40:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dg9s8gjsx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Oct 2017 14:40:52 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 19:40:50 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v99IejNR25493730
        for <linux-integrity@vger.kernel.org>; Mon, 9 Oct 2017 18:40:46 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v99Iei3v008073
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 05:40:44 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Mon, 09 Oct 2017 14:40:41 -0400
In-Reply-To: <CACdnJuvOW0Pc42Nuh4QVy4xdYsaUa=H9i=YZW+XB+bg-YnDCUQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507574441.3748.40.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-09 at 11:18 -0700, Matthew Garrett wrote:
> On Mon, Oct 9, 2017 at 11:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Mon, 2017-10-09 at 10:59 -0700, Matthew Garrett wrote:
> >> Ok, that makes sense. But for cases where we do have security.ima, the
> >> inode doesn't seem to provide additional security but does make
> >> deployment more difficult. Does supporting this use case seem
> >> reasonable?
> >
> > Yes!
> 
> Excellent. This means defining a new signature type - the two options
> seem to be Mikhail's portable format, or the approach I took of having
> the signature define which metadata is included. Do you have a
> preference?

We now understand that as long as the EVM signature includes
security.ima, it is safe not to include the i_ino/uuid.  This new
format can be written to disk.

Based on the previous discussions, Mikhail's patches never write the
portable EVM signature format to disk, but verify the signature,
before calculating and writing the HMAC.  Based on our current
understanding that isn't required.  The new EVM signature can be
written out.

Let's keep the change as simple as possible.
