Return-Path: <SRS0=+7J6=RV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A32C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385932133D
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gEQR4STn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCRSTj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:19:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55220 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfCRSTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 14:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CFE938EE11D;
        Mon, 18 Mar 2019 11:19:38 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QWd-Syly60Qb; Mon, 18 Mar 2019 11:19:38 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4B1748EE10A;
        Mon, 18 Mar 2019 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552933178;
        bh=NfZhJ6DEgiGiBhQB3cABMWG/ZcQvDvvSO+0DSvhzpIA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gEQR4STnDvaghgFPyheKfDjnuJi2vcFg3vHrLhqc9zXXHeIZKrHMzlU14El9aHJv2
         vnjAYS06t5dG7NmeQBO8uv4nzW/mDjm/bUWwtyWgBuxS55Q7oiu0VyEUSjly19VY0/
         o//jqeIfsyLEziDt3L0u7RIewplD10VIrMLk+X3U=
Message-ID: <1552933175.3203.40.camel@HansenPartnership.com>
Subject: Re: [openssl-tpm2-engine] tpm sessions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     openssl-tpm2-engine@groups.io, doug.fraser@veea.com,
        "Ibmtpm20tss-users@lists.sourceforge.net" 
        <Ibmtpm20tss-users@lists.sourceforge.net>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 18 Mar 2019 11:19:35 -0700
In-Reply-To: <BN7PR04MB4356C4D43F8DC4DB2812F9C084470@BN7PR04MB4356.namprd04.prod.outlook.com>
References: <BN7PR04MB4356C4D43F8DC4DB2812F9C084470@BN7PR04MB4356.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-03-18 at 18:03 +0000, Doug Fraser wrote:
> So we have moved beyond the signaling issues on our TPM for now, but
> in ramping up performance saturation testing, I am pounding on the
> openssl engine with multiple threads of execution, and I am finding
> this fault.
> 
> /var/log/messages:Mar 18 16:43:28 C05BCB00C0A000001153 kern.err
> kernel: [11840.869864] tpm tpm0: tpm_try_transmit: tpm_send: error -5
> /var/log/messages:Mar 18 16:43:28 C05BCB00C0A000001153 kern.err
> kernel: [11840.878969] tpm tpm0: A TPM error (357) occurred flushing
> context

This sounds a bit serious.  I've taken the liberty of cc'ing the linux-
integrity group which is the mailing list where kernel based TPM issues
get discussed.  Error -5 is EIO which still points to a TPM
communications problem.

> Within the kernel, reflect up through the applications as:
> 
> TPM2_StartAuthSession failed with 2309
> TPM_RC_SESSION_HANDLES - out of session handles - a session must be
> flushed before a new session may be created
> Failed to get Key Handle in TPM EC key routines
> 
> The underlying tss code is build with:
> 
> CCFLAGS +=  -DTPM_POSIX \
>         -DTPM_INTERFACE_TYPE_DEFAULT="\"dev\""  \
>         -DTPM_DEVICE_DEFAULT="\"/dev/tpmrm0\"" \
>         $(BLD_SYSROOT)
> 
> So we should be using the tpmrm  resource manager within the kernel.

The answer should be yes because without it you'll exhaust the TPM
resources in a multi-threaded environment.  The TPM has severe limits
(like 3) on the number of keys which can be active at any given time.

What is happening in the tpmrm situation is that you get one resource
manager instance for every separate open of /dev/tpmrm0 but also every
TPM operation you try results in a resource manager context save and
load for ever volatile key handle and session ... essentially it will
be more than tripling the TPM transaction load, since the way the
openssl engine works, it usually needs the parent key, a session and
the actual key you're loading every time you do something.

once a resource manager context flush fails we actually get left with
whatever handle it was trying to flush stuck in the TPM which will lead
to resource exhaustion.

> If I run the test code as a single instance, this never occurs
> (within the bounds of 64 hours of constant running)
> 
> Is there a practical limit to the openssl engine, underlying tpmrm,
> or even the underlying physical block that I am ignoring here?
> My view was that as long as you pass through the tpmrm, you might
> stall, but the resources would be managed.

Right, the resource manager is supposed to make the TPM scalable. 
There is a hard limit (64 usually) on the number of active sessions you
can have even with a resource manager, but I don't think you're hitting
that.

James

> I am going back to dig through tpm-tis, in particular, tpm2-cmd.c and
> tpm-interface.c.
