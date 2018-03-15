Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752284AbeCOROm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 13:14:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2FH9c1W038780
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 13:14:41 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gqu48xmvk-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 13:14:41 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Mar 2018 17:14:39 -0000
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jiandi An <anjiandi@codeaurora.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 15 Mar 2018 13:14:34 -0400
In-Reply-To: <1521133728.5348.51.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <1520893847.4522.62.camel@HansenPartnership.com>
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
         <1520899605.4522.67.camel@HansenPartnership.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
         <1521038471.4508.25.camel@HansenPartnership.com>
         <1521047286.3547.470.camel@linux.vnet.ibm.com>
         <1521048306.4508.56.camel@HansenPartnership.com>
         <1521130749.3547.608.camel@linux.vnet.ibm.com>
         <1521133728.5348.51.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521134074.3547.629.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-15 at 10:08 -0700, James Bottomley wrote:
> On Thu, 2018-03-15 at 12:19 -0400, Mimi Zohar wrote:

> > If EFI is extending the TPM, will the events be added to the TPM
> > event log or to the IMA measurement list?
> 
> I'm not proposing any changes to the tpm_pcr_extend API.  At the moment
> it does an extend without logging, so that's what it will do in the EFI
> driver case as well.  That means logging is still the responsibility of
> the caller.

Does EFI support extending multiple TPM banks?

Mimi
