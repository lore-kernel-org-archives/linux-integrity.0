Return-Path: <SRS0=tgSf=77=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E3DC433E0
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 00:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EAB2070A
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 00:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="INFHiQay";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="INFHiQay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFRAZn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:25:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33216 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbgFRAZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 20:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7A7AB8EE2CA;
        Wed, 17 Jun 2020 17:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592439942;
        bh=WQ52xyYQk6yW3Dahtuuu2fWlBSS7X5F2XFiAPnINoJY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=INFHiQaylEoBbgir/iXV9DANJJMDZrSdvpjnwfRf/SykjVYVloOT97jFHGzL4dw5c
         t4unCsEIZRNstN4tshWrM5X6ddGLu1CtaymcCJg38hMVNPlDYAxyDTycLsupixAcaY
         Heqm5kg58iuGTnIWHgkoOBFMdnxlnJjXYRez/tJE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eW5jqt7yZ1Os; Wed, 17 Jun 2020 17:25:42 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BADC48EE25B;
        Wed, 17 Jun 2020 17:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592439942;
        bh=WQ52xyYQk6yW3Dahtuuu2fWlBSS7X5F2XFiAPnINoJY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=INFHiQaylEoBbgir/iXV9DANJJMDZrSdvpjnwfRf/SykjVYVloOT97jFHGzL4dw5c
         t4unCsEIZRNstN4tshWrM5X6ddGLu1CtaymcCJg38hMVNPlDYAxyDTycLsupixAcaY
         Heqm5kg58iuGTnIWHgkoOBFMdnxlnJjXYRez/tJE=
Message-ID: <1592439940.3515.40.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 17 Jun 2020 17:25:40 -0700
In-Reply-To: <20200617214237.dlvfnx2s7aw4sfng@cantor>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
         <20200617214237.dlvfnx2s7aw4sfng@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-06-17 at 14:42 -0700, Jerry Snitselaar wrote:
> On Tue Jun 16 20, James Bottomley wrote:
> > The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > TPM
> > key uses.  We've defined three of the available numbers:
> > 
> > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Load() operation.
> > 
> > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Import() operation.
> > 
> > Both loadable and importable keys are specific to a given TPM, the
> > difference is that a loadable key is wrapped with the symmetric
> > secret, so must have been created by the TPM itself.  An importable
> > key is wrapped with a DH shared secret, and may be created without
> > access to the TPM provided you know the public part of the parent
> > key.
> > 
> > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > 		bytes) which is sealed by the TPM.  It usually
> > 		represents a symmetric key and must be unsealed before
> > 		use.
> > 
> 
> James, which document are these defined in? I was searching last
> night, and couldn't find it.

It isn't.  It's defined in a TCG spreadsheet that Monty Wiseman keeps,
but that seems to be as "official" as it gets with the TCG OID
registry.

James

