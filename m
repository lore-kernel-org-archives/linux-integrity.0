Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:43146 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLCM0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 22:12:26 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so7377757ioa.10
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-2-mjg59@google.com>
 <1539271337.11939.78.camel@linux.ibm.com> <CACdnJuupQ1vj-H-_Ru+uaGJa-Lhev=52=2RGyTbR1ms4LN3DpA@mail.gmail.com>
 <CACdnJuscqpk-48Ahb4nNHNxawPq53FLKbLAdmmhmN_pp=jdqDA@mail.gmail.com> <1539283047.11939.95.camel@linux.ibm.com>
In-Reply-To: <1539283047.11939.95.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 11 Oct 2018 11:43:47 -0700
Message-ID: <CACdnJus0ZEa4H3h_R5Lwe7j7r2o=MOpeBnfWChyoPHKmm9zbog@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 11:37 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2018-10-11 at 11:24 -0700, Matthew Garrett wrote:
> > But for a hypothetical case where the filesystem itself
> > verifies the signature, then the filesystem would abort the
> > transaction if the signature didn't match and it seems reasonable to
> > avoid doing the validation twice (once up front and then again on
> > every read)
>
> Right, this is a hypothetical scenario as far as I'm aware, since none
> of the filesystems are currently calculating and storing the file
> hash.  The default should be for IMA to re-calculate the file hash.

There are FUSE filesystems that do.
