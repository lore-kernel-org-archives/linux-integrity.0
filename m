Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C28C433EF
	for <linux-integrity@archiver.kernel.org>; Sat,  4 Sep 2021 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAEC608FB
	for <linux-integrity@archiver.kernel.org>; Sat,  4 Sep 2021 10:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhIDKW3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:22:29 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53534 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbhIDKW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 06:22:29 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1EAFA72C8B0;
        Sat,  4 Sep 2021 13:21:26 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0494F4A46FC;
        Sat,  4 Sep 2021 13:21:26 +0300 (MSK)
Date:   Sat, 4 Sep 2021 13:21:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] evmctl: Implement support for EVMCTL_KEY_PASSWORD
 environment variable
Message-ID: <20210904102125.pibbu7xl5t6gosmi@altlinux.org>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
 <20210810134557.2444863-2-stefanb@linux.vnet.ibm.com>
 <8617ee0a7738ff2a5310efeca6d194339cf86560.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <8617ee0a7738ff2a5310efeca6d194339cf86560.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi, Stefan,

On Fri, Aug 27, 2021 at 05:37:35PM -0400, Mimi Zohar wrote:
> [Cc: Vitaly]
> 
> On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > If the user did not use the --pass option to provide a key password,
> > get the key password from the EVMCTL_KEY_PASSWORD environment variable.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.
> 
> Vitaly, I'm not sure that there's any benefit of using secure heap for
> a password stored as an environment variable, but it needs to at least
> be documented.

I did not receive this patch nor it's in the git.

Thanks,

> 
> thanks,
> 
> Mimi
