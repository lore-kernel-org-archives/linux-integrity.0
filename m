Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29776C282CA
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50972184A
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQcromYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfBLNre (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:47:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40560 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNre (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 08:47:34 -0500
Received: by mail-yw1-f67.google.com with SMTP id c67so1005038ywa.7;
        Tue, 12 Feb 2019 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH2LQMGehFktdZtEQ44eiCdcC6F2z1e7cM+Ec6kpcAY=;
        b=AQcromYxlgSrRaScVcnuC6SYdrhzEy+A/gMxm+/+DxYeNCk0oUhYq01CWqziOJaoHo
         DnXPIU/p0DY+du9/IKT4hdBSK7FbUrBeKev0l6z6TnO8QgH7tHP2Ay61MNdTsVhJ/zY0
         22SrzRyzhE+nSuhF9vFKd2cz5o+aslm0ILmVxn/f3cxA1qG9zj/Bgpx9zMyA2hWM5Oz4
         u6Pbo0wmIpazeZXijcnOClWbrYs7uIcFlGM5y/qtlxSr9ijoVWaJqOAKoBr3UAYkS3hY
         jjpuIy2Zl9UCJWsYlTca1fOw7vvoUvfXyZ8gOAWW3MYeYupa2m9Nm0zIFPFVOgPHqRLc
         fBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH2LQMGehFktdZtEQ44eiCdcC6F2z1e7cM+Ec6kpcAY=;
        b=igkF0pHgrtsciqwn26RTkAm++YDfDkUjMljwQFup1K+aCgTwc7FDvNoFZwRnsbjtIg
         6XlbRUNvODJYdFvw7y5p+X9BVcahA3FCn5QEoYHdJmhpQzDLxR36zK56dreLkOlqQIQr
         doul8PoaJTE4G50u3cnWsNhVcB1asCEQC5LJK5X4D3+eg6IDKjnBoJB19YZIcQjlfU0W
         Yq6Np0DQnM3ttDhZ944dBN722PzwE4dHsSaDZdDSwXihxQv6RbMXNhiDNmeCCXvc5J1l
         h4htnewmTbDLTfWQUz78yIKJG0Vc2LCNirT6D+lK1M6FfasBC+LQCdUg61HxmHFE3c86
         H9Rw==
X-Gm-Message-State: AHQUAuaeJrXU0Ti8C9IZTcwNSItN5pU4X7ojzf4ppTuAgenB7U6iWmqu
        EmUTSohKazJGB6bHCeNYCfpvLQwdUmzEHUCeO80=
X-Google-Smtp-Source: AHgI3IZrNxpsjwCdtlOMuS10vQ1Uqc8iSruWbXEXkbcH8SJQ5/3hoY0JrOz85aouOtZUkPIDSWlrICVmxV+xVqroPc4=
X-Received: by 2002:a81:2e86:: with SMTP id u128mr21044ywu.241.1549979252431;
 Tue, 12 Feb 2019 05:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20190211165323.9369-1-iforster@suse.com> <CAOQ4uxhyk7BEmQYf8D6j8FvYJGaxPoa2oJePeF42jbdp__=PSA@mail.gmail.com>
 <3938260.lArqBy00Sx@linux-e202.suse.de>
In-Reply-To: <3938260.lArqBy00Sx@linux-e202.suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Feb 2019 15:47:21 +0200
Message-ID: <CAOQ4uxgSZv7t5HznAhsWrzv3e3VwQ7sbZrjgjfRsviq-wsr7EA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Fix overlayfs on EVM
To:     Fabian Vogt <fvogt@suse.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 12, 2019 at 12:55 PM Fabian Vogt <fvogt@suse.de> wrote:
>
> Hi,
>
> Am Dienstag, 12. Februar 2019, 04:29:30 CET schrieb Amir Goldstein:
> > On Mon, Feb 11, 2019 at 10:28 PM Ignaz Forster <iforster@suse.com> wrote:
> > >
> > > From: Ignaz Forster <iforster@suse.de>
> > >
> > > This patch series tries to solve several problems found when using
> > > EVM on an overlay file system.
> > >
> > > Especially patch 4 and 5 will need further discussion; patch 4 will
> > > introduce follow up problems, patch 5 can be considered a workaround
> > > at best.
> > >
> >
> > I think maybe the entire series (short of vfs_create hook) is a workaround.
>
> Correct.
>
> > Let's stop and think. What is IMA/EVM meant to do?
> > Provide tamper proof protection for persistent storage. Right?
> >
> > Overlayfs uses other filesystems to store persistent data/metadata,
> > so if IMA/EVM already protect those other filesystems, we got
> > tamper proof already don't we?
>
> Yup. There are two approaches overlayfs can interface with IMA/EVM:
> a) (vfs) -> IMA/EVM -> overlayfs -> filesystem
> b) (vfs) -> overlayfs -> IMA/EVM -> filesystem
>
> Both are from my view equally valid, just with different issues.
> Currently the first approach is used, as all IMA/EVM and security hooks
> are invoked from the "high-level" vfs functions and overlayfs calls
> the lower functions to interface with the underlying filesystems, skipping
> all those checks/processes.
>
> Doing b) has the disadvantage that overlayfs needs to become IMA/EVM-aware
> (or use the high-level functions for everything) and special care needs to
> be taken to a) do IMA/EVM work properly b) not do it twice.
> It would avoid an entire class of IMA/EVM issues though, by only doing work
> on the actual filesystem nodes and not on the virtual overlayfs ones.
>

overlayfs doesn't need to become IMA aware.
It's mostly the other way around.
And BTW, overlay is not the only code calling vfs_xxx helpers
knfsd does that as well.

The fact that nfsd_open() has a ima_ hook means IMA hooks
are not low enough in vfs.

> > The issue with overlayfs and security hooks is often credentials
> > because underlying filesystems are accessed with different
> > credentials (mounter credentials) than the overlay file access.
> > Is that an issue for IMA/EVM?
>
> I'm not familiar enough with IMA/EVM internals to comment here, but I assume
> that IMA/EVM is only invoked after a related operation succeeded, e.g.
> security.ima is only updated after a successful write. So this shouldn't be
> an issue (?). We could do some tests, but I'm not sure what we would need to
> look out for.
>
> > Or is it an issue that IMA policy is path based and may only
> > apply to the overlay path and not underlying path??
>
> I'm not quite sure what you mean by that - I've never seen any paths involved
> in the IMA policy (/sys/kernel/security/ima/policy).
>

I've never seen an IMA policy, but I read that IMA policy can be per file,
so the underlying filesystem files must be enforced by IMA policy.

> > I had already suggested once to mark overlay inodes with
> > NOIMA flag:
> > https://marc.info/?l=linux-unionfs&m=154529013929472&w=2
> > and there was a similar suggestion for FUSE:
> > https://marc.info/?l=linux-fsdevel&m=151871326115716&w=2
>
> That explains why it was also broken with unionfs when I tried that briefly,
> I expected that FUSE mounts would just ignore IMA and due to access from
> userspace work properly with IMA/EVM OOTB as well - apparently not yet.
>
> > If my assumptions so far are correct, then the effort for making
> > IMA/EVM work with overlayfs should focus around finding the
> > places where overlayfs uses lower level vfs interface (often
> > vfs_xxx helpers) and make sure that the IMA hooks are place
> > in those lower vfs interfaces, just like vfs_create() patch does
> > and like vfs_tmpfile() patch did before it.
>
> So basically turning on NOIMA for overlayfs while ensuring that integrity
> checks and operations still perform as expected?
>

Yes.
As far as IMA is concerned, Overlayfs is like a filesystem user from kernel.
Very similar to knfsd in that respect.

Thanks,
Amir.
