Return-Path: <SRS0=9Veq=5J=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF6C10DCE
	for <linux-integrity@archiver.kernel.org>; Tue, 24 Mar 2020 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9C20836
	for <linux-integrity@archiver.kernel.org>; Tue, 24 Mar 2020 22:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="QGrinb5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCXWRd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:17:33 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:55870 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgCXWRd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Mar 2020 18:17:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id BAEC3D8227178;
        Wed, 25 Mar 2020 01:17:30 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LY-EUSBAlXdS; Wed, 25 Mar 2020 01:17:15 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 72D3BD8227177;
        Wed, 25 Mar 2020 01:17:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 72D3BD8227177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1585088235;
        bh=rY+l9JSrhyFiaGT/BW2e9mYgROM6R/izk1+a6RVdGjU=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=QGrinb5l80B80jcW4DQKy3G2lnMQusPYFeEYPVCS5GdSAa5UU//iYVoUjLkc98IzB
         YCBzbb9SNrUbrfZgsNykqxcaHxiFg/Lp4crNaj9VKWqBCisf7jkAz8q4JqOxi4pitY
         wZcKPINcGwn3sJfk5gk94nyoNuOmwmVoWo5RDeMG/E58rGaXwBGZIDpPaPDNLn+98E
         nmBK+0NXruvG8XbUkqxxaZGCYGx3UnnSGIDIGkBksitvgZuYjCc6mMlaf8JOnYUET4
         EsV5otC8lFZMivXyYNpiOqih1NNUECVaDpuPEplB6frWKRp6jUY46n6kz7Pjczy8Ix
         o3Tnwt2FVVYcg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HhoIIQdOQKJd; Wed, 25 Mar 2020 01:17:15 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-243.ip.moscow.rt.ru [90.154.70.243])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 46221D8227176;
        Wed, 25 Mar 2020 01:17:15 +0300 (MSK)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
References: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
 <1585083940.5188.304.camel@linux.ibm.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <fd03f51c-edec-328c-0f53-71a4bd4f35ac@rosalinux.ru>
Date:   Wed, 25 Mar 2020 01:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1585083940.5188.304.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

25.03.2020 00:05, Mimi Zohar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi Mikhail,
>
> On Wed, 2019-12-04 at 01:41 +0300, Mikhail Novosyolov wrote:
>> P.S. Patch is against commit 3eab1f93 "ima-evm-utils: Release
>> version 1.2.1", I did not find newer git.
> This patch doesn't apply to my current working branch or to that tag.
>
> Mimi
>
Mimi, sorry for not replying for long, I was going to send a new version =
of the patch in the next few days. Please point me to your working branch=
, I failed to find it at sourceforge.

Thank you!

