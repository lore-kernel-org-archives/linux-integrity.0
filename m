Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:50228 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeJLBxO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 21:53:14 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so8884896ite.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-2-mjg59@google.com>
 <1539271337.11939.78.camel@linux.ibm.com> <CACdnJuupQ1vj-H-_Ru+uaGJa-Lhev=52=2RGyTbR1ms4LN3DpA@mail.gmail.com>
In-Reply-To: <CACdnJuupQ1vj-H-_Ru+uaGJa-Lhev=52=2RGyTbR1ms4LN3DpA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 11 Oct 2018 11:24:38 -0700
Message-ID: <CACdnJuscqpk-48Ahb4nNHNxawPq53FLKbLAdmmhmN_pp=jdqDA@mail.gmail.com>
Subject: Re: [PATCH 1/3] VFS: Add a call to obtain a file's hash
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 11, 2018 at 11:21 AM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Oct 11, 2018 at 8:22 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > This patch description starts out saying that IMA needs the file hash
> > without explaining why.  Without that explanation, simply extracting
> > the file hash included in the file signature might sound plausible,
> > but kind of defeats the purpose of IMA.
>
> I'm not sure how it defeats the purpose - IMA wants to know the hash
> of a file so it can either log it or compare it against a signature,
> and it currently obtains this hash by reading the entire file at
> measurement time. If the filesystem later returns different data then
> IMA won't notice, which allows a malicious filesystem to bypass the
> measurements - there's no guarantee that we won't evict large parts of
> the copy of an executable that IMA read, and the filesystem can give
> us back a modified page when we page it back in. So IMA fundamentally
> relies on the filesystem to be trustworthy, and if we rely on the
> filesystem to be trustworthy then we should be able to rely on it to
> accurately store and provide the hash of a file.

Oh, to clarify on the signature part of things - it would obviously be
inappropriate to, say, just read the hash out of security.ima and hand
that back. But for a hypothetical case where the filesystem itself
verifies the signature, then the filesystem would abort the
transaction if the signature didn't match and it seems reasonable to
avoid doing the validation twice (once up front and then again on
every read)
