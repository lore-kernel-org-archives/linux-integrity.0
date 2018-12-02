Return-Path: <SRS0=SF38=OL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6BC04EB8
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 18:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9892320834
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 18:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S4lNkI7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9892320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbeLBS3b (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 13:29:31 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57530 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbeLBS3a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 13:29:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 58F958EE1CB;
        Sun,  2 Dec 2018 10:29:28 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MeZ3DXNO47_v; Sun,  2 Dec 2018 10:29:28 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D9EFD8EE0C9;
        Sun,  2 Dec 2018 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1543775368;
        bh=KtwzI26mnvvo3hyR/BYHrys7c++cizlyx0HLlPMdCM0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=S4lNkI7XSBTDQiI/UWFWiojYTU5aioka9FzcdTKmNBhum8gFS0cam/7pwRXMzQz31
         v1E8xkefaLrcUk1uhF9A5aoK8PthgLgofEv+5nu8M04neZ5ltrZIBbiblqDXPkRay4
         PzjQuOVtAgB25VUViUkcBllQZ8wqxS4/hEHz4rYE=
Message-ID: <1543775366.2732.24.camel@HansenPartnership.com>
Subject: Re: TPM legacy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 02 Dec 2018 10:29:26 -0800
In-Reply-To: <1543764226.4216.205.camel@linux.ibm.com>
References: <20181130233501.GA32256@linux.intel.com>
         <1543764226.4216.205.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2018-12-02 at 10:23 -0500, Mimi Zohar wrote:
> On Fri, 2018-11-30 at 15:35 -0800, Jarkko Sakkinen wrote:
> > Hi
> > 
> > Some things that came up at LSS.
> > 
> > First, would it be time to drop 1.1b bits? What advantages this
> > would bring? AFAIK Peter is a strong supporter of this.
> > 
> > In the hall way discussions, I talked with Tomas Winkler that it
> > would make sense to add CONFIG_TCG_TPM1 flag to completely leave
> > out all TPM 1.x bits from the kernel.
> > 
> > TPM 1.x stuff is not exactly legacy but especially on IoT does not
> > make sense to carry that code with.
> 
> New systems might be shipping with only TPM 2.0, but it still needs
> to be supported for existing systems, probably for quite a while.
>  Having the option to build the kernel with TPM 1.2, TPM 2.0 or both,
> is acceptable.

The distros won't thank you for yet another kconfig option. ,
especially one which could cause regressions if they choose the wrong
value. However, having a hidden one which could be activated by driver
might work ... on the other hand almost all the current drivers support
both 1.2 and 2.0 so they'd all need splitting.

The other thing that should give us pause is this:

jejb@jarvis:~/git/linux/drivers/char/tpm> size tpm.o
   text	   data	    bss	    dec	    hex	
filename
  35247	   1120	     32	  36399	   8e2f	
tpm.o

Currently the combined tpm subsystem (without drivers) is less than 36k
of code, so is splitting it up valuable?  I think you're going to find
we have a reasonable abstraction of sharing, so taking out 1.x by
config will likely save less than 10k of code ... is that worth the
effort?

James

