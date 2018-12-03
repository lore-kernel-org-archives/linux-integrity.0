Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC2C04EB9
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DAB20850
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 15:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DAB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeLCPBx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:01:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:38171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeLCPBx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 10:01:53 -0500
Received: from [217.10.52.10] ([217.10.52.10]) by web-mail.gmx.net
 (3c-app-gmx-bs70.server.lan [172.19.170.215]) (via HTTP); Mon, 3 Dec 2018
 16:01:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70>
From:   "Peter Huewe" <PeterHuewe@gmx.de>
To:     "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
Cc:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Aw: Re: TPM legacy
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 3 Dec 2018 16:01:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20181202231327.GC6718@linux.intel.com>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
 <1543775366.2732.24.camel@HansenPartnership.com>
 <20181202231327.GC6718@linux.intel.com>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ggmxApkWuQjFU216dEC1tn0ODoDvqOlqTpxR6HL3BmB+Lv45tx61tOFGH/TiosIYmn2By
 T0+UK1eadISUpiVk5fskbCaj7pnzrp4sKtaxqFyvdXF5nnYXBR76XfoqmWpEmIPGtL23vGAzRuOH
 /j9b0QXan9p/m3MQvZeswOMEoBQuPsGZ/Lr4wBc9HwIE7Rr7Htr2Hk0kIEzBNBA7P4OalSZ62NLq
 5ywRh+/YsUofcVnr46cOtvgtdkIDdaH2PJhAIMY9/zscpF1zEQpPfIleWCmHKOUCCPSEs3nEgNtV
 2U=
X-UI-Out-Filterresults: notjunk:1;V03:K0:zU3wn4MnM0A=:DzfEqlaGgENnaWHQD6pCZB
 Wf98UD1t1/FVjolPv3HdbXOjax2FHlcGKG3K33s+vjGOvAYEiB4xJVwlsRrVKQsW4PFOgGYc+
 LmflcaaQmTe6/He1ihwHYMoL6xVIXcwiiVCJZB+xZTrSkZeASFpfh+X40qFesI1vqPQ09/sCd
 jkVOYQlJb7zaM1E51rsC1VjtO15hVhGJF2IIbZOjFzT2OX1fevawtmbJKK4SK7CTIF1b14RkS
 /FKUm23rSRWq3GyFZkUk9MPjHMODEIa2wZuTJq5WHS3P55xQTYL6xVb5Z6gJ4JVjfUfa7e8NI
 aMLj1LhWuKNrZ5CjoUll5EYSL0DixlJxygzyhKnPs16GKpnUK8c9TIXC1/mxeAvY1R8kmOyi8
 a8ENJyMvkFn/7eAjAfVCt9bfEfU4J4BcbD2ffLX4ZNHuVI9gbwqfz1T1pvvS9256yEA2jQEFo
 5bKI3fTdjfEbWD4DZio61hFX4pMt9l6ah3aAubyl++2snCFXsOwLHTks2T8tThJA13ing8op3
 D21Zwf1Xq0gsrIcAaAKGVCdArJE2CIFJTlQXMnGHPBAW5L0Lpq/mZGjFR22VPcFhYCyPkGqz1
 CK2o0UhNvxyeE=
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
> Some things that came up at LSS.
> 
> First, would it be time to drop 1.1b bits? What advantages this would
> bring? AFAIK Peter is a strong supporter of this.

> In the hall way discussions, I talked with Tomas Winkler that it would
> make sense to add CONFIG_TCG_TPM1 flag to completely leave out all TPM
> 1.x bits from the kernel.
> 
> TPM 1.x stuff is not exactly legacy but especially on IoT does not make
> sense to carry that code with.

> It is not only a size question. All unused code is always potential
> attack surface. If the option is by default off and properly documented,
> it should be IMHO ok.

We have to differentiate a few things here:
There are 
- TPM 1.1b (proprietary protocols),
- TPM1.2 TIS based,
- TPM1.2 TIS deviations (like i2c/spi)
- TPM2.0 TIS/FIFO based,
- TPM2.0 CRB based

TPMs.


The only thing I would want to get rid of are the *1.1b based* drivers - they are probably end of life since quite some time.
The TIS driver&specification has been around since 2005 if not longer...
Nobody has hardware or systems to test 1.1b devices anymore - and there your words are true - these are potential attack surfaces as they are unmaintained stuff.
e.g. the tpm_atmel.c or tpm_nsc or tpm_infineon or the iTPM workarounds.

By removing these, you can probably streamline all tis based tpm drivers (including the proprietary i2c/spi drivers as they are based on TIS)
and architecture a cleaner interface.
For tis based tpms, go left, for crb based tpms go right.
Since TIS and FIFO are not really different, you save nothing by removing 1.2 support there.
1.2 TPMs are still shipping in huge numbers and will follow us for the next XX years.
So dropping or configuring out 1.2 is currently not an optoion and I would certainly nack any attempt at the moment.


I don't think you would really save very much by factoring out the 1.2 commandset and at the moment it would confuse more than it would help.
Especially if you think about systems were you can switch between 1.2 and 2.0 with a simple reboot.

And the code size argument - we added a fullblown resource manager, thinking about adding encrypted sessions per default and are worried about a few bytes for the TPM1.2 commands???
If we really think about size, you would have to restart from scratch - and not only think about code size but especially ram size, e.g. the 4k buffer we statically allocate....


Thanks,
Peter´

p.s.: the opinion above is my own, not necessarily my employers.
