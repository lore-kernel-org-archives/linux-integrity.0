Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751495AbdKASZM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Nov 2017 14:25:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA1INVD7146777
        for <linux-integrity@vger.kernel.org>; Wed, 1 Nov 2017 14:25:11 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dyhrtwvgd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 01 Nov 2017 14:25:11 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 1 Nov 2017 18:25:08 -0000
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Wed, 01 Nov 2017 14:25:04 -0400
In-Reply-To: <CACdnJuuDpVSoGHcqjU-=z0nY_e7paQ0u4efD-1DBeTbADbB4iA@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com>
         <C2D7A727C393B644B70DF4B4DCFB60B921C471AC@FRAEML521-MBX.china.huawei.com>
         <1509367096.3583.70.camel@linux.vnet.ibm.com>
         <CACdnJuvTEAs8tg2LoktmMRUzAMrfY5qTOeawTWCkvqit4A4huw@mail.gmail.com>
         <1509377504.3583.97.camel@linux.vnet.ibm.com>
         <CACdnJuuHsOfpXE55U2x_aN92DTAJHj6LvykC-3dmE+ep4JU_Pw@mail.gmail.com>
         <CACdnJuuDpVSoGHcqjU-=z0nY_e7paQ0u4efD-1DBeTbADbB4iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509560704.3583.322.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-11-01 at 10:54 -0700, Matthew Garrett wrote:
> Ok, thinking about this some more, I think I'm conflating two
> independent things here. Whether the extended attributes and file
> contents are modifiable is a matter of policy rather than something
> that should be tied to the signature format, so I think the approach
> that makes sense is to make the portable signatures immutable (as
> previously discussed)

So updating any file metadata, including security xattrs, included in
the signature will not cause the security.evm to change.  The file
metadata will be permited to change.

> and then allow userland to define a policy that
> permits modification of the protected metadata. I'll split this up and
> retest.

This subsequent patch will define a method for preventing the file
metadata included in the signature from changing as well.

Where is this policy?  Do you mean a build or runtime configuration?
