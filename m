Return-Path: <SRS0=gF99=O5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8656C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 07:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F3C20815
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 07:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2eFAQN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeLTHPh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:15:37 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:35854 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLTHPh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Dec 2018 02:15:37 -0500
Received: by mail-yb1-f170.google.com with SMTP id 64so293371ybe.3;
        Wed, 19 Dec 2018 23:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlkYvVnFu4T4kFRtq2MXrLxgjuAq0XxPOfD09KeMTKw=;
        b=i2eFAQN83Ws5cIKjTLpXNpt1mhL25x5uNpFk77yfHQUJrbnvaOcgJtMVC1PKtwmtTM
         l558VRrceaqk805RIGxd1+2lIzozpVe4O4/cp/iTcmFVcAD4R0gryNy2OBs25AevMFS2
         H2cG30CBJdQHUnhTtrZ+sN1lVID19Sm3nopStrU1C48jks2Yt9I+RRaMShj3v4o7Wzi/
         HlftCJgoep4KqpkYfPoB5Dl9T9mnpF6shXjaa+xgf61RialRxg5d8Lw5mT/RBGIrXCto
         CkSfD18Wk4VBWk1FyoisDii4gzhMBpWA2hBwNaX6miiqM4k9b+5oKs0b/BPWNj7GTVAb
         7RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlkYvVnFu4T4kFRtq2MXrLxgjuAq0XxPOfD09KeMTKw=;
        b=HpevVlByf/kz6K11/jw/t017ExhmzhKxvCaeYqNCB3Lsj1IDrZymt0S27IC6XBWi2m
         /1XcoBnl2wpDQimwfhO5yjzyK4TdxDvtgBs/cORzG5v1KzL7anP2QRzbmbfRPxfOxeXi
         WWTeQCWGeh52xq12UBW2RT8c9vB5hNHIhxOiTDQAOrXo1dQi6OvIaQTzvGLoVhRhuiF0
         p3zTH6SGDVTSMVPiEKReGl5nLlIhb1eeTQNIeYcLk9hGMmpGwZG3CKW9Eaoj6UzW6tRW
         A0HFtw1v8E6B0cCj4xiIOoKqxz0o/1trtMdIWo4WHrE0+Gja8MAB27RyQvrKPY9jqwdk
         SS0Q==
X-Gm-Message-State: AA+aEWYfHRtaJZvR69ieGnqq3KY5D28b4AsC1IvN5JIUbgUsbIlnaZth
        NfRPyuXKgpY2ZsaUN6FWHVhMPAfKroYZu9V+2xM=
X-Google-Smtp-Source: AFSGD/UExp/ziPa8eeUsGIij7Qgvhu2e39jFpqraYDJDoV3Xv011FfZm3vXB67ebWPuQHED1qKvOkcDo37dXR4h7iBY=
X-Received: by 2002:a25:c3c3:: with SMTP id t186mr15455389ybf.337.1545290135794;
 Wed, 19 Dec 2018 23:15:35 -0800 (PST)
MIME-Version: 1.0
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de> <1545174031.4178.8.camel@linux.ibm.com>
 <1545233975.3954.8.camel@linux.ibm.com> <CAOQ4uxgoMntXsxnsxtBOOPLDo3HgcYPWayuCuDzxEx2GJSMZtg@mail.gmail.com>
 <20181220034200.wfft5d543tje5zpy@merlin>
In-Reply-To: <20181220034200.wfft5d543tje5zpy@merlin>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Dec 2018 09:15:24 +0200
Message-ID: <CAOQ4uxgOj=BzaFML2qk8CnNid7Nbm5ktNg8=mK-kcVXO1kQWcw@mail.gmail.com>
Subject: Re: EVM: Permission denied with overlayfs
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     zohar@linux.ibm.com, iforster@suse.de,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 20, 2018 at 5:42 AM Goldwyn Rodrigues <rgoldwyn@suse.com> wrote:
...
> If I understand it correctly, overlay performs copy_up using a temporary inode,
> and finally copies the attributes to a "real" upper inode after the copy_up is
> successful. However, integrity or ima gets control for calculation and
> verification of the inode during the temporary phase which is not the same as
> the final "upper" inode.
>

No, that's not ow it works.

What happens is as follows:

For brevity, let's discuss a file that was created in overlayfs, not
lower and not copied up.
The latter are just private cases that are less interesting to the
problem at hand.

When changing metadata of an overlayfs file notify_change() will first be
called on the overlay dentry and then on the real underlying dentry.
See, overlayfs completely relies on underlying fs for anything persistent,
so set_xattr on an overlay dentry will (most likely) forward the set_xattr
values to underlying dentry.

So my guess is that on the first (outer) nofity_change() security.evm is
calculated by overlayfs ino/generation and stored in real inode.
On the nested notify_change() call for the underlying dentry, security.evm
will be recalculated and stored (again) in the real inode.

On the verify path ima_file_check() and friends used to be called once pre v4.19
with an overlayfs file, whose file_inode/file_dentry is the real inode/dentry.
With v4.19 stacked file operations, ima_file_check() and friends are
called twice
just like notify_change(), once for the overlayfs file and then for
the underlying
"real" file (the "real" file has overlayfs f_path and underlying
file_inode/file_dentry).

Now according to my understanding of the EVM feature, the metadata of the
overlayfs wrapper object is utterly not interesting and measurements should only
be made on objects representing files written to local storage that
could be tampered with.
Considering the fact that any access to overlayfs object, both set and
get attributes
will always access the underlying object and go through EVM verification,
there needs to be no verification nor calculation of EVM signatures on
the overlayfs
wrapper object.

IMO the right way to fix this would be by setting an SB_NOIMA flag on
overlayfs and
skip the IMA/EVM hooks for overlayfs file_inode/file_dentry.

HOWEVER! you should take extra care to NOT access file->f_path->dentry
in integrity check code, because this is the overlayfs dentry even for "real"
files. AFAIKT, the only place where integrity code accesses file->f_path->dentry
is in Goldwyn's recent fix to ima_calc_file_hash().
                f = dentry_open(&file->f_path, flags, file->f_cred);
returns an overlayfs file with an overlayfs file_inode/file_dentry
even when called
with the "real" file.
It doesn't matter much in the context of ima_calc_file_hash(), because the inode
size and data are always guarantied to be the same for overlayfs and underlying
inode.
You may want to consider using open_with_fake_path() instead of dentry_open().
I think that is called for, but you definitely need an ACK from Al
before doing that
considering his harsh disclaimer [1].

Thanks,
Amir.

[1] commit 2abc77af89e17582db9039293c8ac881c8c96d79
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jul 12 11:18:42 2018 -0400

    new helper: open_with_fake_path()

    open a file by given inode, faking ->f_path.  Use with shitloads
    of caution - at the very least you'd damn better make sure that
    some dentry alias of that inode is pinned down by the path in
    question.  Again, this is no general-purpose interface and I hope
    it will eventually go away.  Right now overlayfs wants something
    like that, but nothing else should.

    Any out-of-tree code with bright idea of using this one *will*
    eventually get hurt, with zero notice and great delight on my part.
    I refuse to use EXPORT_SYMBOL_GPL(), especially in situations when
    it's really EXPORT_SYMBOL_DONT_USE_IT(), but don't take that export
    as "you are welcome to use it".

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
