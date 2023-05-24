Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077FC77B7E
	for <linux-integrity@archiver.kernel.org>; Wed, 24 May 2023 01:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjEXBoU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 May 2023 21:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjEXBoT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 21:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864C130;
        Tue, 23 May 2023 18:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E405B6379E;
        Wed, 24 May 2023 01:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8684BC433EF;
        Wed, 24 May 2023 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684892657;
        bh=1i9NJYDGvdiK2ften8KMi4SRD6dy8PAxx3HVvz2rB+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=javWr5xwdF0vZgR5JvCfqcDsNZz4yx2iJBkNCKyxK8GWBsKtF/y9r2YWa286YF0yW
         E+fkMK7mVs/AiK9LxJeTkHHCW0/2xM/jGpQ9DVgzi1ncn/RJI6llap67y7/buVPxMC
         8t1rsvbfT9Umhh2ZZavdBXlxF/ZqKvetq77ohctG9uQBsSpXRH7A1kbMA3z+fu78/G
         uWaxw7lakM7yS+qix0gu7Gs0pbFGdQN/6dV+hyZc3Hw8xqTtvJwJtaPHDWMcaLxBfN
         xYlK1QQ+Vpre6ejbQIAtBSUZWXg6ObPYYyYQkEwxmwo09T3evP/INk4piSFblGWlHX
         JgwDrdbNQ78DA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 04:44:12 +0300
Message-Id: <CSU4LJ3ILUX5.1PHMGJXF2U2TC@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lukas Wunner" <lukas@wunner.de>
Cc:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
 <20230523194654.GB5820@wunner.de>
In-Reply-To: <20230523194654.GB5820@wunner.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 23, 2023 at 10:46 PM EEST, Lukas Wunner wrote:
> On Tue, May 23, 2023 at 10:00:10PM +0300, Jarkko Sakkinen wrote:
> > I feel also a bit resistant because leaf driver framework is really
> > a wrong location in the kernel tree for IRQ storm detection.
> >=20
> > It would be better to have it signaled above the TPM driver, and the
> > driver would then just act on it.
>
> That would require changing the logic in kernel/irq/spurious.c.
>
> At this point in the cycle, such a change would definitely not be
> eligible as a fix for v6.4.

No disagreeing with this. Just pointed it out.

BR, Jarkko
