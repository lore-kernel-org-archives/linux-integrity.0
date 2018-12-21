Return-Path: <SRS0=Hy7N=O6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9EC43387
	for <linux-integrity@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6021929
	for <linux-integrity@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/KXPV7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbeLUTNe (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:13:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43597 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391554AbeLUTN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Dec 2018 14:13:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so5657961lji.10
        for <linux-integrity@vger.kernel.org>; Fri, 21 Dec 2018 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GoaAF/5YI5Z45IZvCYu5JL7bMo3j0XtljW+8zGPMK0s=;
        b=a/KXPV7n0rvMsJnMnbJzEBym23mlzA+RFBmS6UI5Xw56BbHkyLfli0p+TgOAq9tDpm
         FSJh8wHalcdAXf4r2n0okZfdsHaNnHuL3Tv+TqYO1LSXu3qkOLqW/WgVGI1OBD20u2Ip
         u4DUX8tLzYgLqRkKDJvDE4Vjp3Wp6hOTk2bBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GoaAF/5YI5Z45IZvCYu5JL7bMo3j0XtljW+8zGPMK0s=;
        b=X3q3ATL/Cq36nhnoSbUSd2J+Ybu3lLxvAgDigjPBYG1wpneRFiEwSdM0OmUi6tXgWv
         WQ1tMPAC4r6GGneCTm2Aqxcfo2D/ZYsddhtb1YGm2bjFyPo/BezgoDEsRCvNxOzYKgPQ
         poiGmfw4QUeWHxGiYDcp2IAFvhrzTANFOss4zhcxKtxVuo98Ojd9eIZ33dgN7oq7Uvz+
         x2ivDYvqvQmofDTgdNAtAJhzcK6SXhI/nPAClWKVz/6zVhytdXgTlKr+1yMLuQ1fCX46
         ZJJclZ9cpp3Dm5B7aG1o0IBgANr76qjJ/pIO2ELfYm1UDLr2BTWXX73hsZ1Wv6/AtA09
         N3OA==
X-Gm-Message-State: AJcUukc1tbcTgrEmU83TTg+Bzmqijbt10OUO8gfwhnW7UdRhVd/vXrW5
        sHwrOjESG+lQZftu4+ZWg7LVFRXNpXM=
X-Google-Smtp-Source: ALg8bN74mKcESFy3EL0WTBrzQzzGZR9NDzVZD6F0Plqcu25903YX+zbUkzh6ptT4q5PGOZMD+nkZDw==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr2272600ljj.98.1545419606643;
        Fri, 21 Dec 2018 11:13:26 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p91sm5122123lfg.4.2018.12.21.11.13.23
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:13:24 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id q2-v6so5657790lji.10
        for <linux-integrity@vger.kernel.org>; Fri, 21 Dec 2018 11:13:23 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr2429758ljs.118.1545419603234;
 Fri, 21 Dec 2018 11:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20181219071420.GC2628@infradead.org> <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu> <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu> <20181221070447.GA21687@infradead.org> <20181221154714.GA26547@mit.edu>
In-Reply-To: <20181221154714.GA26547@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 11:13:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
Message-ID: <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 21, 2018 at 7:47 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Linus --- we're going round and round, and I don't think this is
> really a technical dispute at this point, but rather an aesthetics
> one.

Grr.

So honestly, I personally *like* the model of "the file contains its
own validation data" model. I think that's the right model, so that
you can then basically just do "enable verification on this file, and
verify that the root hash is this".

So that part I like. I think the people who argue for "let's have a
separate interface that writes the merkle tree data" are completely
wrong.

HOWEVER.

I do agree that your particular model is pretty damn broken in lots of ways.

Why is it filesystem specific? If the whole point is that the file
itself has its own verification data (which I like), then I don't see
why this is then documented as some filesystem-specific layout model.
That's complete and utter garbage.

In other words: either the model is that the file *itself* contains
its own merkle tree that validates the file, or it isn't. You can't
have it two ways. No silly "layout changes when you apply the hash"
garbage. That's just crazy talk and invalidates the whole model.

And honestly, I still think that it's very odd to add the merge data
to the end, when the filesystem already supports xattrs. It would have
made much more sense to just make one xattr contain the merkle tree
validation data.

So why is this sold as some unholy mess of "filesystem-specific" and
"generic"? That part just annoys the hell out of me. Why isn't this
sold as an *actual* generic model, where you just say "append the
merkle tree to the file, then enable verity testing of the end result
and validate the top-level hash".

That kind of thing could be done with absolutely _zero_ per-filesystem
code, and made 100% generic, and we'd just verify the merge data in
readpages().

So what's the excuse for doing the crazy odd "let's just support one
single filesystem" model?

                    Linus
