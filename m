Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43100 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdJZJqU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 05:46:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id a16so3048985lfk.0
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2017 02:46:19 -0700 (PDT)
Date: Thu, 26 Oct 2017 12:46:16 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
Message-ID: <20171026124616.2f2ef1d2@totoro>
In-Reply-To: <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com>
        <20171026120330.5360e427@totoro>
        <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Thu, 26 Oct 2017 02:08:25 -0700
Matthew Garrett <mjg59@google.com> ?????:

> On Thu, Oct 26, 2017 at 2:03 AM, Mikhail Kurinnoi
> <viewizard@viewizard.com> wrote:
> > ? Thu, 26 Oct 2017 01:31:44 -0700
> > Matthew Garrett <mjg59@google.com> ?????:
> >  
> >> @@ -317,7 +319,7 @@ void ima_update_xattr(struct
> >> integrity_iint_cache *iint, struct file *file) int rc = 0;
> >>
> >>       /* do not collect and update hash for digital signatures */
> >> -     if (iint->flags & IMA_DIGSIG)
> >> +     if (iint->flags & IMA_DIGSIG || iint->flags &
> >> EVM_IMMUTABLE_DIGSIG) return;
> >>  
> >
> > Isn't this mean, we already changed files data, and we just don't
> > allow IMA xattr update? This file will not pass integrity
> > verification next time.  
> 
> That's fine - policy may not care. It's easier to sign all files and
> then leave enforcement up to the local policy than it is to determine
> in advance which files will need protection.
> 
> > I thought, the idea was prevent data changes, and in this way
> > prevent IMA xattr update.  
> 
> No, the goal is to be able to detect when files have been modified and
> (optionally) restrict access as a result. Otherwise the packaging
> system has to be able to identify all files that may be legitimately
> modified, which is something that may differ depending on the client.
> It's much easier to permit the data modification and have the local
> policy block reading or execution if it's actually a sensitive file.

Hmm...
http://www.spinics.net/lists/linux-integrity/msg00151.html

probably, we should decide first, what exactly immutable EVM mean.
It's hard to propose something or test patch if we still have
misunderstanding in concept of immutable EVM.


-- 
Best regards,
Mikhail Kurinnoi
