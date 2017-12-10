Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751726AbdLJQDk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Dec 2017 11:03:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBAFx8Jt077787
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 11:03:40 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2es4k7bp9s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Dec 2017 11:03:38 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 10 Dec 2017 16:01:58 -0000
Subject: Re: IMA keyctl problems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Paul R. Tagliamonte" <paultag@gmail.com>
Cc: linux-integrity@vger.kernel.org
Date: Sun, 10 Dec 2017 11:01:55 -0500
In-Reply-To: <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
         <1512915528.3846.29.camel@linux.vnet.ibm.com>
         <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512921715.3846.33.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2017-12-10 at 10:06 -0500, Paul R. Tagliamonte wrote:
> Thanks for the quick reply!
> 
> Good call, but no such luck --
> 
> $ sudo keyctl show %keyring:.ima
> Can't find 'keyring:.ima'

Both dracut and systemd have examples for loading keys on the IMA keyring.

- https://git.kernel.org/pub/scm/boot/dracut/dracut.git/tree/modules.d/98integrity/ima-keys-load.sh

- https://github.com/systemd/systemd/blob/master/src/core/ima-setup.c

Also, you might be interested in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=850339

Mimi
