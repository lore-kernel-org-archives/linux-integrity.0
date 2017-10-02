Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:56530 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdJBUH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 16:07:27 -0400
Received: by mail-io0-f175.google.com with SMTP id e9so381271iod.13
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 13:07:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506974574.5691.304.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com> <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
 <1506715304.5691.151.camel@linux.vnet.ibm.com> <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
 <1506825397.5691.186.camel@linux.vnet.ibm.com> <CACdnJuv11cjDHac6M+iofB7yA=on2N5ZiqXz8onZZPtGFgo7yA@mail.gmail.com>
 <1506974068.5691.300.camel@linux.vnet.ibm.com> <CACdnJutYw7Pgh-EwWuwp9Wz+5KzoreZVr+c6UV30zC__8FZSVA@mail.gmail.com>
 <1506974574.5691.304.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 2 Oct 2017 13:07:26 -0700
Message-ID: <CACdnJuuYGT7fTeGhm8=z-G2AXr__3oXjtojtve-QCnyA+VCN1A@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 2, 2017 at 1:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-10-02 at 13:00 -0700, Matthew Garrett wrote:
>> If /home is on the same filesystem as / (which is a pretty common
>> case) then ln -f /usr/bin/a /home/bin/b will work just as well.
>
> Yes, assuming you have permissions on the running system.

But if I don't have permissions, I can't just cut and paste
security.evm either - even if I can write to security.evm, the only
way the HMAC would match would be if I could change the ownership as
well, which implies being root.
