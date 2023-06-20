Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F9EB64D8
	for <linux-integrity@archiver.kernel.org>; Tue, 20 Jun 2023 05:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFTFpR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 20 Jun 2023 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTFpR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 01:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54D10D7;
        Mon, 19 Jun 2023 22:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C323460FF3;
        Tue, 20 Jun 2023 05:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E6CC433C8;
        Tue, 20 Jun 2023 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687239915;
        bh=H8Hqh0jJnoFZckphMWnKoG/ZjZ83UmL3tpviotsTlvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnibvdiVIAocjQ5tQfkmmY5MoXsYIE3O0iPZyvuf9UAtYCiuo3d0zZe/JdOaKdy8W
         XIDreFG7Z71ssfgAh/uo9mIVtndl5wREaVuNhQFJb45jRFF56dlRXH3q0Y4lr8eSpX
         2wbqSDuv5erxhrQWYCxA6KgkZO67owqN4h7cj306mLW7wyu2WTfaIyS06GkM0AyRQA
         R62OytjN6xHjTWtutIKrXE8LGSZ+/xc7pwVDimJxHuuZMIdKYmE4diTXFOm+3xViuh
         rV/qBYRkQyNUJADgw9tDgIyTjacOsNpZScGeSo3CimZbpebOBomfmfQ2526WWgvwvH
         CJa+jHvRkmfEA==
Date:   Mon, 19 Jun 2023 22:45:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230620054513.GB1590@sol.localdomain>
References: <20230619221048.10335-1-ebiggers@kernel.org>
 <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
 <20230619234939.GA2320@sol.localdomain>
 <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
 <20230620031813.GA1590@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620031813.GA1590@sol.localdomain>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 19, 2023 at 08:18:13PM -0700, Eric Biggers wrote:
> > That list does not help, quite the opposite - libsodium seems all but
> > abandoned (last release 5 years ago, an unmaintained project is not
> > exactly what you want for your crypto primitives)
> 
> libsodium has an active maintainer.  Last commit was 3 months ago.

Sorry, I hadn't run 'git pull' recently.  The last commit to libsodium was
actually today!  I don't know why the maintainer isn't tagging new releases more
frequently.  The last, 1.0.18, was 4 years ago.  But it seems unfair to call an
active project "abandoned" just because of lack of tagged releases.

Anyway, this is basically a moot point now, since in v3 of this patch I dropped
the mentions of any specific crypto libraries...

- Eric
