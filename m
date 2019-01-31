Return-Path: <SRS0=eEpa=QH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C3C282D9
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77402195D
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XrS9kxhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfAaU3b (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:29:31 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45990 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbfAaU3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Jan 2019 15:29:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2A2AF8EE241;
        Thu, 31 Jan 2019 12:29:30 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W9-kwdOy7rSV; Thu, 31 Jan 2019 12:29:29 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B1E38EE092;
        Thu, 31 Jan 2019 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548966569;
        bh=vG9cqqwIFkW+qj7F8yQ5CM4h2HHQGHk6ZaihHzHGOKw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XrS9kxhU1bDxYOCe4dmhptFh3koKHMboZhwon8avtKt7Q1ayPYaL8QFp2QRoKU5u3
         88Rdz0RoJSCLrB8tSYo7FN3osda52hy0Gt8xsT9IbecrOwVhf0vsiRT3uBo8QzvxOM
         JEBJf9IUYBSGHSpEVX/s/UX+h2NnCTBSaMRIXLNU=
Message-ID: <1548966568.2876.19.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 31 Jan 2019 12:29:28 -0800
In-Reply-To: <20190131092201.grymls3ocm3mmrmd@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
         <1548851697.20210.91.camel@linux.ibm.com>
         <20190130132521.edhtrv54labxlbyc@altlinux.org>
         <1548862549.3037.18.camel@HansenPartnership.com>
         <20190130161208.vpbk3v74l7cf5a4t@altlinux.org>
         <1548866665.3037.27.camel@HansenPartnership.com>
         <20190130175419.hiqbpptl7fej6m4j@altlinux.org>
         <1548873360.3037.45.camel@HansenPartnership.com>
         <20190131092201.grymls3ocm3mmrmd@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-01-31 at 12:22 +0300, Vitaly Chikunov wrote:
> On Wed, Jan 30, 2019 at 10:36:00AM -0800, James Bottomley wrote:
[...]
> > However, that's not how a casual non-Russian user would want it. 
> > They'd only want gost if they specified the streebog hash.  And if
> > we advertise the hash (as we do because you added it to the help)
> > they should have a reasonable expectation of its working easily.
> 
> It will. I support both methods of use. For occasional user there is
> option --engine and for the frequent user there is config trick.

OK, as long as users can use it without modifying the config file, I'm
happy.

[...]
> > > I implemented two methods of loading engine for evmctl (via
> > > config and via --engine option).  There is no problem with --
> > > engine option for Streebog, AFAIK.
> > 
> > Can you try it with a vanilla (non gost modified) openssl.cnf file
> > to verify?  I think you require the ENGINE_set_default() call but
> > it may be that a non-standard hash name will cause a search of the
> > engine added hashes.  OpenSSL has badly documented defaults, so I
> > usually chase that through the code, but in this case a simple
> > experiment will tell us.
> 
> Of course, I tried and tested that both ways are working
> independently. Just for Streebog ENGINE_set_default is not required,
> but to support GOST signatures (patch is RFCed) it will be required.

I agree, I tried it with the openssl gost engine and you get this weird
behaviour (I have to use md_gost94 because 1.0.2 gost doesn't have
streebog):

jejb@mulgrave:~/git/ima-evm-utils/src> ./evmctl -n --hashalgo md_gost94  ima_hash ~/tmp.ppt
01945d562c031c262563b026d8cc53e070140ad101
jejb@mulgrave:~/git/ima-evm-utils/src> ./evmctl -n --engine gost --hashalgo md_gost94  ima_hash ~/tmp.ppt
01a930a87289b548c2744fbb183a22196b1f651a727d84021d0eeb80cb4dddbb5d

Because IMA silently falls back on sha1 if it can't find the hash.  But
the test proves it will use the gost hash when the engine is provided
without ENGINE_set_default().

James


