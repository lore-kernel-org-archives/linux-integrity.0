Return-Path: <SRS0=Qop3=VW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C50C76190
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 22:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893DA2084D
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 22:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfGYWbj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:31:39 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51070 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfGYWbi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 18:31:38 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7C0DA72CC6C;
        Fri, 26 Jul 2019 01:31:35 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5F65A4A4AE8;
        Fri, 26 Jul 2019 01:31:35 +0300 (MSK)
Date:   Fri, 26 Jul 2019 01:31:34 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190725223134.xrg77dqdj66jc4vi@altlinux.org>
Mail-Followup-To: "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190725061855.3734-1-vt@altlinux.org>
 <20190725215843.GP6134@rhlt>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190725215843.GP6134@rhlt>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bruno,

On Thu, Jul 25, 2019 at 06:58:43PM -0300, Bruno E. O. Meneguele wrote:
> On Thu, Jul 25, 2019 at 09:18:55AM +0300, Vitaly Chikunov wrote:
> > Run `make check' to execute the tests.
> > Currently only ima_hash, ima_sign (v2), and ima_verify are tested.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  Makefile.am           |   2 +-
> >  configure.ac          |   1 +
> >  tests/Makefile.am     |  14 ++++
> >  tests/functions       | 135 ++++++++++++++++++++++++++++++++++++
> >  tests/gen-keys.sh     |  75 ++++++++++++++++++++
> >  tests/ima_hash.test   |  84 +++++++++++++++++++++++
> >  tests/ima_sign.test   | 186 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ima_verify.test |  79 +++++++++++++++++++++
> >  8 files changed, 575 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/Makefile.am
> >  create mode 100755 tests/functions
> >  create mode 100755 tests/gen-keys.sh
> >  create mode 100755 tests/ima_hash.test
> >  create mode 100755 tests/ima_sign.test
> >  create mode 100755 tests/ima_verify.test
> > 
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > new file mode 100644
> > index 0000000..8c6256c
> > --- /dev/null
> > +++ b/tests/Makefile.am
> > @@ -0,0 +1,14 @@
> > +check_SCRIPTS =
> > +TESTS = $(check_SCRIPTS)
> > +
> > +check_SCRIPTS += ima_hash.test ima_verify.test ima_sign.test
> > +
> > +# ima_verify depends on results of ima_hash
> > +ima_verify.log: ima_sign.log
> 
> Small nit: comment and code don't match, ima_hash vs ima_sign :). 
> 
> Maybe:
> 
> -# ima_verify depends on results of ima_hash
> +# ima_verify depends on results of ima_sign

Oh, yes. Thanks!

