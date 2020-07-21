Return-Path: <SRS0=egUB=BA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD72C433E0
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jul 2020 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980322077D
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jul 2020 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="od9rT0xr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="od9rT0xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUPwx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:52:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35502 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgGUPwx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 11:52:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E97808EE269;
        Tue, 21 Jul 2020 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595346771;
        bh=ompeI2KOdzwq10DFB0ciA/OBKqjxP214DyyE59Yld14=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=od9rT0xrbskHFTGRHC2rdw0HuKWEcbCj7yaxRvCgMRgo+wS7E8IgIeCxV9VZACVEI
         hCgbfB/a4JzLAbvGzckBUek2kM26yZy2wxGfsi2JRPNsv2N7z3zgDgKIMV/WUg9RKK
         Ww6u6RC2D7Ujyn1aKfxIW46eACGVgpMs9VEwIoZo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uB3XGhWczRs4; Tue, 21 Jul 2020 08:52:51 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 493048EE207;
        Tue, 21 Jul 2020 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595346771;
        bh=ompeI2KOdzwq10DFB0ciA/OBKqjxP214DyyE59Yld14=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=od9rT0xrbskHFTGRHC2rdw0HuKWEcbCj7yaxRvCgMRgo+wS7E8IgIeCxV9VZACVEI
         hCgbfB/a4JzLAbvGzckBUek2kM26yZy2wxGfsi2JRPNsv2N7z3zgDgKIMV/WUg9RKK
         Ww6u6RC2D7Ujyn1aKfxIW46eACGVgpMs9VEwIoZo=
Message-ID: <1595346768.4494.15.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 21 Jul 2020 08:52:48 -0700
In-Reply-To: <1595346474.5109.37.camel@linux.ibm.com>
References: <20200720150038.9082-1-James.Bottomley@HansenPartnership.com>
         <20200720150038.9082-2-James.Bottomley@HansenPartnership.com>
         <1595334627.5109.23.camel@linux.ibm.com>
         <1595344015.4494.9.camel@HansenPartnership.com>
         <1595346474.5109.37.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-21 at 11:47 -0400, Mimi Zohar wrote:
> On Tue, 2020-07-21 at 08:06 -0700, James Bottomley wrote:
> > On Tue, 2020-07-21 at 08:30 -0400, Mimi Zohar wrote:
> > I think the sysfs output should be a pure hash to save having to
> > massage it.  However, if you want the 1.2 format, this is the
> > script I
> > use:
> > 
> > a=0; while [ $a -lt 24 ]; do printf "PCR-%02d: " $a; cat
> > /sys/class/tpm/tpm0/pcr-sha1/$a; a=$[$a+1]; done
> 
> The TPM 1.2 format is a bit different,

You mean the spaces between each byte?  I can persuade the script to do
that, but there didn't seem to be much point given that everything I've
seen that uses the hashes has to remove it.

>  but this provides the PCRs and digests sequentially.

Right.

I've got the v2 that should work on TPM 1.2 if you can test it for me? 
My TPM 1.2 machine is somewhat infrastructure critical, so I have
difficulty rebooting it.

James

