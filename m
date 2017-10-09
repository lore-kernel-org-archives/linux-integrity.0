Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:47045 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbdJIR7f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Oct 2017 13:59:35 -0400
Received: by mail-io0-f170.google.com with SMTP id 101so9515543ioj.3
        for <linux-integrity@vger.kernel.org>; Mon, 09 Oct 2017 10:59:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507571511.3748.9.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com> <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
 <1507571511.3748.9.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 9 Oct 2017 10:59:34 -0700
Message-ID: <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 9, 2017 at 10:51 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> >> I'm not really clear on what attacks are prevented by using the inode
>> >> number. If I'm able to preserve all the other security metadata when
>> >> copying a file, I can just create a hardlink to the original instead
>> >> and have the same outcome.
>> >
>> > The issue is the ability of having different security metadata, not
>> > the same security metadata. (I need to refresh my memory as to hard
>> > links, and whether they can have different security metadata.)
>>
>> If the security metadata is different then copying another
>> security.evm will fail, surely?
>
> The assumption here is that security.ima exists and is included in the
> HMAC calculation.  For files which are not included in the IMA policy,
> the only thing binding the file data and metadata is the i_ino and
> uuid.

Ok, that makes sense. But for cases where we do have security.ima, the
inode doesn't seem to provide additional security but does make
deployment more difficult. Does supporting this use case seem
reasonable?
