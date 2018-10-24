Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A87C004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82D2075D
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpYK948W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJXRpX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:45:23 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36301 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRpW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 13:45:22 -0400
Received: by mail-lj1-f172.google.com with SMTP id s15-v6so4072332lji.3
        for <linux-integrity@vger.kernel.org>; Wed, 24 Oct 2018 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbtUFzosXnaCbK1pDBNZqtmkcUtkbnGp/C8rAohlQz0=;
        b=DpYK948W/f7FqVCftv7895ko/lDm3g3uGYoD9b9nyzL/ZF/Uiikohx/si7MpEduugd
         /yhJIL9Ok15/tRtIIH4e5Q76hcG+/gP0GEKAsx978NrOljXQ2cuow34XHjnjIZzk6UYL
         Aqq0ldGme8xzks/RTP902K22h96VrXQKTSb65sRuhFyO+ulBJ+I5soQvt/jw7q4g8xRd
         bSKWJkJVOlWjhpdu4EH4B3v/90CdNa3RO6rrS4oWge18bxljDjChUQS9yEcJlJXLiItG
         Fj+Y2kN2dJYStXdp3xk5nyg1kjTtcEijg83P7ec40ziyOPewCoOoxHVwbhcUqjVQU07k
         H6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbtUFzosXnaCbK1pDBNZqtmkcUtkbnGp/C8rAohlQz0=;
        b=WMokPq9OvJ6hRAOaeO+rYvxMlyKf7fzj73GuFe/20ZqBHZNV9EGq4sO5gOWmH1uwgk
         bj7Y6+RhNcTjtNmVLxri3H/qaRe4JN1Kop6vg9J+afswnxFLOTeQfllz8dpw/J4ty2Xz
         /tO8Dnh12P3B++dKAH3pMZcOXcY/zkaVkppT3I/aGyxoI/DHvqFoVpdtRv3+fzaT/Txd
         5MYiAkyy9gFiOFbjK+QhOCjtNHEsCT90kR5kWsaF+4tnsUMF/3v9w4/7EiU7iWHtcPGi
         qpkQjgpSdTmlq6VjROv7R//PglJH73kAIjArd5LJz0RVXSBRiETDC+hXeEXkbn32zQT1
         NYXQ==
X-Gm-Message-State: AGRZ1gKjpNzMmLO4s9CP4sU1bjHr30qQfkt8ZBiuI/VUW4f4oZ9uJOmT
        qRt0txKnqD3LXkwastG4gGCQguFgTjsM0PeP/Dc=
X-Google-Smtp-Source: AJdET5exmwX2QPf+08ZSj8MNY3m6VUsE4vXQxrX56E3OuKTLFkMwtJIhV9oiG+2M051gzD3CrQ7JM2mE9s4GOwNVWd0=
X-Received: by 2002:a2e:2b46:: with SMTP id q67-v6mr1175431lje.126.1540372682218;
 Wed, 24 Oct 2018 02:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810160946210.2779@namei.org> <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com> <20181011154847.GA5978@mail.hallyn.com>
 <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com> <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1> <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
 <alpine.LRH.2.21.1810160833560.14147@namei.org> <1539642523.2867.44.camel@HansenPartnership.com>
 <1369.1540301956@warthog.procyon.org.uk> <alpine.DEB.2.21.1810241144410.3525@jsakkine-mobl1>
 <1540371542.3008.29.camel@HansenPartnership.com>
In-Reply-To: <1540371542.3008.29.camel@HansenPartnership.com>
From:   Monty Wiseman <montywiseman32@gmail.com>
Date:   Wed, 24 Oct 2018 10:17:57 +0100
Message-ID: <CAMHw8A44V71x-_DHpYzyW1zav-OiT_Rxo9OdDM_V-2TmWAaFtw@mail.gmail.com>
Subject: Re: LPC 2018
To:     James.Bottomley@hansenpartnership.com
Cc:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        jmorris@namei.org, mjg59@google.com,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

David Safford doesn't arrive until tonight (Wednesday but I don't know
what time) so I think some of this will need to extend to Thursday.
I'll send him a private message just in case.
On Wed, Oct 24, 2018 at 9:59 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2018-10-24 at 11:45 +0300, Jarkko Sakkinen wrote:
> > On Tue, 23 Oct 2018, David Howells wrote:
> > > James Morris <jmorris@namei.org> wrote:
> > >
> > > > > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think
> > > > > you have
> > > > > a Wednesday overlap, though, so Wednesday would work.
> > > >
> > > > LSS is Thurs+Fri, but we may have a quorum for Weds.
> > >
> > > I'm getting to Edinburgh tomorrow, so I wouldn't be available
> > > before 3pm.
> > >
> > > Btw, will there be networking available to be used during speaking?
> > >
> > > David
> > >
> >
> > Just arrived to the airport. Pick a time. For me any time after 3PM
> > should work.
>
> OK, let's say 18:00 in the Moffat room level -2 of the convention
> centre.
>
> James
>
