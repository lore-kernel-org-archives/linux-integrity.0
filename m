Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755178AbeDJXKH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 19:10:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3AN9tsc045028
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 19:10:07 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h9274te8k-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 19:10:06 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 11 Apr 2018 00:10:04 +0100
Subject: Re: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Michael Halcrow <mhalcrow@google.com>
Date: Tue, 10 Apr 2018 19:10:00 -0400
In-Reply-To: <FB6125E9-528C-47DD-9774-86D9D4975A54@oracle.com>
References: <152337099624.13448.11040477333954216664.idtracker@ietfa.amsl.com>
         <FB6125E9-528C-47DD-9774-86D9D4975A54@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523401800.5268.61.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Chuck,

On Tue, 2018-04-10 at 08:44 -0600, Chuck Lever wrote:
> > Begin forwarded message:
> > 
> > From: internet-drafts@ietf.org
> > Subject: New Version Notification for draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > Date: April 10, 2018 at 8:36:36 AM MDT
> > To: "Charles Lever" <chuck.lever@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>
> > 
> > 
> > A new version of I-D, draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > has been successfully submitted by Charles Lever and posted to the
> > IETF repository.
> > 
> > Name:		draft-cel-nfsv4-linux-seclabel-xtensions
> > Revision:	00
> > Title:		Linux-related Extensions to NFS version 4.2 Security Labels
> > Document date:	2018-04-09
> > Group:		Individual Submission
> > Pages:		8
> > URL:            https://www.ietf.org/internet-drafts/draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > Status:         https://datatracker.ietf.org/doc/draft-cel-nfsv4-linux-seclabel-xtensions/
> > Htmlized:       https://tools.ietf.org/html/draft-cel-nfsv4-linux-seclabel-xtensions-00
> > Htmlized:       https://datatracker.ietf.org/doc/html/draft-cel-nfsv4-linux-seclabel-xtensions
> > 
> > 
> > Abstract:
> >   NFS version 4.2 introduces an optional feature known as NFSv4
> >   Security Labels.  This document extends NFSv4 Security Labels to
> >   support Linux file capabilities and the Linux Integrity Measurement
> >   Architecture.
> > 

Very nice!  Thank you so much for writing this up.

> > 
> > 
> > Please note that it may take a couple of minutes from the time of submission
> > until the htmlized version and diff are available at tools.ietf.org.
> > 
> > The IETF Secretariat
> 
> Initial revision, by no means final. Review comments welcome.
> 
> I'm toying with some ideas here. If you find anything controversial
> you are welcome to provide input.

"security.ima" may contain either a file hash or a file signature.
 "security.evm" may contain either an HMAC or a signature of the file
metdata.  Only the security.evm portable and immutable file signature,
not the HMAC which is TPM specific, will be applicable.

The last paragraph of section 1.1 mentions that the private key needs
to be protected, which is fine, but then mentions a TPM.  This might
be a bit confusing in the context of EVM/IMA-appraisal as only the
trusted "master" key, which is used to encrypt/decrypt the EVM key, is
created and decrypted by the TPM.

Mimi
