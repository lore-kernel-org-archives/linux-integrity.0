Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751688AbdLKNsp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 08:48:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBBDkHVV136119
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 08:48:44 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2est05br2h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 08:48:43 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 11 Dec 2017 13:48:41 -0000
Subject: Re: IMA keyctl problems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Paul R. Tagliamonte" <paultag@gmail.com>,
        linux-integrity@vger.kernel.org
Date: Mon, 11 Dec 2017 08:48:37 -0500
In-Reply-To: <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
         <1512915528.3846.29.camel@linux.vnet.ibm.com>
         <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
         <1512921715.3846.33.camel@linux.vnet.ibm.com>
         <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
         <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
         <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513000117.3846.122.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2017-12-10 at 22:59 -0500, Paul R. Tagliamonte wrote:
> (break-break)
> 
> Phew. OK. I think I've made sense of what was going on here.
> 
> I took another look at my policy and on a hunch, figured I ought to
> look at the only unique line I had written:
> 
> ```
> appraise appraise_type=imasig uid=1000
> ```
> 
> When I changed that to uid=0, everything worked as expected.

The "uid=" is a condition that limits which files to appraise.  By
changing "uid=" to 0, I assume by "worked as expected" means nothing
verified.

> 
> On a hunch, I changed it back to uid=1000, got the error, and ran:
> 
> ```
> keyctl link %keyring:_ima %keyring:_uid.1000
> ```
> 
> At which point, the kernel errors went away, and I got the single
> `IMA-signature-required` error I was looking for. Huzzah!
> 
> 
> Now, can anyone point me in the right direction as to why I had to
> link this keyring to a user to enforce policy?
> 
> Is there a reason the lookup doesn't behave as if it were doing a
> %keyring:{_,.}ima lookup? That works even before linking it to
> _uid.1000.
> 
> Do other tools load this for each UID on the system? What happens if a
> new user is added at runtime?
> 
> This was a pretty not-obvious way for this system to fail, are there
> docs that cover this?

This all seems to indicate that the keys are not being loaded onto
root's _ima keyring.  See if there is a difference if you "su -",
before creating the _ima keyring.

Even if you don't add any keys during boot, enabling dracut/systemd
would at least properly create the _ima keyring.

Mimi
