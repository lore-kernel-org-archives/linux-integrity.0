Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932228AbdJJTHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 15:07:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9AJ7iKm106468
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 15:07:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2mx58yn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 15:07:52 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 10 Oct 2017 20:07:49 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9AJ7jND31064192
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 19:07:46 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9AJ7ixA014783
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 06:07:44 +1100
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 10 Oct 2017 15:07:40 -0400
In-Reply-To: <20171010021052.47d42db6@totoro>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507662460.3420.18.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-10 at 02:10 +0300, Mikhail Kurinnoi wrote:
> For now, we don't have ready for upstream "immutable" EVM signature
> format support patch. Both, Dmitry's and my, patches need more work
> in order to prevent file's data changes (in case of IMA hash) and
> metadata changes for files signed by "immutable" EVM xattr (same idea
> as we already have for IMA digsig, that prevent file's data change).

After looking at your patches again, I think we should combine the
"immutable" and "portable" concepts so that the new "portable"
signature type is written out and considered "immutable". 

Dmitry's patch does prevent the file from changing, but that code is
in IMA, but should be in EVM.  I agree we can defer preventing the
file from changing.

Mimi
