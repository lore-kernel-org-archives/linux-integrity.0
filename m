Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:44804 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdKARyj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Nov 2017 13:54:39 -0400
Received: by mail-io0-f179.google.com with SMTP id m16so7920821iod.1
        for <linux-integrity@vger.kernel.org>; Wed, 01 Nov 2017 10:54:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACdnJuuHsOfpXE55U2x_aN92DTAJHj6LvykC-3dmE+ep4JU_Pw@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C471AC@FRAEML521-MBX.china.huawei.com>
 <1509367096.3583.70.camel@linux.vnet.ibm.com> <CACdnJuvTEAs8tg2LoktmMRUzAMrfY5qTOeawTWCkvqit4A4huw@mail.gmail.com>
 <1509377504.3583.97.camel@linux.vnet.ibm.com> <CACdnJuuHsOfpXE55U2x_aN92DTAJHj6LvykC-3dmE+ep4JU_Pw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 1 Nov 2017 10:54:38 -0700
Message-ID: <CACdnJuuDpVSoGHcqjU-=z0nY_e7paQ0u4efD-1DBeTbADbB4iA@mail.gmail.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Ok, thinking about this some more, I think I'm conflating two
independent things here. Whether the extended attributes and file
contents are modifiable is a matter of policy rather than something
that should be tied to the signature format, so I think the approach
that makes sense is to make the portable signatures immutable (as
previously discussed) and then allow userland to define a policy that
permits modification of the protected metadata. I'll split this up and
retest.

On Mon, Oct 30, 2017 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
> On Mon, Oct 30, 2017 at 3:31 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> Oh, I missed that.
>
> No problem, I've confused myself enough with this!
