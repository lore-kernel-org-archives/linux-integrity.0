Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46161 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdJRVCq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 17:02:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id g70so7299833lfl.3
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:02:45 -0700 (PDT)
Date: Thu, 19 Oct 2017 00:02:42 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: RFC: Make it practical to ship EVM signatures
Message-ID: <20171019000242.13f65fa1@totoro>
In-Reply-To: <CACE9dm92snkpP4vM_Jq0M10F9mHOFu5Zce8GB_HesmNDG9h=Rw@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
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
        <1507662460.3420.18.camel@linux.vnet.ibm.com>
        <CACE9dm-4SaL0sn_gnHy8Uj2pwVA2ztD1YcEj9Zy7TNEmx1Tb8Q@mail.gmail.com>
        <CACE9dm_Ja8Y8vSCpbaZUnanZJ9msTm1x4dki2+F4g8040OokWw@mail.gmail.com>
        <1508358623.4510.35.camel@linux.vnet.ibm.com>
        <CACE9dm92snkpP4vM_Jq0M10F9mHOFu5Zce8GB_HesmNDG9h=Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Wed, 18 Oct 2017 23:37:26 +0300
Dmitry Kasatkin <dmitry.kasatkin@gmail.com> ?????:

> May be Mikhail could share GIT url to look somewhere.
> To see latest bits.
> 
> Dmitry
>

I freezed the "portable" patchset work on 2017-01-13  
https://sourceforge.net/p/linux-ima/mailman/message/35601149/
As I mentioned, "immutable" patch was not ready for upstream (and I
had no idea what should I do with it, since I don't use it by myself). I
did "portable" part in condition I was need for my use case, so, I sent
patchset and switched to another work.



-- 
Best regards,
Mikhail Kurinnoi
