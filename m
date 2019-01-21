Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C61C37121
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D14A2089F
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LYAKo+SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfAUTvK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:51:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfAUTvK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 14:51:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so10266316plt.11
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jan 2019 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MC0oD+e3JMrKAMFE+atvsymbvoMH+9Q7pkkOLjdbKuQ=;
        b=LYAKo+SA+kFq2LEqpFfqXH1QUdaJUjAAzx4yg6/KkI/COVr/uXJYQHLGKmvscsfWPK
         N0ABYmlxdhUdNZSNYWMsfomWdmnZl+GoRkMg/V7AOQNBxjaj3cOxJfyLBUQlV7YWpf5s
         ByYF6UqRBK6Sc4cK3lGyZz/CmAT4pL6JxsvW1igGs/gjrVB1zupXjm5abZ3BzHOwWGJJ
         VqciYYp1IodORgzgQYAGKdUo3cPR/WkOMWXZ9s5Lo6XfXSWkVrDsi+oucX5JNc26xZ0w
         gWm++Jea6xF41qGnXJKDowogdu1pcV5PLkyhGT9tDvX/E0GYz/OGsVQyLkGjideEBupo
         DTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MC0oD+e3JMrKAMFE+atvsymbvoMH+9Q7pkkOLjdbKuQ=;
        b=Oc4tNaVo3XrUzqKt6geI/qkdYXwhOaHHHBC1H3vybFkXeiR+yxueZHoyF0C+Krq8pb
         wWvlFUyViiQNOQljV9R9bnPXypWG+xpG4i08XU26MblwFh11qZGlgrVL9gZzzT8ow/Fz
         YFLpiGOK2FU9l+mK9i0Zl9k8ab6MKxZHgdztvLmW8JpFd0KMD6laxs6l5jKG8ZZkvZfu
         Zm2Oq6g1hqHBCLH7GXn3+qhk7YMJ5x+qZA1vb8G+i5ZVGwOBNGFiqHlH5oNtkvLX7NZU
         V0Xuv4L/T3fTIcLV0M5sv1tVRU7IBgE+Rygau+OrOFILZWbXHySwI4IlbC+iIYQtjlZO
         XRCg==
X-Gm-Message-State: AJcUukc+FCV4sGgou4/D/Frd5YPd67wLwpwnU4w4tFgG/m7GEEjeoGDZ
        26gp4Q/Zk8caDFE2pGImvFBJxaZrs6Q=
X-Google-Smtp-Source: ALg8bN5KiGYT1EEmC3hYslPsWy7CrbYXC7qf2Qs23EBvsUniyVCsABWWYZMVkpnuMHE7jwSzDdcQag==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr30222092plg.250.1548100269425;
        Mon, 21 Jan 2019 11:51:09 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 84sm31822828pfa.115.2019.01.21.11.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 11:51:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1glfb9-0001sT-5C; Mon, 21 Jan 2019 12:51:07 -0700
Date:   Mon, 21 Jan 2019 12:51:07 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     oshri.alkoby@nuvoton.com, Dan.Morav@nuvoton.com,
        nayna@linux.vnet.ibm.com, dana.cohen@nuvoton.com,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx
Message-ID: <20190121195107.GE25163@ziepe.ca>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
 <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
 <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
 <20190121165848.GC25163@ziepe.ca>
 <CFC10279-4983-4EF7-8323-CFF29674D80A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFC10279-4983-4EF7-8323-CFF29674D80A@gmx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 21, 2019 at 08:16:04PM +0100, Peter Huewe wrote:
> Am 21. Januar 2019 17:58:48 MEZ schrieb Jason Gunthorpe <jgg@ziepe.ca>:

> >But the device compatabile string should still be something like:
> >
> > 'nuvoton,npct751','tcg,tpm-i2c-ptp'

> Since there are no quirks and no existing bindings, I would advise
> for tcg,tpm-i2c-ptp only.

At least at one point the advise was to always add a very specific
compatible string to the binding - this way if we find a problem with
that chip in the future the driver can match that string.

Jason
