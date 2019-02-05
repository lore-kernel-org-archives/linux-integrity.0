Return-Path: <SRS0=fuDz=QM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F18C282CB
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E712020811
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfBEScH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:32:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33985 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBEScH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Feb 2019 13:32:07 -0500
Received: from mail-yb1-f199.google.com ([209.85.219.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gr5Vs-0008Kc-MT
        for linux-integrity@vger.kernel.org; Tue, 05 Feb 2019 18:32:04 +0000
Received: by mail-yb1-f199.google.com with SMTP id m200so1960733ybm.9
        for <linux-integrity@vger.kernel.org>; Tue, 05 Feb 2019 10:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FVlBFbZ/Rf8EhhvuHPQNiF+bYJe2E/F4dl2//NQxB6s=;
        b=BrTYag58PTNs86JkAMiR9NI/JXzXqCKjgiFW2+BhFpOmgE4DyjXsm9Kyk0pMzQ3NmX
         xK4KahD99IKLUVcHYEiIze1Jv7Ah3WFTV1eJvsLhTBx+8GbnAYkc8qYwaD+bUY48iwJq
         lGypb6TV3yromxnQZ4q2KFphcZkCB8dZADWebHv6TJNEmHPjizWurt7fxjaPrEdN7tA9
         5KuzGZuD+75q4lpQbVtvHXJuuwVBb36SVlZJspvqaDzJfqomgiohZ63vlzvF7j59tKXC
         P2B3wV/sxp1PGZEZ353TNTKjRHCA0Q3TJ4DNBqSJqIoVVBzQKqAyiHQjM3z/ktAn6zeJ
         fo4A==
X-Gm-Message-State: AHQUAuZCs1Ibkq0EFBbSBe4HEUptVBYWsAkJphg661h9NLrBsFBNCBLj
        izgnhRBDN8fZ4DKpH4AnDGT483k/eaEcmHQzfKGjfM1dgMLrvgiSG6A9e9eKEJCdSykh4+yqnyy
        0WMgcLnykG6jULcDQd9+lntKzm3VaiMprB5iJbtRvEJBG0Q==
X-Received: by 2002:a25:ca83:: with SMTP id a125mr3034482ybg.45.1549391523664;
        Tue, 05 Feb 2019 10:32:03 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbGiAuQ5FUu3eHG8ZYvWmgqLHxC/Y5AGQWoUmLCdi0ABBDyZHzdiR8hCZKvi85lDCT++uG86A==
X-Received: by 2002:a25:ca83:: with SMTP id a125mr3034447ybg.45.1549391523309;
        Tue, 05 Feb 2019 10:32:03 -0800 (PST)
Received: from localhost ([2605:a601:ac2:fb20:ac97:1957:a992:bb67])
        by smtp.gmail.com with ESMTPSA id t129sm1748534ywe.11.2019.02.05.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:32:02 -0800 (PST)
Date:   Tue, 5 Feb 2019 12:32:01 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190205183201.GA3218@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
 <20190205151859.GD16362@ubuntu-xps13>
 <1549385244.4146.148.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549385244.4146.148.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 05, 2019 at 11:47:24AM -0500, Mimi Zohar wrote:
> Hi Seth,
> 
> On Tue, 2019-02-05 at 09:18 -0600, Seth Forshee wrote:
> > On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > > Require signed kernel modules on systems with secure boot mode enabled.
> > > 
> > > To coordinate between appended kernel module signatures and IMA
> > > signatures, only define an IMA MODULE_CHECK policy rule if
> > > CONFIG_MODULE_SIG is not enabled.
> > > 
> > > This patch defines a function named set_module_sig_required() and renames
> > > is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> > > call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> > > being enabled.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > With respect to interactions with the kernel lockdown patches, this
> > looks better than the patches I saw previously. I don't feel like I know
> > enough about what's going on with IMA to ack the patch, but I feel
> > confident that it's at least not going to break signature enforcement
> > for us.
> 
> Thank you for testing!  Could this be translated into a "tested-by"
> "(for w/lockdown patches)"?

Yeah, that's fine. To be clear about what I tested, I've confirmed that
it doesn't interfere with requiring signed modules under lockdown with
CONFIG_IMA_ARCH_POLICY=n and IMA appraisal enabled.

Tested-by: Seth Forshee <seth.forshee@canonical.com>
