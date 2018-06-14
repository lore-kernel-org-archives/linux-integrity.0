Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52516 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755280AbeFNTnQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jun 2018 15:43:16 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so9848987itg.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jun 2018 12:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180417225601.6965-1-mjg59@google.com> <20180417225601.6965-2-mjg59@google.com>
 <1528846954.3874.16.camel@linux.vnet.ibm.com>
In-Reply-To: <1528846954.3874.16.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 14 Jun 2018 12:43:03 -0700
Message-ID: <CACdnJuvyY3qQms+xxvWoLpcXC8aE0efnKJo37fWDWtyG3fUhhQ@mail.gmail.com>
Subject: Re: [USER] [PATCH 2/2] Add security.apparmor to the set of extended
 attributes used by EVM
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jun 12, 2018 at 4:42 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:
> > The kernel is taking security.apparmor into account when validating EVM,
> > so evmctl should be doing the same.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
>
> The XATTR_NAME_APPARMOR is dependent on the version of
> "/usr/include/linux/xattr.h".  Without it defined, evmctl fails to
> build.

Hmm, true. Is it reasonable to just hardcode it rather than using the define?
