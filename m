Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D053C07E9A
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834A96128D
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhGNSQn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:43 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:47614 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbhGNSQn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 14:16:43 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2945172C8B4;
        Wed, 14 Jul 2021 21:13:50 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D62F14A46E9;
        Wed, 14 Jul 2021 21:13:48 +0300 (MSK)
Date:   Wed, 14 Jul 2021 21:13:48 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
Message-ID: <20210714181348.yjvfk5p5uxqarl2q@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
 <20210712054448.2471236-4-vt@altlinux.org>
 <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 14, 2021 at 12:16:57PM -0400, Mimi Zohar wrote:
> On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > 
> > @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
> >  	basicConstraints=CA:TRUE
> >  	subjectKeyIdentifier=hash
> >  	authorityKeyIdentifier=keyid:always,issuer
> > +
> > +	[ skid ]
> > +	basicConstraints=CA:TRUE
> > +	subjectKeyIdentifier=12345678
> > +	authorityKeyIdentifier=keyid:always,issuer
> >  EOF
> >  fi
> 
> On my system:
> $ openssl version
> OpenSSL 1.1.1g FIPS  21 Apr 2020
> 
> Not sure this has anything to do with the reason that "skid" is not
> supported.   The resulting files are empty.
> 
> ls -lat *skid*
> -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
> -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub
> 
> - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> Using configuration from test-ca.conf
> Error Loading extension section skid   <===

Is it reproducible? Since multiple-distributions CI passed, I wonder
what distro it is.

Thanks,


