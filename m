Return-Path: <SRS0=r+VA=OH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A7C43441
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D312208E7
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 15:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D312208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK2CHH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:07:07 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21829 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CHH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Nov 2018 21:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1543417502; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Laog57IMqHfeffvYskbosUiIVAWPDXiYIyDvw+o+JCx8w1GDeKvN4pluQDuk0qNGVsHZk37PqfREFxsPmDWZl6Y5MpRGl2snh1pzRcXPqRqzyTeTV4CRGpzGxpJ40g+XNIeYbgxp4GN1iSo88ibjkK61fvp82VYMydJPRPXtrJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1543417502; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=l8x/5OqCiprqtsfIbvAaHRtgw0jxPjyrqwXv17ySFnA=; 
        b=ZseBcJR24QYvKfZdT2lfQjGEoH+6c6GVTU38LW7K+RHiVd8VgGuVdIcls2GowUoBFxJSmZt14MzA8yTvqLewil2UhxVmwuvoDri454AAkbojHjfNpLrj132sJShoQ2DAfRZ03zyDQxoee0IlwPZO76R1iRmQPeXz0CRPbdRm8rI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1543417501103901.768367830963; Wed, 28 Nov 2018 07:05:01 -0800 (PST)
Message-ID: <660e6a212c9048a6a9660722f2468406b70acb1c.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
In-Reply-To: <010f0d36-66b1-0202-543b-d579db4b2d93@linux.ibm.com>
References: <1541962653.3190.7.camel@HansenPartnership.com>
         <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
         <1541968191.3190.12.camel@HansenPartnership.com>
         <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
         <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
         <1541972556.3734.90.camel@linux.ibm.com>
         <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
         <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
         <20181118081833.GH5897@linux.intel.com>
         <467833cc47247a55595d72426f46eeac1406eb04.camel@mniewoehner.de>
         <20181119134956.GD8755@linux.intel.com>
         <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
         <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
         <010f0d36-66b1-0202-543b-d579db4b2d93@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 28 Nov 2018 16:04:58 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2018-11-27 at 17:31 -0500, Ken Goldman wrote:
> On 11/26/2018 2:15 PM, Michael Niewöhner wrote:
> > Hi again,
> > 
> > after some experiments I finally found a solution...
> > There seems to be a bug in TPM2.0 firmware version (1.3.1.0) included in
> > Lenovos
> > UEFI image but they do not provide an update.
> > 
> > I have extracted the firmware version 1.3.2.8 from Dell's XPS15 TPM2.0
> > firmware
> > update and used this to replace the firmware in my Lenovo UEFI image.
> > After flashing this version via UEFI Setup the TPM2.0 gets detected and now
> > is
> > fully working. WTF.
> > 
> > For anyone having the same problem: binwalk, uefi-firmware-parser, uefipatch
> > and
> > flashrom are your friends ;-)
> 
> Just to make sure I understand it, do I have this right?
> 
> 1.3.2.8 is Nuvoton's TPM firmware.  It was embedded in Dell's firmware 
> (UEFI?).  You extracted it from Dell and inserted it into Lenovo. 
> (UEFI?).  Then you flashed the TPM firmware.
> 

Exactly. The Lenovo UEFI Setup has the ability to switch between TPM1.2 and
TPM2.0 by flashing the appropriate Firmware. Lenovo has v1.3.1.0 for TPM in
their latest P320 UEFI image. I dumped the SPI flash rom, replaced the firmware
with UEFIPatch and flashed the image back. Then I had to select TPM1.2 to be
able to reflash TPM2.0 firmware as a second step.


