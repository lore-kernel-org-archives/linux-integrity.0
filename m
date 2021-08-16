Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D65C4338F
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Aug 2021 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621D560EFE
	for <linux-integrity@archiver.kernel.org>; Mon, 16 Aug 2021 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhHPPLF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhHPPLE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629126632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCKHyNwVTXQIjp7HhCExYaqydcJ5w7s0LdVphd9R+48=;
        b=eGFvObCGry4dQp9oH3p6Ul4aSLlUfdPYITjiBb6E1d/OsRg3VJ96CHdDIyShcfTEvW3IFW
        nj6VC4Gol/yqBTxxrmshs2lxmriGkGRy+moZI7mX45h9/oNt8tcGvsOpTxsdrBv3XhFD1y
        pzzRgeGfWcG3YBIiMsTmce9BEhpBVSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-140QJdFgMWSwc3MCx6dTLA-1; Mon, 16 Aug 2021 11:10:28 -0400
X-MC-Unique: 140QJdFgMWSwc3MCx6dTLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADA181008063;
        Mon, 16 Aug 2021 15:10:27 +0000 (UTC)
Received: from localhost (unknown [10.22.8.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4013C1017CE6;
        Mon, 16 Aug 2021 15:10:27 +0000 (UTC)
Date:   Mon, 16 Aug 2021 12:10:25 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
Message-ID: <YRp/4Wnr7GYN1Ef4@glitch>
References: <20210810202852.236354-1-bmeneg@redhat.com>
 <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
 <YRP/+7XT25GbAEef@glitch>
 <1e261f41462aac5e9fbb6d9397f5f86a5379a803.camel@linux.ibm.com>
 <b8d5fdd1-ffc0-4db4-4993-a31da2c3140c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d5fdd1-ffc0-4db4-4993-a31da2c3140c@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 11, 2021 at 02:28:37PM -0400, Ken Goldman wrote:
> On 8/11/2021 1:31 PM, Mimi Zohar wrote:
> > On Wed, 2021-08-11 at 13:51 -0300, Bruno Meneguele wrote:
> > > On Wed, Aug 11, 2021 at 10:52:00AM -0400, Mimi Zohar wrote:
> > > 
> > > > > 
> > > > > -	return pwd;
> > > > > +	return password;
> > > > 
> > > > Wouldn't a simpler fix be to test "pwd" here?
> > > >          if (!pwd)
> > > >                  free(password);
> > > >          return pwd;
> > > > 
> > > 
> > > The problem is on success, when 'pwd' is actually not NULL.
> > > With that, I can't free(password). I would need to asprintf(pwd, ...) or
> > > strndup(password). Because of that, I thought it would be cleaner to
> > > remove 'password' completely.
> > 
> > I see.  So instead of "return pwd" as suggested above,
> > 
> >          if (!pwd) {
> >                  free(password);
> >                  password = NULL;  <== set or return NULL
> >          }
> > 
> >          return password;
> 
> That looks cleaner to me.
> 
> My style would be
> 
> 	if (pwd == NULL)
> 
> which compiles to the same binary, but it less prone to error.
> 
> In addition, since this is reading from stdin
> 
> 1 - Do you want the newline to be part of the password?

I would say 'yes'. AFAIK OpenSSL preserves the newline if it's present
in the input from <stdin>:

"The returned string is always NUL-terminated and the '\n' is preserved
if present in the input data" (BIO_gets() manpage from OpenSSL)

Also, if the user passed the password to the PEM file creation through
the arguments list (no newline) it can also do the same with evmctl.

> 2 = Why is an empty password an error?
> 

Considering the item 1, I don't think we have an empty string in this
case.

-- 
bmeneg 
PGP Key: http://bmeneg.com/pubkey.txt

