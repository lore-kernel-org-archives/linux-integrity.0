Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190AC282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CDE2084C
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LHo9f+YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfA3Pfw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:35:52 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57918 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfA3Pfw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 10:35:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 618AA8EE232;
        Wed, 30 Jan 2019 07:35:51 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NiBDkRbzHgEW; Wed, 30 Jan 2019 07:35:51 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CD8478EE0E9;
        Wed, 30 Jan 2019 07:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548862551;
        bh=CqBMrVinRtrLpuc7zKlrfT0pXt+7sLZmPxl9t/j092I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LHo9f+YE/kX8AGYi7N1MeUtk2KjSinZIhg/uDpYDoEmYDlkCMGzzj7vgbgHQz6Dcz
         BH54SOHOizbvUsPg2kaxw/SniOos8K7dWARBbFScWnPv8T2tPBuOpz2vxwiErHzKPS
         j7hBCPqvusdolKjB4u/Kl6uUa+zFsecai55ZH4bo=
Message-ID: <1548862549.3037.18.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jan 2019 07:35:49 -0800
In-Reply-To: <20190130132521.edhtrv54labxlbyc@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
         <1548851697.20210.91.camel@linux.ibm.com>
         <20190130132521.edhtrv54labxlbyc@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-01-30 at 16:25 +0300, Vitaly Chikunov wrote:
> On Wed, Jan 30, 2019 at 07:34:57AM -0500, Mimi Zohar wrote:
> > On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> > > Because of call to OPENSSL_add_all_algorithms_conf() calling
> > > OpenSSL_add_all_algorithms() is not needed. There was not be any
> > > problems though because double initialization is permitted.
> > > ---
> > >  src/libimaevm.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index 7501303..b038d0c 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const
> > > unsigned char *hash, int size, const c
> > > 
> > >  static void libinit()
> > >  {
> > > -	OpenSSL_add_all_algorithms();
> > >  	OPENSSL_add_all_algorithms_conf();
> > >  	ERR_load_crypto_strings();
> > >  }
> > 
> > The only difference between the two calls seems to be reading the
> > system openssl.cnf file.  In the original call that is dependent on
> > OPENSSL_LOAD_CONF being defined.  Calling
> > OPENSSL_add_all_algorithms_conf(), forces reading the system
> > openssl.cnf.
> 
> Yes. OPENSSL_LOAD_CONF is per application define, which is by default
> undefined. And instead of defining it, we could just call
> OPENSSL_add_all_algorithms_conf(), which is required for GOST
> support.
> Otherwise enabling Streebog via OPENSSL_CONF will not work.

It will if you call

ENGINE_set_default(e, ENGINE_METHOD_ALL);

after ENGINE_init

That's all the conf file is covering up for.

James


