Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:49743 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdJSSiO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 14:38:14 -0400
Received: by mail-oi0-f44.google.com with SMTP id w197so16442431oif.6
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:38:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACdnJutRL1hLF1+e5=m8+4eCVYXwLc08DZrwYypZKh1U-pchQQ@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com> <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
 <1507571511.3748.9.camel@linux.vnet.ibm.com> <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
 <1507572900.3748.21.camel@linux.vnet.ibm.com> <CACdnJuvOW0Pc42Nuh4QVy4xdYsaUa=H9i=YZW+XB+bg-YnDCUQ@mail.gmail.com>
 <1507574441.3748.40.camel@linux.vnet.ibm.com> <20171009232314.545de76a@totoro>
 <1507583449.3748.46.camel@linux.vnet.ibm.com> <20171010003326.6409ae23@totoro>
 <1507585253.3748.57.camel@linux.vnet.ibm.com> <20171010021052.47d42db6@totoro>
 <1507662460.3420.18.camel@linux.vnet.ibm.com> <CACE9dm-4SaL0sn_gnHy8Uj2pwVA2ztD1YcEj9Zy7TNEmx1Tb8Q@mail.gmail.com>
 <CACE9dm_Ja8Y8vSCpbaZUnanZJ9msTm1x4dki2+F4g8040OokWw@mail.gmail.com>
 <1508358623.4510.35.camel@linux.vnet.ibm.com> <CACE9dm92snkpP4vM_Jq0M10F9mHOFu5Zce8GB_HesmNDG9h=Rw@mail.gmail.com>
 <1508360841.4510.64.camel@linux.vnet.ibm.com> <CACE9dm8P=Y9D1j2JM+9Rj_ZLmRst2ayXiC6CtaweaWmWqpCUrA@mail.gmail.com>
 <CACdnJutRL1hLF1+e5=m8+4eCVYXwLc08DZrwYypZKh1U-pchQQ@mail.gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 19 Oct 2017 21:38:12 +0300
Message-ID: <CACE9dm-dR68MG_HPnF=F7RuGo+nkDtOMZ92jMjM42_BFkwifRQ@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 8:08 PM, Matthew Garrett <mjg59@google.com> wrote:
> On Thu, Oct 19, 2017 at 3:14 AM, Dmitry Kasatkin
> <dmitry.kasatkin@gmail.com> wrote:
>> But how security.ima will protect against cut and paste attack?
>> Attacker can take any other file together with metadata and it will be
>> valid one.
>
> Unless the hashing algorithm is broken, the two files will need to be
> identical in order for security.ima to match. And if the two files are
> identical then an attacker can simply delete one and create a hardlink
> to the other, which will have the same inode.

I actually meant a different thing.
For a moment I thought about placing a file from another location.
But that is directory protection issue.

While working on patches I was disputing with Mimi about usefulness of
ino in there.

-- 
Thanks,
Dmitry
