Return-Path: <SRS0=TWRc=VZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C9C433FF
	for <linux-integrity@archiver.kernel.org>; Sun, 28 Jul 2019 00:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5039B20856
	for <linux-integrity@archiver.kernel.org>; Sun, 28 Jul 2019 00:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfG1AZP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 27 Jul 2019 20:25:15 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34690 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfG1AZP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jul 2019 20:25:15 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7240472CC6C;
        Sun, 28 Jul 2019 03:25:13 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 576EA4A4AE8;
        Sun, 28 Jul 2019 03:25:13 +0300 (MSK)
Date:   Sun, 28 Jul 2019 03:25:12 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190728002512.gu4airn3xmebeqib@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190727044113.3865-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190727044113.3865-1-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jul 27, 2019 at 07:41:13AM +0300, Vitaly Chikunov wrote:
> Run `make check' to execute the tests.
> Currently only ima_hash, ima_sign, and ima_verify are tested.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ....
> +_evmctl_run() {
> +  local cmd=$1 out=$1-$$.out
> +  # Additional parameters:
> +  # FOR: append to text as 'for $FOR'
> +  # DEL: additional files to rm if test failed
> +
> +  set -- evmctl $V ${ENGINE:+--engine $ENGINE} "$@"
> +  echo $YELLOW$TMODE $*$NORM
> +  eval "$@" >$out 2>&1
> +  ret=$?
> +
> +  if [ $ret -ge 126 -a $ret -lt 255 ]; then
> +    echo $RED
> +    echo "evmctl $cmd failed hard with ($ret) ${FOR:+for $FOR}"
> +    sed 's/^/  /' $out
> +    echo $NORM
> +    rm $out $DEL
> +    FOR= DEL=
> +    return $SKIP

Should be `return $HARDFAIL`.

