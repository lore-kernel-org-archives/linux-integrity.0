Return-Path: <SRS0=OrKi=PZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17052C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101B20851
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bubrk7bN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfAQPoa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:44:30 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34375 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAQPoa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jan 2019 10:44:30 -0500
Received: by mail-yb1-f194.google.com with SMTP id w186so3174331ybg.1;
        Thu, 17 Jan 2019 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoMGxuClm0gTLNfv693oyborBxqFnhcoW5GmTGaSjC4=;
        b=bubrk7bN5+PUe8hjt7dlIaca/cUxXs+Mf1pdV4TIB1GzbrJIj4/saosaPt20HVHUli
         ovMSHTi0S+cWmjG5hF+0Qbh1cF2dEEAJW0eqBqO5oDI1MM/rvcAXXTN3qFDibHkzx7zw
         qsx9tFtKMeLQEUikmVeXL8AQ1T1qnhJt41jyd2t7IFVCOoVQKgmh5A3PoEQp3AbUgvBG
         lCVGnxDPay8SnnnHK8MtUjQduCoehEm1NdFSWbrVRQtih6VY39ZMRXJ64W+F2BbAxl5H
         8ZSnViATx91NyxXfb1TfyIOPkl8b1eag1/+dIwsdt8pSay/6pSnEL2k9GUM23ME5Zhlp
         Nb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoMGxuClm0gTLNfv693oyborBxqFnhcoW5GmTGaSjC4=;
        b=botFlWT1vMSVRL1GvacuxYXDYUq9INI3lyeUz4ffPlgFszvIGYp1/9Jo8/ZjB1C6li
         iwnAQ+Ow9LKUCNnWZQTf8A2RfJX2G9Tpiap7X5ZV4hOFivSxQ8f550hLU3z+lNazLj+5
         Ikpep48CXe7/gTRa6aSedIXjnO2UpNkoHQ8+vZdG85+Aa0Pf9xHXJzegUr6r5EFKhSbO
         pBWiMU+HXoQQNl0rwFyWS5iPknEh4uY+Ny7W0aW6rB26Y0MXhUrGtoEo/lr6Jvqw64Pk
         I4xuRHn3kGHgzrCvX5S7JFxWooNIFHQKLz/HHbYpYCjfYfVPl3eK2ejo+4sM66S5cRpH
         j48Q==
X-Gm-Message-State: AJcUukdU6yY+aAyXIitEzKABkO15vf5HR090NP0hpg/jr/ZVkFSuZO8w
        AMre1vncI/mHAq2kj0bEm+KEAHTZPuVrujS86cNusCEQ
X-Google-Smtp-Source: ALg8bN6x2W2v4KalzHnJujJo+8UP/CojF+RAyIF6tZ9DDoGDm47G0WatnJjfoNqTElSohNOVRCcjAwH9qLtEUKtZ/i0=
X-Received: by 2002:a25:7b43:: with SMTP id w64mr2501953ybc.397.1547739868942;
 Thu, 17 Jan 2019 07:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20190116173945.mmnwsw5bglk6yryj@merlin> <CAOQ4uxgDi38dX0VLfHZ8R_fesN=0rBQB7Cw0ObRqy5fUqFepTQ@mail.gmail.com>
 <20190117150212.t4snb6jynran2dvn@merlin>
In-Reply-To: <20190117150212.t4snb6jynran2dvn@merlin>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Jan 2019 17:44:17 +0200
Message-ID: <CAOQ4uxiO491WYPBAf1zZCfL-nzEz0kzPNRBcXr5MrexWNjZb7Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: IMA Call ima_post_mknod_path() on copy_up'd dentry
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>, zohar@linux.ibm.com,
        iforster@suse.de, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 17, 2019 at 5:02 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On  8:57 17/01, Amir Goldstein wrote:
> > On Thu, Jan 17, 2019 at 1:22 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > >
> > > Since copy_up() happens when you are modifying a file on overlay,
> > > it is still a new file for the underlying filesystem. Mark it
> > > in IMA for re-evaluating as a new file.
> > >
> > > Putting ima calls within overlayfs may not be the best method, but this is
> > > the only one which I thought would work.
> > >
> >
> > Doesn't look right.
> > Overlayfs creates the new inode with vfs_tmpfile() and I think that is
> > where you should plug the IMA hook.
> >
> > > Here is a test case:
> > > mount /dev/vdb /lower
> > > mount /dev/vdc /upper
> > > echo "Original contents" > /lower/existingfile.txt
> > > mount -t overlay overlay /mnt -o upperdir=/upper/upper,workdir=/upper/workdir,lowerdir=/lower
> > > echo "New contents" > /mnt/existingfile.txt
> > >
> >
> > I bet you can reproduce that same issue without overlayfs
> > by creating an O_TMPFILE from userspace.
> >
> > The ima_file_check() hook in do_last() does not cover the O_TMPFILE
> > case.
> >
>
> The problem you mention was resolved by https://lkml.org/lkml/2018/12/18/809
> which I have in my tree.
>

The proposed hook ima_post_create_tmpfile() inside do_tmpfile()
takes a file argument, uses only file_inode() and sets IMA_NEW_FILE.

Now because that hook does not get called from vfs_tmpfile()
you want to add more ima hook inside overlayfs code after calling
vfs_tmpfile().

If you move the IMA hook inside vfs_tmpfile() and pass the dentry
or inode, you will get the same result and you won't need to change
overlayfs code.

Is there a problem with that proposal?

Thanks,
Amir.
