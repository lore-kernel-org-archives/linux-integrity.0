Return-Path: <SRS0=/8cw=Q4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD5C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7179C2086C
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfBUJIo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:08:44 -0500
Received: from moth.iki.fi ([212.16.111.74]:46488 "EHLO moth.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfBUJIn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Feb 2019 04:08:43 -0500
Received: from [130.188.13.218] (218.13.vtt.fi [130.188.13.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msa)
        by moth.iki.fi (Postfix) with ESMTPSA id E31F32A0088;
        Thu, 21 Feb 2019 11:05:45 +0200 (EET)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Markku Savela <msa@moth.iki.fi>
To:     linux-integrity@vger.kernel.org
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
 <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
 <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
Cc:     zohar@linux.ibm.com
Message-ID: <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
Date:   Thu, 21 Feb 2019 11:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 20/02/2019 10:14, Markku Savela wrote:
> No hints how to solve? Anybody?

I changed IMA to just ignore the tpm test in hope that TPM would be 
ready by the time IMA needs it -- no such luck, the "tpm2_probe", which 
triggers the manual start just comes too late. I could just force the 
manual startup earlier in boot, if I could figure out a proper place to 
put the function call...


[    4.008322] ima: Allocated hash algorithm: sha1
[    4.012820] ima: Error Communicating to TPM chip
[    4.017302] ima: Error Communicating to TPM chip
[    4.021763] ima: Error Communicating to TPM chip
[    4.026004] ima: Error Communicating to TPM chip
[    4.030295] ima: Error Communicating to TPM chip
[    4.034558] ima: Error Communicating to TPM chip
[    4.038766] ima: Error Communicating to TPM chip
[    4.042805] ima: Error Communicating to TPM chip
[    4.046951] ima: Error Communicating to TPM chip, result: -19
[    4.059431] uart-pl011 3f201000.serial: cts_event_workaround enabled
[    4.063766] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 72, 
base_baud = 0) is a PL011 rev2
[    4.069963] console [ttyS0] disabled
[    4.074178] 3f215040.serial: ttyS0 at MMIO 0x0 (irq = 151, base_baud 
= 31250000) is a 16550
[    5.282479] console [ttyS0] enabled
[    5.293360] Indeed it is in host mode hprt0 = 00021501
[    5.308808] tpm2_probe cmd rc=256
[    5.322282] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)
[    5.358842] tpm tpm0: A TPM error (256) occurred continue selftest
[    5.378137] tpm tpm0: starting up the TPM manually


Earlier in boot there this "spi-bcm2835" notice. Is this the reason the 
probe gets delayed?

[    3.440240] Loading iSCSI transport class v2.0-870.
[    3.442267] spi-bcm2835 3f204000.spi: could not get clk: -517
[    3.442804] libphy: Fixed MDIO Bus: probed
[    3.443019] usbcore: registered new interface driver lan78xx
[
