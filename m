Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:47724 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdJBRJl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 13:09:41 -0400
Received: by mail-io0-f171.google.com with SMTP id m201so11842iom.4
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 10:09:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506825397.5691.186.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com> <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
 <1506825397.5691.186.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 2 Oct 2017 10:09:39 -0700
Message-ID: <CACdnJuv11cjDHac6M+iofB7yA=on2N5ZiqXz8onZZPtGFgo7yA@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 30, 2017 at 7:36 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-09-29 at 13:09 -0700, Matthew Garrett wrote:
>> If the security metadata is different then copying another
>> security.evm will fail, surely?
>
> A copy of the file could exist with a valid hmac on the system with
> different security xattrs.  Without the inode/uuid, the xattrs could
> be cut & pasted.

So we have /usr/bin/a and /usr/bin/b, which are identical but have
different security contexts. Outside some unusual cases, if I have the
ability to modify /usr/bin/b's security.evm, I can delete /usr/bin/b.
I can then also just do:

ln -f /usr/bin/a /usr/bin/b

and /usr/bin/b now has the same security context as /usr/bin/a,
including security.evm.
