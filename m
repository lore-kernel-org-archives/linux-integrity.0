Return-Path: <SRS0=Vrnv=N6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF4C43441
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C6220870
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SeyIvBq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C6220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeKTIKF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:10:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38845 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeKTIKF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Nov 2018 03:10:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so7479179pfi.5
        for <linux-integrity@vger.kernel.org>; Mon, 19 Nov 2018 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8jHgR4aM7cVTQPE9d7J9DTe5Kdw9anN0OemqiiuIho=;
        b=SeyIvBq+zDPYlmU9EO9yQUwmxBJhWtbz+ImNwXKe5vNH/uXkh6TEc5eKo627gFRN9D
         s/Vm1CCRpyyBULTu6TzCHJfWghFOt6zpd+eIudkSGqsXfVLqojhNrqeM40pwimzH+Y+B
         oE50UYXwZYHnMmr9W/D2nAF5bz6XtDcVOUHKwBxUuauk3h2FvzjpIyRwwiN+wos9SAfT
         WNLircoPxEIo0E1bkI49WcepwIv8bCeRenwjtV7SHn2urtNJRKzIY455gEMW+7nz/JI6
         rLhJnHl1G80XGQ5fAyTjfJxr4PlT+ol05nJlrARVypKytf/luRlWE+lBcEClCNIh58SK
         TenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8jHgR4aM7cVTQPE9d7J9DTe5Kdw9anN0OemqiiuIho=;
        b=ereQZvOTHw/Hmc8WRqjTjkKu0ECPng+EHGkIDF+TV/mGIxjmIdqi/oau+ZaFk8ho1W
         UKoXYaaPxILdmFRdzQRz4qVaY3oGKXQw+9Tlnc3lWah/QovzA4vZOKQJkYSP0/OpwQBc
         2/irNApJ7GsJN+aQEQ3KYvE+ntESkiSYXi6c0cTwTORXpf/nZgV3y16sdAcOO3y4ikJJ
         Y0BrRZt2P/6UoMLHQaVeMEXT2cdm3Gfuo9cAhiZtykDCijbTJfdK4aaZkZV8sZV5wIb9
         RLC5IyNuqUlNWVe5MX0YsaTjNB156GxpwxVeoPgn2JIYcRCwMj+E2cu+BbGRiX26TulU
         mJOw==
X-Gm-Message-State: AA+aEWa2hqxmzaLHKmVAHVHr9SNnCuqbTUD0IUufRekFry81V0dwGsFA
        Ek9d6kS8/0Rzj1ny3/5HjzcuoumvoT4=
X-Google-Smtp-Source: AFSGD/XWqe6wyLGu1LWQvhwOEb21/58gOktMMGvijMnksV40fYsjR0AUxMhNipUNy9M4e6xc06zsEg==
X-Received: by 2002:a65:6392:: with SMTP id h18mr12191641pgv.107.1542663867744;
        Mon, 19 Nov 2018 13:44:27 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v9sm13469331pfe.49.2018.11.19.13.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:44:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOrLG-0006ga-5y; Mon, 19 Nov 2018 14:44:26 -0700
Date:   Mon, 19 Nov 2018 14:44:26 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181119214426.GK4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181119200505.GF4890@ziepe.ca>
 <1542658839.2910.32.camel@HansenPartnership.com>
 <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542663281.2910.44.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 19, 2018 at 01:34:41PM -0800, James Bottomley wrote:
> On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
> [...]
> > Sure, for stuff working with shared secrets, etc, this make sense.
> > But PCR extends are not secret, so there is no reason to encrypt them
> > on the bus.
> 
> OK, there's a miscommunication here.  I believe the current document
> states twice that there's no encryption for PCR operations.  We merely
> use a salted HMAC session to ensure that they're reliably received by
> the TPM and not altered in-flight.

Sure, but again, what is this preventing?

If you accept that PCB trust is essential for PCR security, then I
think trusting the PCB to deliver the PCR extends is perfectly fine.

> > > In theory, but we don't seem to have one.  The theory is that TPMs
> > > come provisioned according to the TCG guidance which specifies RSA
> > > and EC storage keys be at 81000001 and 81000002 respectively ... it
> > > just seems that the current TPM generation don't respect this, so
> > > they come with no permanent keys at all.
> > 
> > Seems surprising.. And the use models you have don't alwaus load a
> > key that could be used for this?
> 
> I think it's because Microsoft realised after the first generation of
> TPM 2.0s that not having any key at all was a problem, so lots of them
> shipped before the spec got updated and manufacturers are somewhat slow
> to retool production lines.  My TPM 2.0 doesn't even have an EC
> certificate (although Nuvoton now claims this was a manufacturing
> mistake) never mind a derived primary key.

Ah, the usual mess in TPM land then :)

Jason
