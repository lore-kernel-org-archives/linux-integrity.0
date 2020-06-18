Return-Path: <SRS0=tgSf=77=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F147C433E0
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0AF20B1F
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nBOIJx1b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k6XQ29Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFRTS7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:18:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44494 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgFRTS7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 15:18:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DE3C58EE181;
        Thu, 18 Jun 2020 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592507938;
        bh=x6FrWvTnfZ/GlB+YCnL0wfn/a3OsPRk4p9KX7tVZJcw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nBOIJx1bYA6OGVfRlBmwSqgci8hN3+m/kBL3778yteglY+55vT9QmYVTTp2sCegj1
         kgR8v6EgDQfBGbPxc+mL3ak/CdmFrxj+/uMY4f1ijCxsbkhSoPUxbAoAogzOO9WW0G
         Xys3cXGbzvrUh85bNE3UBG7sFWL0+fsR9PpxWz5c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5146Snh5mdFF; Thu, 18 Jun 2020 12:18:57 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B7E538EE0EA;
        Thu, 18 Jun 2020 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592507937;
        bh=x6FrWvTnfZ/GlB+YCnL0wfn/a3OsPRk4p9KX7tVZJcw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k6XQ29CtsLtVtkr0vTwC4aNzP/mq62lwKBJl7I1OKezqdKQl6DtLqdMbNLbbPxgFB
         9GeFOBA4uNFgBq0RTM/pKjqL9IeS45WIc1XyBPuknSVz8JUFBZsJH7hr9xhGz4LdK7
         XTjwUxUENpqWTlQ3pJBZESm4YEd3+EEr/zxLjSAs=
Message-ID: <1592507935.15159.5.camel@HansenPartnership.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Date:   Thu, 18 Jun 2020 12:18:55 -0700
In-Reply-To: <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
         <20200604175851.758-2-maxim.uvarov@linaro.org>
         <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
         <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
         <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
         <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 10:42 +0530, Sumit Garg wrote:
> On Thu, 18 Jun 2020 at 10:29, Sumit Garg <sumit.garg@linaro.org>
> wrote:
[...]
> > > typedef struct
> > > {
> > >         uint32_t timeLow;
> > >         uint16_t timeMid;
> > >         uint16_t timeHiAndVersion;
> > >         uint8_t clockSeqAndNode[8];
> > > } TEE_UUID;
> > > 
> > > (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
> > > 
> > > - The spec does not mandate any particular endianness and simply
> > > warnsabout possible issues if secure and non-secure worlds differ
> > > in endianness.
> > > - OP-TEE uses %pUl assuming that host order is little endian
> > > (that is true for the Arm platforms that run OP-TEE currently).
> > > By the same logic %pUl should be fine in the kernel.
> 
> I think Linux adheres to this RFC [1] for UUID byte order. See below
> snippet from section: "Layout and Byte Order":
> 
>    The fields are encoded as 16 octets, with the sizes and order of
> the
>    fields defined above, and with each field encoded with the Most
>    Significant Byte first (known as network byte order).  Note that
> the
>    field names, particularly for multiplexed fields, follow
> historical
>    practice.

Actually, that's not quite true.  We used to support both little and
big endian uuids until we realised it was basically microsoft vs
everyone else (as codified by RFC 4122).  Now we support UUIDs which
are big endian and GUIDs which are little endian.  This was the commit
that sorted out the confusion:

commit f9727a17db9bab71ddae91f74f11a8a2f9a0ece6
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 17 10:02:48 2017 +0200

    uuid: rename uuid types

so if you're using a little endian uuid, you should probably be using
GUID for TEE_UUID.

James

