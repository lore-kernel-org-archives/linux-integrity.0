Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:48493 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdJJWYr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 18:24:47 -0400
Received: by mail-it0-f53.google.com with SMTP id c3so567612itc.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 15:24:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507674107.17219.12.camel@linux.vnet.ibm.com>
References: <20170908174348.7565-1-mjg59@google.com> <1507674107.17219.12.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 10 Oct 2017 15:24:45 -0700
Message-ID: <CACdnJutP=yyRPdf=RUTzJ=hU5V5QLMwKborfh2UfMKs5y7bGpQ@mail.gmail.com>
Subject: Re: [PATCH] IMA: Add support for IMA validation after credentials are committed
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-ima-devel <linux-ima-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 10, 2017 at 3:21 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> I was hoping we could replace the existing bprm_check with the new
> creds_check, but not all of the binfmt's registered are covered. Only
> those that call install_exec_creds() are covered.  This should
> probably be reflected in the ima_creds_check() description.
>  Otherwise, the patch looks good.

The semantics are different - bprm_check will check sub_user and co
against the pre-exec() credentials, creds_check against the
post-exec() credentials. That feels like something that could break
existing policies, so I think we need to keep them independent. I'll
rewrite the description and resend.
