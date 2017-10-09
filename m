Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:54569 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdJISS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Oct 2017 14:18:27 -0400
Received: by mail-it0-f54.google.com with SMTP id 72so13421989itk.3
        for <linux-integrity@vger.kernel.org>; Mon, 09 Oct 2017 11:18:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507572900.3748.21.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com> <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
 <1507571511.3748.9.camel@linux.vnet.ibm.com> <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
 <1507572900.3748.21.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 9 Oct 2017 11:18:26 -0700
Message-ID: <CACdnJuvOW0Pc42Nuh4QVy4xdYsaUa=H9i=YZW+XB+bg-YnDCUQ@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 9, 2017 at 11:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-10-09 at 10:59 -0700, Matthew Garrett wrote:
>> Ok, that makes sense. But for cases where we do have security.ima, the
>> inode doesn't seem to provide additional security but does make
>> deployment more difficult. Does supporting this use case seem
>> reasonable?
>
> Yes!

Excellent. This means defining a new signature type - the two options
seem to be Mikhail's portable format, or the approach I took of having
the signature define which metadata is included. Do you have a
preference?
