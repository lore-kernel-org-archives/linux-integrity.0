Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35872 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdJLXJy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 19:09:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id s185so3048223oif.3
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 16:09:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507662460.3420.18.camel@linux.vnet.ibm.com>
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
 <1507662460.3420.18.camel@linux.vnet.ibm.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 13 Oct 2017 02:09:53 +0300
Message-ID: <CACE9dm-4SaL0sn_gnHy8Uj2pwVA2ztD1YcEj9Zy7TNEmx1Tb8Q@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi all,

[switched to plain text]

I will check Mikhail's patches.
Give me a moment.

Thanks,
Dmitry


On Tue, Oct 10, 2017 at 10:07 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-10-10 at 02:10 +0300, Mikhail Kurinnoi wrote:
>> For now, we don't have ready for upstream "immutable" EVM signature
>> format support patch. Both, Dmitry's and my, patches need more work
>> in order to prevent file's data changes (in case of IMA hash) and
>> metadata changes for files signed by "immutable" EVM xattr (same idea
>> as we already have for IMA digsig, that prevent file's data change).
>
> After looking at your patches again, I think we should combine the
> "immutable" and "portable" concepts so that the new "portable"
> signature type is written out and considered "immutable".
>
> Dmitry's patch does prevent the file from changing, but that code is
> in IMA, but should be in EVM.  I agree we can defer preventing the
> file from changing.
>
> Mimi
>



-- 
Thanks,
Dmitry
