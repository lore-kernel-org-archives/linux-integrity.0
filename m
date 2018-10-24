Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803DC004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D472082F
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D472082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYAYs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:24:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:58139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbeJYAYs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 20:24:48 -0400
Received: from [185.7.230.215] ([185.7.230.215]) by web-mail.gmx.net
 (3c-app-gmx-bs24.server.lan [172.19.170.76]) (via HTTP); Wed, 24 Oct 2018
 17:55:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-2564d361-b0c0-44bc-a099-c845e46061a7-1540396532523@3c-app-gmx-bs24>
From:   "Peter Huewe" <PeterHuewe@gmx.de>
To:     "Monty Wiseman" <montywiseman32@gmail.com>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        "James Morris" <jmorris@namei.org>,
        "Matthew Garrett" <mjg59@google.com>, serge@hallyn.com,
        chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>, dpsmith@apertussolutions.com
Subject: Aw: Re: LSS-EU BoF(s) (renamed from LPC 2018)
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 Oct 2018 17:55:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
 <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
 <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
 <alpine.LRH.2.21.1810160833560.14147@namei.org>
 <1539642523.2867.44.camel@HansenPartnership.com>
 <alpine.LRH.2.21.1810160946210.2779@namei.org>
 <1539691005.11939.258.camel@linux.ibm.com>
 <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
 <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
 <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
 <1540301465.2787.4.camel@HansenPartnership.com>
 <1540301816.5583.187.camel@linux.ibm.com>
 <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:KDjNgCm7+TC6IcxCG4BGg3MZqLfgxK6BcByU/O2V/bN4QoFfY7l7i8+99UsWbvI1G7Sp7
 ryluGwla8eJcg68QNEt+wK59iKGqgw61My9K1Go9br/RkE8Lxjfjhs8uQDcIWpjU1mQP5k1Oxhkr
 tvO9vXLFNO/MJy8olYc2wMu86n7FaxCTz/5JKB+HPyaY6uJFUKYNoeyLOe2yC7qMiKpClf1W7b62
 3254+4brjBDfpS5Yd0Xdt4/mA7e1UB4UTwATzJ1n3eXOhDNWdvHUpWiK+AFiZWXhjw3uClWEkyf+
 gw=
X-UI-Out-Filterresults: notjunk:1;V01:K0:bQ08qVo7i38=:LPRrAYaWAyufMwvNFM+aSD
 Z/x7aTpozqqg+WoANMQpZKdbvaZ9J6JaI5W7WIxz5mIZXjxlZoJ5HzDQQWrfuU+YGYrG2Lszn
 vvtXpFhC7szGfN2eHvlpt90L8WWoTHDLOtnjWb/HviV9V8aU1yzG/yJxl/KgjIYAm4TUIEq4j
 t6vRgq5kLhb+vA2TzOOonDmHXBrg73tZRPYG2begRIh0NZcU2fgZW4rQ6Xn9zq+/i0JeneFv9
 zPhZ/nINqVJZ/NnTFirHWRpgNJAEo5y+5TE6HXZuv59tmzmZRUu14tcrScV42hJeRFZDJloca
 3o1J0Bk4IC612NvUDg93mZ09szeMmoq7Z+hfvvdRdMgBM3nbzgNrAYCorUQ3qWFLO7xBVbr68
 jp2CfumenUjU/OLPjcbZM4BQnGXiom8F3SRnbnQPSOnCJVuKyIyhCMLB6Fk9abBq1/HapWXXU
 6p+XWnSELb5EEFTfQhwDXQgHoWSEpGJz5qNewv4VuI8lMEKXKGJ1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,
what is now the concensus on the BOF(s) time and location?
 
Thanks,
Peter
