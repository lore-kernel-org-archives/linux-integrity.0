Return-Path: <SRS0=HrVK=65=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10334C433DF
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 22:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05FF2076A
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="c5Cc690F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DclO9fdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEOWTe (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 15 May 2020 18:19:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55242 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOWTe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 18:19:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB8648EE2CA;
        Fri, 15 May 2020 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589581172;
        bh=RdqibSKGPKQf/Ou5dNzY5YYzWfym+fTTWhCe+rVseRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c5Cc690Fom2GcpnklB4qQozfLVLYcm//82UtvhlWkOrepRRubGZu5IXeZS5NoWH9+
         J+NDuzJNeTB8UILPtuPLu3Eln9p6h99tGfT5D3DE0KOxtjXC6IdyU5WWxzB60QXB2h
         aYopo05WKJkrg83ZxZOWC6+IrVZkKD+blZxUxOSg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6i7aWFi2WZ_D; Fri, 15 May 2020 15:19:32 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 948FC8EE25D;
        Fri, 15 May 2020 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589581171;
        bh=RdqibSKGPKQf/Ou5dNzY5YYzWfym+fTTWhCe+rVseRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DclO9fdDBI+pIaD90+7stdOi5detsTEnNz6x6MoGqaDnSG1n1R/jFjxKc6Hivs0RJ
         LmQhAbK29Sdf66WISlK3l93ePZCZSQMGyix9nThHqnlrv2UqFlifIRNjRQtGN9+T2c
         C+mUlEVSmOKyChwRpwEEfduAdkGRRYJVjesM+S38=
Message-ID: <1589581169.30847.5.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 15:19:29 -0700
In-Reply-To: <56688CD4-A4A5-4D98-8724-6CBA10C7E1CE@unh.edu>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
         <1589573417.3653.28.camel@HansenPartnership.com>
         <56688CD4-A4A5-4D98-8724-6CBA10C7E1CE@unh.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 21:03 +0000, Kayaalp, Mehmet wrote:
> > On May 15, 2020, at 4:10 PM, James Bottomley <James.Bottomley@hanse
> > npartnership.com> wrote:
> > 
> > I think that means the solution is not to run the smoke test under
> > sudo
> > but to do sudo -s and then run it.
> > 
> > James
> 
> How about "sudo -i":
> 
> https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-
> bash-when-does-it-matter-which-is-used

Actually, no that doesn't work either:

jejb@testdeb> sudo -i keyctl list @s
1 key in keyring:
1041514063: ---lswrv  1000 65534 keyring: _uid.1000

I suspect this might be a very subtle bug to do with when you get a new
session keyring.

James

