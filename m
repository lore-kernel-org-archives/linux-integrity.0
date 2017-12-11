Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751307AbdLKPs4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 10:48:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBBFla1e108148
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 10:48:56 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2esvyhr2w9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 10:48:55 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 11 Dec 2017 15:48:46 -0000
Subject: Re: IMA keyctl problems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Paul R. Tagliamonte" <paultag@gmail.com>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 11 Dec 2017 10:48:42 -0500
In-Reply-To: <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
         <1512915528.3846.29.camel@linux.vnet.ibm.com>
         <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
         <1512921715.3846.33.camel@linux.vnet.ibm.com>
         <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
         <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
         <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
         <1513000117.3846.122.camel@linux.vnet.ibm.com>
         <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513007322.3846.146.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-12-11 at 09:13 -0500, Paul R. Tagliamonte wrote:
> On Mon, Dec 11, 2017 at 8:48 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > The "uid=" is a condition that limits which files to appraise.  By
> > changing "uid=" to 0, I assume by "worked as expected" means nothing
> > verified.
> 
> Not quite, when I say "works as expected" I mean, everything worked
> (since I signed all binaries) except for one (which was logged, as I
> mentioned, and when I turned it onto enforce, it gave me permission
> denied. As root.

Great!  And if you replaced the "uid=0" with "fowner=0" the appraisal
would succeed whether or not you're running as root.

> > This all seems to indicate that the keys are not being loaded onto
> > root's _ima keyring.  See if there is a difference if you "su -",
> > before creating the _ima keyring.
> 
> I was running this as uid 0 in the initramfs. It's in a keyring named
> _ima and it's linked to @u. That appears to not be sufficient. How do
> I create a keyring that spans all user's @u?

Different files can be signed with different keys, but all keys should
be loaded onto the same _ima keyring.  (This will change once IMA is
namespaced.)

The policy defines which files should be appraised.  If you want to
verify files owned by uid 1000, the policy would include an appraise
rule fowner=1000.

> > Even if you don't add any keys during boot, enabling dracut/systemd
> > would at least properly create the _ima keyring.
> 
> Do you have a pointer as to what I'm doing on? I attached the script
> I'm running in my initramfs. I'd rather figure out what I'm doing
> wrong before punting this to another tool for now.

Normally one starts with something that is known to work, before
attempting/complaining something different doesn't work.

Mimi
