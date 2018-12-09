Return-Path: <SRS0=bpc9=OS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D9C07E85
	for <linux-integrity@archiver.kernel.org>; Sun,  9 Dec 2018 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C1A20865
	for <linux-integrity@archiver.kernel.org>; Sun,  9 Dec 2018 16:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nd2ykOmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C1A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLIQeF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:34:05 -0500
Received: from mout01.posteo.de ([185.67.36.65]:42185 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeLIQeF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Dec 2018 11:34:05 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2DD71160060
        for <linux-integrity@vger.kernel.org>; Sun,  9 Dec 2018 17:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544373243; bh=6IvOpglnfgkSdtD2+GN/2nc7Dw+kdyjmLhLpO1pMsic=;
        h=Subject:To:From:Date:From;
        b=nd2ykOmpZgWbWe573/FnRmNYPA15iKuchbuO2qoxYBxMSoOlFXdUmefVvgU21+BsD
         mVtZzve136dIMwWXUWwG6rFGBfOFOJfmoJCO0WUVnomqGKRTArtUzasRO4U+XQNCKi
         32VQPX8OaHD2Vg1Rv1NupJrH6UHIRab2WF7M3iJUuIgMkGiEg3Lqve2lJoGrqXPfQg
         sM4xdFHNx4mQ3R2obkpboMEvuKyxosSQYrekWBMZaLZBLM6Zfhk2j9np6mx6KgsoAt
         28aJDYg7G8o61QDEYlNxJ7hqGHGN48pacAmolc/U5dpTzGT5kXL7QJ76XNl3Tq34BE
         9XviJFuhwxw5w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43CWxQ3nP3z6tmT
        for <linux-integrity@vger.kernel.org>; Sun,  9 Dec 2018 17:34:02 +0100 (CET)
Subject: Re: unrecognized TMP 2.0 hardware
References: <CAJCQCtTUOh-QQgyEXu1HvHNqqL1kUEkTV3-SaWYDAduQLBhs9Q@mail.gmail.com>
 <CACdnJutPhmizvz9mPT6-hHgXr8LjjAc0Pd9reJjgjRKL3K8Wbw@mail.gmail.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
From:   Malte Gell <mailinglisten@posteo.de>
Message-ID: <161819b2-6934-10b6-e101-e8eb8bc8a464@mailinglisten.posteo.de>
Date:   Sun, 9 Dec 2018 17:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <CACdnJutPhmizvz9mPT6-hHgXr8LjjAc0Pd9reJjgjRKL3K8Wbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 07.12.18 um 01:00 schrieb Matthew Garrett:
> On Thu, Dec 6, 2018 at 3:01 PM Chris Murphy <chris@colorremedies.com> wrote:
>> [    2.066860] tpm_crb MSFT0101:00: can't request region for resource
>> [mem 0x3af5b000-0x3af5b02f]
>> [    2.066916] tpm_crb: probe of MSFT0101:00 failed with error -16
>> [    2.324683] ima: No TPM chip found, activating TPM-bypass!
> 
> Your firmware is marking the region as ACPI_NVS and the kernel refuses
> to allow a driver to allocate it. The "obvious" thing to do here is
> for the kernel to allow drivers to allocate ACPI_NVS regions (since
> Windows obviously works), but there's then some complexity over the
> special-cased NVS save/restore code over suspend/resume.

 Can´t there be made single exceptions, in this case for TPM modules?
(Having the same issue with a Acer notebook, TPM not recognized)


Malte
