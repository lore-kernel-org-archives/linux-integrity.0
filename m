Return-Path: <SRS0=YknM=NJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0772C0044C
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 17:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC077204FD
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ6AoN4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC077204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJ3CoV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:44:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35691 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeJ3CoV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Oct 2018 22:44:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id z2-v6so1824423pfe.2
        for <linux-integrity@vger.kernel.org>; Mon, 29 Oct 2018 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSRBAJc5LjP0q5OJVj+GJWLu8GLrm3rpsIZDICYf+sg=;
        b=DQ6AoN4mF54G/icj5lBMWGhZ4iWMO8x8DBlN3zsG31Pc1xz7P5mYixswVbf6xhV4/H
         WjElr0+2zmHrpMdPL7oBZJ742nNedfPz2hHISNtsg2Vm6X+L6EBM095DE9wkDJ1sL6Jq
         2IE5mU1XtzUurNJtaSy1QlwRprNYfM5XEoU52t56dKByc1+SvPddXo23s/IkIB5/sfGa
         sRZ8BWZFzV8URRKQ7XNzImTjgJd4Hfco5bnO5g93pNWs22zn/PqiYQVDmZ/sOTYVq0BA
         v/jOzivQlkAdo0XGSMbTyypNqCwVaotpGJI+ox8jxS5DtSCB8H24UxnbnOkipH/g/uJ0
         JEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSRBAJc5LjP0q5OJVj+GJWLu8GLrm3rpsIZDICYf+sg=;
        b=dKsEiSvYdc575tYaj/+TXyG5+WB4gjkf6olh5m5bQZC0uWVV5njjjsGNFZt5P0K8bX
         DEgMJzVMBDt9lrvRV5GxL83dPdkIjBEIO2BU54SETf2ACm6u7WZfqXqg4YMBhr9NeRyG
         eYIzFrxygC6RCbKBjfsZX5T3nbMDVos6MT4KD2crUtC1h+HoIQ/h3mvIAKFyouo9m5iB
         D+BQHR06Lf5mVaTCTGNjgfDn76YzIcVDQYifrshrL8ZrjBVQYPg2C5wGG1FZ5nLCeXlH
         c9QgZD+AkId9lJ6pkejb4R3eEWoX3cEuGOfQDAYQD/LcVnM5a/gR408yUhRq+S+a1r2o
         sP+w==
X-Gm-Message-State: AGRZ1gKHZgTEQp4OncHhC+RUuoG8vKkFAwDlOEbawr5jibTUrT+Fm4/0
        pnujyvYqWUDT4k7wN78ZlVig9I6nuqNSgJQjPgrxog==
X-Google-Smtp-Source: AJdET5ciTSlNdT5VcV0g+PyFSxZrRZ/Q6sx+8JJsqXE5PJQTH8uMDebizR9yNr3teLO58R+ZFmMVOuLyRoWNuyVdBXA=
X-Received: by 2002:a62:5bc4:: with SMTP id p187-v6mr13503819pfb.94.1540835680718;
 Mon, 29 Oct 2018 10:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com> <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Oct 2018 10:54:29 -0700
Message-ID: <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
To:     jarkko.sakkinen@linux.intel.com
Cc:     dhowells@redhat.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        David.Laight@aculab.com, denkenz@gmail.com,
        zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 24, 2018 at 1:37 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> > Fixes the warning reported by Clang:
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> >        va_start(argp, h3);
> >                       ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                               ^
> > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > standards explicitly call this out as undefined behavior:
> >
> > The parameter parmN is the identifier of the rightmost parameter in
> > the variable parameter list in the function definition (the one just
> > before the ...). If the parameter parmN is declared with ... or with a
> > type that is not compatible with the type that results after
> > application of the default argument promotions, the behavior is
> > undefined.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> > Suggested-by: David Laight <David.Laight@aculab.com>
> > Suggested-by: Denis Kenzior <denkenz@gmail.com>
> > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> /Jarkko

Bumping the maintainers if this isn't already picked up?

-- 
Thanks,
~Nick Desaulniers
