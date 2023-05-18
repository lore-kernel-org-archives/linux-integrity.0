Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FFC77B7A
	for <linux-integrity@archiver.kernel.org>; Thu, 18 May 2023 01:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjERBog (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 17 May 2023 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERBof (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 May 2023 21:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE3123;
        Wed, 17 May 2023 18:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB1E64C27;
        Thu, 18 May 2023 01:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB7EC4339B;
        Thu, 18 May 2023 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374273;
        bh=oY7desyUrZgSVYNn22bstmMUQskNjZg8hcfa694Nb08=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=o6ouGPbZgFhaaAQIuTiOa6FBz+lfwnBc2X1T9mIW8NyLxORR634k6PKL3tiSaXcrt
         r5iSKkTulhFlc1m68HFxkGRhe4ga5D6g8rW+dQoDhll49DZFVmYf0kE/J0o/LpMEa+
         pRtPh8Q5lMYqhJNbEnV1qrlJUofcRbltGNoymy6DbBgjb/qcfs0B0ilHNDQFChFhxk
         9ywWMrP8HxNwOkpcm/cELdYto2IaDB/Rj60rO4c+fXRrNnsc7WWU967sxrrRU5HdYg
         tj18QYixSsHS1yRpgNYIRZOmxZq7s8WafS1HZuNFabUaCh1kKbgAe5/1KVOAk9NeU9
         IdMDoTFF1tPXg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 May 2023 04:44:30 +0300
Message-Id: <CSP0UHKU4XI8.1K46P5P0N5451@wks-101042-mac.ad.tuni.fi>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd: three bug fixes for v6.4-rc2
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.15.2
References: <20230516000208.4008443-1-jarkko@kernel.org>
 <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
In-Reply-To: <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 17, 2023 at 7:52 PM EEST, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 5:02=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.gi=
t/ tpmdd-v6.4-rc2
>
> That didn't work at all.
>
> That "jarkkojs" part of the path seems to be just wrong, and it should
> be - like always before - just "jarkko".
>
> I pulled it from the correct location, but I don't know how you messed
> that up - maybe just a fat-fingered mistaken edit, or maybe something
> else.
>
> So you might try to see what went wrong...
>
>               Linus

Oops, I'm sorry. I'll address this.

BR, Jarkko
