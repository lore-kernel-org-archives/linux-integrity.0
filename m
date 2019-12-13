Return-Path: <SRS0=wjIe=2D=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C052BC50708
	for <linux-integrity@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D82474C
	for <linux-integrity@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HI9juvs1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HI9juvs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLMNtq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:49:46 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38640 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfLMNtq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 08:49:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C77688EE19A;
        Fri, 13 Dec 2019 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576244985;
        bh=yXiNCwKRXdNFdRIAdMvJ10U79Xzjc2FAGSAdB5E3PSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HI9juvs1/9gDTKPIEzvCNuwiDgRDtPAAWgk4WVdno+gd1B5XxgH6cu4EVP2UcdRCL
         wtZwFMpTuYKYi80GLalF5tlax3eLMqnflol3CHj8ouggRhxCECaGhnC3rUcoONqXPp
         atGtXeYPjdKU2viFGrYVbolsZATy6X0DkC+/pcT8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7TFYBbileTG; Fri, 13 Dec 2019 05:49:45 -0800 (PST)
Received: from [192.168.101.75] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 340808EE0E0;
        Fri, 13 Dec 2019 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576244985;
        bh=yXiNCwKRXdNFdRIAdMvJ10U79Xzjc2FAGSAdB5E3PSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HI9juvs1/9gDTKPIEzvCNuwiDgRDtPAAWgk4WVdno+gd1B5XxgH6cu4EVP2UcdRCL
         wtZwFMpTuYKYi80GLalF5tlax3eLMqnflol3CHj8ouggRhxCECaGhnC3rUcoONqXPp
         atGtXeYPjdKU2viFGrYVbolsZATy6X0DkC+/pcT8=
Message-ID: <1576244983.3382.9.camel@HansenPartnership.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle
 flush
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Fri, 13 Dec 2019 08:49:43 -0500
In-Reply-To: <1576240555.3382.5.camel@HansenPartnership.com>
References: <1576173515.15886.7.camel@HansenPartnership.com>
         <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
         <1576240555.3382.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-13 at 07:35 -0500, James Bottomley wrote:
> On Fri, 2019-12-13 at 11:10 +0530, Sumit Garg wrote:
[...]
> >  Also, I think we need "#else" part for this API as well.
> 
> No, we shouldn't ... the #else part is only for functions which are
> called when the TPM isn't compiled in.  That should never happen with
> tpm2_flush_context, so if it ever does we want the compile to break.

Just on this bit, it looks like we've given insufficient thought to
what it means to move TPM internals using code outside of the tpm
directory.  I think we really need two include/linux files, one tpm.h
for external code that going to do stuff which it would do anyway even
if a TPM weren't compiled in, like the PCR read and extend.  The other
tpm-internal.h for code that wants access to TPM internal functions
like flushing and session handling and will take care itself of the
case where the TPM isn't compiled in, like the trusted key code does
through Kconfig dependencies.  The test should be easy: if it was
originally in drivers/char/tpm/tpm.h it belongs in include/linux/tpm-
internals.h

James

