Return-Path: <SRS0=ZD6g=O3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D9C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 00:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69F2086C
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 00:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jenv5oE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLRAhO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:37:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38135 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRAhO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Dec 2018 19:37:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so12678396lja.5
        for <linux-integrity@vger.kernel.org>; Mon, 17 Dec 2018 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwYTHo0lnqHOWhe65fNPvti8gjLyH+tTQ6Hiz2yL+KU=;
        b=Jenv5oE17ioo7RmUV+5lWpqj8Bb3wwbDmTvtfVUCRhIFfnaExLWZ581NcoXjYizJk4
         HUSFeVVFH8aX+s4fKoChvieQOsMAPQirCL5PqQcRZkUt6Yx/a93Ss7cA/w+L+qBd+ilS
         GE7b40xsnMThQhM4TRpPxzIKgFSNyYdwZVFRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwYTHo0lnqHOWhe65fNPvti8gjLyH+tTQ6Hiz2yL+KU=;
        b=CxOru59uXy8OYQ80Ca4S7mQeRXYohkrLCqK/JnvKO1aK6/PdbRdUYBcdor1zJnzOzS
         LIkqW+6WLPTTpygSP1qnEdMakiwux3ttYx1YVijqSKf1d3vslIKL8LfuzQVR/sXpTa9T
         gjblZ+/ZK0ZebdHMUmBuhLIvEliBfs2zlWAsGIns8ewggkV2+1QmgXUjWetLpLUh9iLo
         X7Zh6+IHYejHxxHK2hn9mPEtxEkQQox7XwsLJJguMnh917LYOvoFH6ktud8JxK0eFLd+
         3c6u5Q6Z7M/kYZcZIvG9KePYXgCu7pnYoUdYWK53+l2zl56hdOYyBBa4SmuUEn29+3Fj
         6dsA==
X-Gm-Message-State: AA+aEWZBdQUe+wlXpiPjcKA1Sf0jDdF7Hn0hKW/OaNIxabppj6MVd7Yn
        9Npjzo4E9ijTWkE6WYmo26iAE/tnwDU=
X-Google-Smtp-Source: AFSGD/US19wqTXqrbrjjgWttE5b6Ufgw8fWYNvoxye/6uEqUzgx+GVgHJIakCqIlmot3dFBowx8vJw==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr8597830lji.145.1545093431820;
        Mon, 17 Dec 2018 16:37:11 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k13-v6sm173582lje.89.2018.12.17.16.37.10
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:37:11 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so12649566lji.7
        for <linux-integrity@vger.kernel.org>; Mon, 17 Dec 2018 16:37:10 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr8928017ljs.118.1545093430422;
 Mon, 17 Dec 2018 16:37:10 -0800 (PST)
MIME-Version: 1.0
References: <1545092089.4206.5.camel@linux.ibm.com>
In-Reply-To: <1545092089.4206.5.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 16:36:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
Message-ID: <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
Subject: Re: [PATCH] ima: cleanup the match_token policy code
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 17, 2018 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Start the policy_tokens and the associated enumeration from zero,
> simplifying the pt macro.

I applied this directly, since I decided to just commit my own "don't
use negative Opt_err" patch for the test_and_set_bit() cases, and they
kind of go together.

There's still a -1 in security/keys/encrypted-keys/encrypted.c, and
there are also three cases of "Opt_error = -1" in the security layer.

All of which look pointless and wrong, but not actively buggy, so I'll
leave them alone.

                 Linus
