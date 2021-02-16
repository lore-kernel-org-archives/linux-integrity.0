Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD74C433E6
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E094164DEC
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Feb 2021 11:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBPLWp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:22:45 -0500
Received: from ithil.bigon.be ([163.172.57.153]:59688 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhBPLWk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 06:22:40 -0500
X-Greylist: delayed 1171 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 06:22:39 EST
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 707F91FDD8;
        Tue, 16 Feb 2021 12:21:55 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 486ZoZ2_a9o1; Tue, 16 Feb 2021 12:21:55 +0100 (CET)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Tue, 16 Feb 2021 12:21:55 +0100 (CET)
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt()
 and tpm_get_timeouts()
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
 <CAFJ_xbo2Tvfjjbt-xFAkEAdqVEg0ZhDnGJa2qkJOYURx47hE+Q@mail.gmail.com>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <23a1d2c8-e67d-f8c0-b720-0dfe1a3dcef5@debian.org>
Date:   Tue, 16 Feb 2021 12:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFJ_xbo2Tvfjjbt-xFAkEAdqVEg0ZhDnGJa2qkJOYURx47hE+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 16/02/21 à 12:17, Lukasz Majczak a écrit :
> Hi Laurent,
Hello Lukasz,
>
> I think your case is different, as the trace shows the issue in the 
> place already guarded by tpm_chip_start()/stop(). Can you past more 
> dmesg log? (With tpm prefix?). I believe tpm_tis_status() might return 
> something different than 0xff here.

I see "WARNING: CPU: 5 PID: 449 at drivers/char/tpm/tpm_tis_core.c:249 
tpm_tis_status+0x86/0xa0 [tpm_tis_core]" in dmesg

