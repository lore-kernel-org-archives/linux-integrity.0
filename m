Return-Path: <SRS0=07is=V3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31724C0650F
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Jul 2019 11:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213B2089E
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Jul 2019 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564486256;
	bh=ueqMsYbHUv7lG4NrZ2we8kj9Oo0ClZR8B/FulDTCRoI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-ID:From;
	b=Qja70r+xVSnapmZX5VYSOzQLakOeu+eApuJpY8y1nZxb1iXhqjubbVN5NvnAm3TLY
	 fQaj2e83OXh9s8Gk1xzLP9nvpa4D0HfvBbgdq6SIO+6eGllMeti0p6k//kxEoML79G
	 1sih/LlM7+Fp60jJSkoZeKnU6hpGzbPHjdheJgnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfG3Laz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfG3Laz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 07:30:55 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646772087F;
        Tue, 30 Jul 2019 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564486254;
        bh=ueqMsYbHUv7lG4NrZ2we8kj9Oo0ClZR8B/FulDTCRoI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=J0LG+tDeMYjnKyqgAC9QwbppR1SA4xzVRSzT8bwJWNrGBUWKvJ2KDeQk1aETKVCH5
         3dUUbUe9T510dTsLu+euh0kUE8rqLFJLP4EbbqU3l3A4axT0gG8okdmTxWsuOIf9+6
         J36i/DzC7Vi7POu477ROw/F/dit11APYnxGu97Ho=
Message-ID: <1564486237.4189.28.camel@kernel.org>
Subject: Re: ima-evm-utils: git tagging for release
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Date:   Tue, 30 Jul 2019 07:30:37 -0400
In-Reply-To: <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
         <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Tue, 2019-07-30 at 09:26 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> It seems that you are released v1.2 of ima-evm-utils. (I did not receive
> any announcement on linux-integrity.) I noticed that you are not using
> annotated tags for release versions.

In the future, I'll announce it here.

> 
> I suggest you use annotated tags (possible even signed) for release
> versions. (You will need to delete existing v1.2 local tag if you are
> going to retag it with annotated tag.)

There are a couple of additional bug fixes that need to be applied
against the v1.2 release.  Maybe it would be better to release v1.2.1
with these additional bug fixes, using the annotated tag.

Mimi
