Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751499AbdLJOUh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 09:20:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBAEKR8p029708
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 09:20:36 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2es4k73fs0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 09:20:31 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 10 Dec 2017 14:18:52 -0000
Subject: Re: IMA keyctl problems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Paul R. Tagliamonte" <paultag@gmail.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 10 Dec 2017 09:18:48 -0500
In-Reply-To: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512915528.3846.29.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2017-12-09 at 17:01 -0500, Paul R. Tagliamonte wrote:
> Hey all!
> 
> I have an asymmetric key loaded into _ima on my root user's @u
> keyring. v/r/s is set on the keyrings, and key:
> 
> ```
>  943483453 --alswrv      0 65534  keyring: _uid.0
>  559919368 ----s-rv      0     0   \_ keyring: _ima
>  475931491 ----s-rv      0     0       \_ asymmetric: Local IMA Key
> ```
> 
> However, when I try and run my VM with IMA set to log, I'm getting a
> log full of:
> 
> "integrity: no _ima keyring: -126"

Depending on how the kernel was built (CONFIG_IMA_TRUSTED_KEYRING),
the IMA keys need to be loaded either on the trusted keyring named
.ima or the _ima keyring.  The kernel itself creates the trusted .ima
keyring.

The command "sudo keyctl show %keyring:.ima" will indicate if the
".ima" was created.

Mimi
