Return-Path: <SRS0=uwT9=B3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A9C433E3
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA13208C7
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgHQIEz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:04:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:32980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgHQIEx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 04:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C29DDABF4;
        Mon, 17 Aug 2020 08:05:17 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:04:51 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH ima-evm-utils 9/9] travis: Switch to docker based builds
Message-ID: <20200817080451.GA21486@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
 <20200813182532.6931-10-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813182532.6931-10-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

I'm sorry I left debugging code in travis/fedora.sh.

> --- /dev/null
> +++ b/travis/fedora.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +set -e
> +
> +if [ -z "$CC" ]; then
> +	echo "missing \$CC!" >&2
> +	exit 1
> +fi
> +
> +case "$TSS" in
> +ibmtss) TSS="tss2-devel";;
> +tpm2-tss) TSS="tpm2-tss-devel";;
> +'') echo "Missing TSS!" >&2; exit 1;;
> +*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
> +esac
> +
> +# ibmswtpm2 requires gcc
> +[ "$CC" = "gcc" ] || CC="gcc $CC"
> +
> +yum -y install \
> +	$CC $TSS \
> +	asciidoc \
> +	attr \
> +	autoconf \
> +	automake \
> +	diffutils \
> +	docbook-xsl \
> +	gzip \
> +	keyutils-libs-devel \
> +	libattr-devel \
> +	libtool \
> +	libxslt \
> +	make \
> +	openssl \
> +	openssl-devel \
> +	pkg-config \
> +	procps \
> +	sudo \
> +	vim-common \
> +	wget \
> +	which
> +
> +yum -y install docbook5-style-xsl || true

These lines below needs to be removed.
> +
> +# FIXME: debug
> +echo "find /tss2_esys.h"
> +find /usr/ 2>/dev/null |grep /tss2_esys.h || true
> +echo "cat /usr/include/tss2/tss2_esys.h"
> +cat /usr/include/tss2/tss2_esys.h || true

Kind regards,
Petr
