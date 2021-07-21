Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D13C12002
	for <linux-integrity@archiver.kernel.org>; Wed, 21 Jul 2021 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2335A61003
	for <linux-integrity@archiver.kernel.org>; Wed, 21 Jul 2021 15:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbhGUOzG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:55:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhGUOzG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 10:55:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DBD822460;
        Wed, 21 Jul 2021 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626881742;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USyBwvywj/1KzHV368m1dOrzLpLTNcKR29Sqr/+0EFc=;
        b=IObi1VT41AT60tzhj1uq3ujZLRkUlM1SgesIwM1LJRQbcSljjm1Dnetq33bxEemsXwwGVY
        9Vj/O09O9vbVoO9lCpf1wYxjq6DGKSLJAgrt9hFEU9JoY0GQRoYrpDrPIb6yAlAp5tW+jL
        8AGZ0HJoTEu61qxxSjQSu3KjpXZ2raU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626881742;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USyBwvywj/1KzHV368m1dOrzLpLTNcKR29Sqr/+0EFc=;
        b=/M+UACC+j8SdpBKA1jAE8L8DZQlehw5nyh+BihPZy4wodYogagu86TUW4Sv8NDcOY+uts+
        o/Tl5Uq0tdhwLbCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A34D313C02;
        Wed, 21 Jul 2021 15:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id X5dpJcw++GDHNgAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Wed, 21 Jul 2021 15:35:40 +0000
Date:   Wed, 21 Jul 2021 17:35:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v7] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
Message-ID: <YPg+ye5KujvWUKNa@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210721031659.107568-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721031659.107568-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
