Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:50981 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeGFNc4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jul 2018 09:32:56 -0400
Received: by mail-it0-f43.google.com with SMTP id u4-v6so16551476itg.0
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jul 2018 06:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_x4bQzLuvf2iOFLBevGLx+s8tmA+m1A+q1wFECiVCReTQ@mail.gmail.com>
 <1530878344.12156.53.camel@linux.ibm.com>
In-Reply-To: <1530878344.12156.53.camel@linux.ibm.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Fri, 6 Jul 2018 14:32:45 +0100
Message-ID: <CABatt_xgOLCx+RaJEuOs-8BwkEdkmLkqcijKP6yj+ALoVFTc0Q@mail.gmail.com>
Subject: Re: Question on IMA Policy
To: zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

On Fri, Jul 6, 2018 at 12:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Martin,
>
> On Fri, 2018-07-06 at 10:46 +0100, Martin Townsend wrote:
> > Hi,
> >
> > If I have a root filesystem signed for IMA/EVM could I have a policy
> > that says appraise every file on this filesystem.  Looking through the
> > source code I think I could use
> >
> > appraise fsuuid=uuid-of-root-fs appraise_type=imasig
> >
> > Would this do what I want?
>
> Yes, that looks right.  Remember all files on this filesystem will be
> considered "immutable", meaning you won't be able to write/update
> them, only delete them.
>

Thank you and being immutable is fine.

> Mimi
>
