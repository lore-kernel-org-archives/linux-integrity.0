Return-Path: <SRS0=Vrnv=N6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE1C43441
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Nov 2018 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3EE2089F
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Nov 2018 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lxZbU4CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3EE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeKTHop (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:44:45 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41330 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbeKTHop (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Nov 2018 02:44:45 -0500
Received: by mail-pf1-f181.google.com with SMTP id b7so2221645pfi.8
        for <linux-integrity@vger.kernel.org>; Mon, 19 Nov 2018 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TAGN1Ih0aHHDJlDm5nWA84tUR6AInyMXsIY4amoRhM=;
        b=lxZbU4CIX3oSl9bevdLJB6EvURnyxP1N2ESf/hDfv43wc5B+PWdZBFzepCnFPQnW0q
         yOEZkywRzkNDHITz4YHoGkikTf3a5i9nt+uly13UOOQ3hicBXKqGdiVEUArsxLpqsA0l
         dERV8jhOQFOdJmyx6VDIU2h+FCJHIwuWVmbLNJLk8uLWem63wYwSjLXW9umDgoLtWgz1
         60l/MtvPfDoWDbfai45iKvC2DqhXXIPVqikYwMTUegyCr2CqQdcCgtdRN0+6PXEttey2
         huGPmMEs2GoQAYkhQ8aCrEAmRRi4qg2dFyBXBpxdn1nwVkniC1cxtR6vOrLkpUdDWjNS
         JoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TAGN1Ih0aHHDJlDm5nWA84tUR6AInyMXsIY4amoRhM=;
        b=Sv7EYgpmcVdh/FJGhBYtqzQ5yEcxgsax9uLwnZKs71Dnm2B7j6vw1n6IxovNXq9nmm
         Fk+Hk3qAQIe/o9BBk1UZqb3bGVnUszzCZA1YTTiccKvDPeGbkMH1K2Rw9rchngdwR4mQ
         t6iiajOsT02SsVISoLKSbYjjZNxbi1aWQLVzAWhPwVnR6O3A8ZCJmFJPBrudH+Amqctn
         uOfmWveivLYNZDIjPc6Y5LwCNuzs3VMn2CGdGQ5sP7wCGxsB3u+v86gEkpl64vSRvyX1
         SZZXcG12YDC3KrXSgJVX+AF808dy45+9W55xxCefX0LENECEffDv2VOCZpcWRIwXBQ0u
         6POg==
X-Gm-Message-State: AGRZ1gJYzjeZjrMYipoSfQg/rI+oFiGNyPfPDBzo4mUsga2JXwLdE+jR
        LlNcUw9JNceDv+SVZYkdOP/X8w==
X-Google-Smtp-Source: AJdET5csfBiJwRpag/bwm+QuGzlXABbhXbNiHSWmTcptkRj7GdDiRZseOF3AAJjWtCQo9M9GmK1ksQ==
X-Received: by 2002:a62:8915:: with SMTP id v21-v6mr25028328pfd.137.1542662354115;
        Mon, 19 Nov 2018 13:19:14 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y1sm2435143pfe.9.2018.11.19.13.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:19:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOqwp-0006W5-Qf; Mon, 19 Nov 2018 14:19:11 -0700
Date:   Mon, 19 Nov 2018 14:19:11 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181119211911.GH4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181119200505.GF4890@ziepe.ca>
 <1542658839.2910.32.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542658839.2910.32.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 19, 2018 at 12:20:39PM -0800, James Bottomley wrote:
> On Mon, 2018-11-19 at 13:05 -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 19, 2018 at 09:34:04AM -0800, James Bottomley wrote:
> > 
> > > The current state of the art for snooping the TPM Genie hardware
> > > interposer https://www.nccgroup.trust/us/our-research/tpm-genie/
> > > which
> > > is a simple external device that can be installed in a couple of
> > > seconds on any system or laptop.  However, the next phase of
> > > research
> > > seems to be hacking existing devices on the bus to act as
> > > interposers,
> > > so the fact that the attacker requires physical access for a few
> > > seconds might evaporate.  However, the goal of this document is to
> > > protect TPM secrets and integrity as far as we are able in this
> > > environment and to try to insure that if we can't prevent the
> > > attack
> > > then at least we can detect it.
> > > 
> > > Unfortunately, most of the TPM functionality, including the
> > > hardware
> > > reset capability can be controlled by an attacker who has access to
> > > the bus, so we'll discuss some of the disruption possibilities
> > > below.
> > > 
> > > Measurement (PCR) Integrity
> > > 
> > > Since the attacker can send their own commands to the TPM, they can
> > > send arbitrary PCR extends and thus disrupt the measurement system,
> > > which would be an annoying denial of service attack.  However,
> > > there
> > > are two, more serious, classes of attack aimed at entities sealed
> > > to
> > > trust measurements.
> > > 
> > > 1. The attacker could intercept all PCR extends coming from the
> > > system
> > >    and completely substitute their own values, producing a replay
> > > of
> > >    an untampered state that would cause PCR measurements to attest
> > > to
> > >    a trusted state and release secrets
> > > 
> > > 2. At some point in time the attacker could reset the TPM, clearing
> > >    the PCRs and then send down their own measurements which would
> > >    effectively overwrite the boot time measurements the TPM has
> > >    already done.
> > 
> > I can just de-solder the TPM, attach it to a rig and do whatever I
> > want to it, including fake PCR loads and trigger seal/uneal of any
> > data I like.
> 
> You wouldn't be able to resolder the TPM without causing a reset and
> losing the PCR values.

The attacker would issue extend commands and reload the PCR values.

In the PCR thread model the data used in TPM extend commands is not
considered secret.

ie for extends issued by linux, these are all easy to compute, we have
the source code and there is no secret information mixed in. Get a
copy of /boot and you know the values.

For the BIOS, this might need some inside info, or reverse
engineering, but it is still not secret. Ultimately it is various
hashes of static information stored in flash. At worst inserting a
false TPM would capture the information once for a specific hardware..

> The TPM is not designed to be secure against physical attacks that go
> after its internal seed values, that's true.  It is supposed to be
> secure against attacks that go after the information transmission into
> and out of the TPM, which is what the interposer is doing

The TPM is supposed to be secure in the sense it will not disclose its
internal secret information on its pins. De-lidding and other physical
things may disclose the information.

However, the PCR security model is a bit different, and hinges on a
cascading chain of trust. The very top of that chain is the PCB the
TPM is installed in, and from there it goes to the other chips
installed on the PCB, then the code in the BIOS, etc.

Break the PCB and you break the top of the chain of trust. All
security of the PCR is totally lost. Adding more encryption down the
line can't fixup the broken top of chain of trust.

This is why I don't think it makes sense to consider a threat model
for PCRs that contemplates any manipulation of the PCB..

> > The treat model for PCR users always contained the implicit
> > assumption that the security of the physical TPM HW, and the secure
> > linkage to the CPU (ie secure control over reset, and other things)
> > is maintained.
> > 
> > So, I'm not sure adding more crypto here really fits with the threat
> > model the TPM lives in?
> 
> It is, because the attack is a man in the middle, even if it's at the
> bus level, which TPM crypto and HMAC is supposed to thwart.

Sure, for stuff working with shared secrets, etc, this make sense. But
PCR extends are not secret, so there is no reason to encrypt them on
the bus.

And if someone manipulates the unencrypted PCR extend commands then we
are back to 'the PCB is broken' and all PCR based security has been
lost.

> In theory, but we don't seem to have one.  The theory is that TPMs come
> provisioned according to the TCG guidance which specifies RSA and
> EC storage keys be at 81000001 and 81000002 respectively ... it just
> seems that the current TPM generation don't respect this, so they come
> with no permanent keys at all.

Seems surprising.. And the use models you have don't alwaus load a key
that could be used for this?

Jason
