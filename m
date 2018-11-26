Return-Path: <SRS0=ex1J=OF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEBC43441
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CB20862
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 13:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39CB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeK0AkM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:40:12 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:46882 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeK0AkL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Nov 2018 19:40:11 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9877672CC59;
        Mon, 26 Nov 2018 16:45:59 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 869984A4A29;
        Mon, 26 Nov 2018 16:45:59 +0300 (MSK)
Date:   Mon, 26 Nov 2018 16:45:59 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/3] ima-avm-utils: Fix hash buffer overflow in verify_evm
Message-ID: <20181126134559.rkgdsjbvx2226bw2@sole.flsd.net>
References: <20181126043953.1126-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181126043953.1126-1-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Excuse me, typo in the commit name, supposed to be

  ima-evm-utils: Fix hash buffer overflow in verify_evm

of course.

On Mon, Nov 26, 2018 at 07:39:51AM +0300, Vitaly Chikunov wrote:
> Commit ae1319eeabd6 ("Remove hardcoding of SHA1 in EVM signatures")
> introduces overflow of 20 byte buffer on the stack while calculating evm
> hash. Also, invalid hash length is passed to the underlying verification
> function. This prevents any non-SHA1 hashes from being properly
> validated using evmctl.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1b46d58..94d7ab1 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -55,6 +55,7 @@
>  #include <keyutils.h>
>  #include <ctype.h>
>  #include <termios.h>
> +#include <assert.h>
>  
>  #include <openssl/sha.h>
>  #include <openssl/pem.h>
> @@ -760,13 +761,15 @@ static int cmd_sign_evm(struct command *cmd)
>  
>  static int verify_evm(const char *file)
>  {
> -	unsigned char hash[20];
> +	unsigned char hash[64];
>  	unsigned char sig[1024];
> +	int mdlen;
>  	int len;
>  
> -	len = calc_evm_hash(file, hash);
> -	if (len <= 1)
> -		return len;
> +	mdlen = calc_evm_hash(file, hash);
> +	assert(mdlen <= sizeof(hash));
> +	if (mdlen <= 1)
> +		return mdlen;
>  
>  	len = lgetxattr(file, "security.evm", sig, sizeof(sig));
>  	if (len < 0) {
> @@ -779,7 +782,7 @@ static int verify_evm(const char *file)
>  		return -1;
>  	}
>  
> -	return verify_hash(file, hash, sizeof(hash), sig + 1, len - 1);
> +	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
>  }
>  
>  static int cmd_verify_evm(struct command *cmd)
> -- 
> 2.11.0
