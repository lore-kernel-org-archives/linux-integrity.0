Return-Path: <SRS0=tgSf=77=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA0C433E1
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 00:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817A92080D
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 00:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S3rEfOfg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S3rEfOfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFRA1q (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:27:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33284 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgFRA1q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 20:27:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C53058EE2CA;
        Wed, 17 Jun 2020 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592440065;
        bh=PMoaW1YJ/xOM7hw6EcreEABk39heHKt2ord9Knna9nU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3rEfOfgSglgowIx+HBbcZ6/3pGsSeQRm5/dx3HAyH7VU1yj7tHtmldRCBBGLt+Vu
         Af5YP4wVM7qjOw6xzGRlYRHy2JqSg0ay6f/rpYku37Qg+198/aEB6DLhDzQUvKwky6
         K5k5ZE0NgZJqqYXmv6L9MqPvps4Hol9fkp7CQNCQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OWMvTJASB829; Wed, 17 Jun 2020 17:27:45 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2F90C8EE25B;
        Wed, 17 Jun 2020 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592440065;
        bh=PMoaW1YJ/xOM7hw6EcreEABk39heHKt2ord9Knna9nU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3rEfOfgSglgowIx+HBbcZ6/3pGsSeQRm5/dx3HAyH7VU1yj7tHtmldRCBBGLt+Vu
         Af5YP4wVM7qjOw6xzGRlYRHy2JqSg0ay6f/rpYku37Qg+198/aEB6DLhDzQUvKwky6
         K5k5ZE0NgZJqqYXmv6L9MqPvps4Hol9fkp7CQNCQ=
Message-ID: <1592440063.3515.42.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 17 Jun 2020 17:27:43 -0700
In-Reply-To: <20200617234250.GJ62794@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
         <20200617234250.GJ62794@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > This patch adds a policy= argument to key creation.  The policy is
> > the standard tss policymaker format and each separate policy line
> > must have a newline after it.
> 
> Never heard of policymaker before and did not find TCG spec for it.

It's not part of the spec.  Both the IBM and Intel TSSs define a
policymaker tool to help you build policy hashes.  The format is simply
a set of numbers that if hashed a line at a time produce the policy
hash.

James

