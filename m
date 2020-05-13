Return-Path: <SRS0=+O7K=63=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A00EC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 13 May 2020 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C32054F
	for <linux-integrity@archiver.kernel.org>; Wed, 13 May 2020 21:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgEMVjN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 May 2020 17:39:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:25717 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbgEMVjM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 17:39:12 -0400
IronPort-SDR: /WU5yRScmFdFra/taOaIl+gLPEjbArEVIaNsYZFPxSI9MscxmZDskQkahvllq2/pkmCY9g/IzK
 DT8uVFZbO+Jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 14:39:12 -0700
IronPort-SDR: SKtTBquwr/C2Zzz7q7T9K5xYAfe+saAzgKbuNr0hJfVeMDC04/+dGR84KgNj40XKMUxPWZXcSp
 f7PeINpSJxRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="297804929"
Received: from rthurerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.107])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 14:39:07 -0700
Date:   Thu, 14 May 2020 00:39:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200513213905.GB31974@linux.intel.com>
References: <20200507040912.GA31382@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507040912.GA31382@embeddedor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 06, 2020 at 11:09:12PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> Also, the following issue shows up due to the flexible-array member
> having incomplete type[4]:
> 
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_start’:
> drivers/char/tpm/eventlog/tpm2.c:54:46: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>    54 |  size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
>       |                                              ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_next’:
> drivers/char/tpm/eventlog/tpm2.c:102:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   102 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_binary_bios_measurements_show’:
> drivers/char/tpm/eventlog/tpm2.c:140:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   140 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> scripts/Makefile.build:266: recipe for target 'drivers/char/tpm/eventlog/tpm2.o' failed
> make[3]: *** [drivers/char/tpm/eventlog/tpm2.o] Error 1
> 
> As mentioned above: "Flexible array members have incomplete type, and
> so the sizeof operator may not be applied. As a quirk of the original
> implementation of zero-length arrays, sizeof evaluates to zero."[1] So,
> the sizeof(flexible-array) can be safely removed to fix the error above.
> 
> Lastly, prefer sizeof(*ptr) over sizeof(struct foo).
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> [4] https://github.com/KSPP/linux/issues/43
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
