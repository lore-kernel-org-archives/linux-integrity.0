Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753537AbeAaQ3a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jan 2018 11:29:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0VGRF0n139767
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jan 2018 11:29:29 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fue919uyx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jan 2018 11:29:29 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 31 Jan 2018 16:29:27 -0000
Subject: Re: Hidden TPM questions in the LTP IMA posts
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jan 2018 11:29:21 -0500
In-Reply-To: <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
References: <1516978199.29187.43.camel@linux.vnet.ibm.com>
         <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517416161.3469.142.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-01-31 at 15:32 +0200, Jarkko Sakkinen wrote:
> Hi
> 
> On Fri, Jan 26, 2018 at 09:49:59AM -0500, Mimi Zohar wrote:
> > Hi Jarkko,
> > 
> > There are a few TPM questions for the fixing the IMA Linux Test
> > Program (LTP) tests:
> > 
> > - The maximum size of the TPM 1.2 event record is unspecified.  What
> > is the expected maximum size?

> > - Is there a way of knowing the location of the TPM 1.2 PCRs without
> > grepping for them?

I responded (in the original thread) to my own question:

Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
location from /sys/class/misc/tpmX/device/ to
/sys/class/tpm/tpmX/device/.

> > Additional question:
> > - Are the TPM 2.0 PCRs and event log exported by the kernel?  If not,
> > how are they accessed?

Nayna, just responded (in the original thread) that only the binary
event log is exported for TPM 2.0, initially for device tree.  Similar
support for EFI is being upstreamed in this open window (linux-4.16).

> Have not missed this email. I'll answer this as soon as I have time
> to write a proper response.

(I was hoping someone else on the mailing list would respond.)
 Between Nayna and me, I think we responded to all the questions
except the first one.

Mimi
