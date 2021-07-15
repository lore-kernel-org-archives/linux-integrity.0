Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DADC07E96
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Jul 2021 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54270613C9
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Jul 2021 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhGONJP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:09:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51620 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 09:09:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8D5C1FE23;
        Thu, 15 Jul 2021 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626354380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFGaUwLk1CVbCDEQ54lE/zDZaf3+fCphO/iJdUeWeiA=;
        b=XEbWzaqrFJpi/azQAhZdgUg6oCqdGJXBA2qqitQSRJgz3flsbmkOb/1bu93HH0peW1ibuN
        wazBrgcUYK3GYo8dXl9/0xcFSnkR0XI8xbwgGxej9cKsC7unXMSjAvBC49QEoV1obEZZWZ
        o2TR33X8sLQJ2jQNpcNFezS4L3MGbBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626354380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFGaUwLk1CVbCDEQ54lE/zDZaf3+fCphO/iJdUeWeiA=;
        b=qhcgH29l0zZ91ybxwytZb2kDcSGox4Of7HAbxuBzvxOjPPFl9IEeFNkAb9rYAaR3GA+5sJ
        0tY7rY+Ma2/Y/3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2BE113A81;
        Thu, 15 Jul 2021 13:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMF+L8sy8GDBSQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 15 Jul 2021 13:06:19 +0000
Date:   Thu, 15 Jul 2021 15:06:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm
 for sign and verify
Message-ID: <YPAyydrnxyq3l0XK@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
 <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
 <YO/YFAEWN5VzYIsQ@pevik>
 <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia, all,

> evmctl itself relies on openssl version 1.1.1 or lower. I guess, openssl 3.0
> needs to be compiled and install to a non-standard path, such as
> /opt/openssl, otherwise it will affect the subsequent compilation of evmctl
> in build.sh.

OK, IMHO Debian does not allow to install both version together. I suppose
openSUSE does, but understand if it's just easier to compile it to /opt/openssl.

> Of course, compile openssl 3.0 from source code. must to limit
> the number of instances to avoid excessively increasing the time-consuming
> in CI. Is that right?
+1

Kind regards,
Petr

> Best regards,
> Tianjia
