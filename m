Return-Path: <SRS0=7MnC=O7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D3DC43612
	for <linux-integrity@archiver.kernel.org>; Sat, 22 Dec 2018 22:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB721939
	for <linux-integrity@archiver.kernel.org>; Sat, 22 Dec 2018 22:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITYVEZ2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392880AbeLVWrp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:47:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46146 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391185AbeLVWro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 Dec 2018 17:47:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so7770122ljh.13
        for <linux-integrity@vger.kernel.org>; Sat, 22 Dec 2018 14:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iEBfvz86kZnN5D1veZ6xPnnmLmS/phSyCWvqn7AGqEc=;
        b=ITYVEZ2OZKdQ7vCcE+VbJ5MIZSZyFlelbu8fKUd1aUoNvd6GN9uYEQeJ0SjQ6ax1NF
         NY7w/EuATBvBtiVL4Bc+x/hQJsuySGidcRIMi5XvagPj4t1O5n/aG6tQXLuTsi6IT6w0
         2MRye7XBYcKDRnulcNsRlS5HH28wYILShWylI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iEBfvz86kZnN5D1veZ6xPnnmLmS/phSyCWvqn7AGqEc=;
        b=Cm0Tk3s+U1SxG566Wt/LOXF1GYT7Dr2MUpf3nKkmxf1vP9MKoAAUqBwfjdLW8zUeDH
         txY0SjcFkaOqEF+CAm7ORF7OMzY/PgT82qBgkiNja2bpQhc5kOgmMutXjmLJNMLVn8zD
         zdl/DDlcELW2uHW1+f5vFlxRKdh4Do0pFOQDhs6tZqnuIsMogpBlTdnNMAyl0zr1jPuA
         l4JkhhM5kU5OnToO8VaeQiFp43/KfDKsobIOkU0EvC7VaCtt6Dqh/1lYcVEkGaeU0rk/
         BWv27oC8jSHEcjkQ3Szy6u3uUl11/OQw9BnLY/7bL0n3Mc4bJOFr5dGJmZh0vy1y8u3b
         DAaw==
X-Gm-Message-State: AA+aEWazN4OclWlRAjMGrwAej6xTphvINzf5aPPAuxodjDxhRa816Iyx
        z1HDUFVW4YJhLarSI5lQlUoSYLwK6es=
X-Google-Smtp-Source: ALg8bN5hM8+tfRoguPEfjWWFCdHanUoSoysnAQZDrt9alGg/18iV5Tg6/7XZsbXBNdm4h+Iehn+N+Q==
X-Received: by 2002:a2e:4784:: with SMTP id u126-v6mr4545888lja.124.1545518861316;
        Sat, 22 Dec 2018 14:47:41 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x24-v6sm6078784ljc.54.2018.12.22.14.47.39
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 14:47:39 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id e26so6291370lfc.2
        for <linux-integrity@vger.kernel.org>; Sat, 22 Dec 2018 14:47:39 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr4334254lfc.147.1545518858888;
 Sat, 22 Dec 2018 14:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20181219071420.GC2628@infradead.org> <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu> <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu> <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu> <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
 <20181222041712.GC26547@mit.edu>
In-Reply-To: <20181222041712.GC26547@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Dec 2018 14:47:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPz4dfq4sPWxHwMR3g_R3xHhWjofXTu8rV0QU2DP0JhA@mail.gmail.com>
Message-ID: <CAHk-=wgPz4dfq4sPWxHwMR3g_R3xHhWjofXTu8rV0QU2DP0JhA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
To:     "Theodore Ts'o" <tytso@mit.edu>,
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
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 21, 2018 at 8:20 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Dec 21, 2018 at 11:13:07AM -0800, Linus Torvalds wrote:
> >
> > In other words: either the model is that the file *itself* contains
> > its own merkle tree that validates the file, or it isn't. You can't
> > have it two ways. No silly "layout changes when you apply the hash"
> > garbage. That's just crazy talk and invalidates the whole model.
>
> Userspace applications which are reading the file aren't going to be
> expecting Merkle tree.  For example, one of the use cases is Android
> APK files, which are essentially ZIP files.  ZIP files can be parsed
> both from the front-end (streaming), or by looking for the complete
> directory of all of the files in the ZIP file by starting at the end
> of the file and moving backwards.  If the Merkle tree was visible to
> userspace programs that are opening and reading the file, it would
> confuse them mightily.
>
> So what we do for ext4 and f2fs is make the Merkle tree invisible

Again, this has nothing that is per-filesystem in it.

If we were to decide to support the notion of "append merkle hashes to
the file for validation" at the vfs layer, the same logic would apply:
obviously the merkle data shouldn't be visible to user space.

But that's not a reason to do it at a filesystem layer, quite the
reverse: exactly like you say, as far as the *filesystem* is
concerned, the data is there in the file. It's literally about the
*view* of the file, ie the system call interface:

>    From the *file system's* perspective,
> though, the metadata blocks are part of the file.

To me that only argues that this all should be at the vfs layer, and
that it shouldn't be the filesystem that hides it. Exactly because as
far as the filesystem is concerned, the merkle data is there, it's
just that we hide it at read (and stat) time.

Preferably some way where it's namespace-dependent or whatever, so
that you could still access the original file data from user space if
you want to (eg some backup purpose or other).

What I'm missing is any kind of sane explanation for why it was done
so badly, and why it should be upstreamed despite the apparent bad
implementation.

It sounds like a complete hack.

Again, to me either the point is that it's a generic extension of the
file data, _or_ it's some filesystem-specific hidden data. The way
you've done it and written the documentation, it's clearly a generic
extension of normal file data, and I don't see what's fs-specific to
it.

> The problem is that xattrs are designed to be accessed via a set/get
> interface, are currently limited, IIRC at 32k.  The max size of an APK
> is 300 megabytes; and the Merkle tree for a file that size will be
> about 2.3 megabytes.  That's way too big to store as an xattr;
> certainly using the existing xattr interfaces.  And it's also bigger
> than most file systems can handle as xattrs today --- because they've
> been optimzied for relatively small sizes, for things like SELinux
> labels and ACL structures.

So *this* kind of argument is what I'm looking for.

That at least explains why it's not an xattr. Ugly, but understandable.

> > So why is this sold as some unholy mess of "filesystem-specific" and
> > "generic"? That part just annoys the hell out of me. Why isn't this
> > sold as an *actual* generic model, where you just say "append the
> > merkle tree to the file, then enable verity testing of the end result
> > and validate the top-level hash".
>
> That was the original way it was sold, but Cristoph and Dave have
> NACK'ed it in that form.

That seems entirely irrelevant. What do Christoph and Dave have to do
with it once it's generic? It would have _zero_ filesystem component
if it's actually done in a generic manner. It would be a total no-op
to XFS.

Which makes me think "it wasn't actually sold as being
filesystem-independent" at all.

So I want to understand why this was made a filesystem operation in
the first place. What's fs-specific about this implementation?

                 Linus
