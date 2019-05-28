Return-Path: <SRS0=TCdI=T4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9445FC04AB6
	for <linux-integrity@archiver.kernel.org>; Tue, 28 May 2019 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FCB208C3
	for <linux-integrity@archiver.kernel.org>; Tue, 28 May 2019 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbGZXWaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfE1Tbd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 28 May 2019 15:31:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43061 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfE1Tbc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:31:32 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so708533ios.10
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJWdqsvgsdydZu1KmbbIIIUPJdXFXs5FZt+p6hqE+r0=;
        b=hbGZXWaOkVi0DjOl59FO1Q2+BVcKBvKMDmS9blFm3uP27rBJKVnK/da9rN9UNJMLf0
         uac/3V3ye0sbdhbCN/bHy6CzpEijZXQzvH6Qp1bHyRPAmQo8eM9pAAn3Djw8fIHME2CW
         Xk1/myfne6i3kcnuFcvdMnVfYFDUX4ekApJ8Lu+XtcmLXt7XvjIAbuQmWqGtd2pmOiqJ
         gzMwFbFe6qfcLUSqjtnw54ETxZfPvox0xqrgoRhafiKWCVVegh3s3loPBqloC7bZ61FY
         jWD1y+Cmxv3kKBl/KVTvqPQJp/gEK/sws9pWfZsr5hnq8cCOsk64jnqYrpymiabhkgOK
         eHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJWdqsvgsdydZu1KmbbIIIUPJdXFXs5FZt+p6hqE+r0=;
        b=Vp8PvmKukcbzp98PnSbn+UU/wyAu+cLifSVfq3bqbWzuVMcvQigRvG7m6nhxK+oHgm
         cA0jckZcBfzWEzbS7nAtanq25oLbkdsYVykmk6TbZvM8gB0fzINpSezYHldWJiU9FRnV
         50jtV+owopDwlQM2tbOvP+P9I7Lbgegs5pEDBnHEsEYKA3Q6GA+7VPwetvep7D8FRulQ
         j63nYXcopKg/wfiq5vP7CQhsNl4XqL4kf1dAI3RRo/TphhIqnFRnCRfpBN+5FHmAI8bo
         6ti6UfJGKEtbKV8lDbVG/aTLDJOcD+4oSae6pGk8exFobLUYSnZTzD9JJ+22WVMvy89D
         mhqQ==
X-Gm-Message-State: APjAAAXOe+KE8pH58aUfvH+Blg2fwi76Oo1mDBbYDB5IBQELUgNX01CP
        jZLLjBLTaFQmrIiusOjBcJBanIJypI0IMi86Q6GiWg==
X-Google-Smtp-Source: APXvYqxfIOe2icz0MsM5vCWZf8ggas3xup0A98ROlGqGOoCPMpE1ZSmnrTlCo+QqM5Jw/1szRIcVBGLkvg1nV5ojqmg=
X-Received: by 2002:a6b:3b4b:: with SMTP id i72mr12263192ioa.169.1559071891701;
 Tue, 28 May 2019 12:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190523181827.207274-1-matthewgarrett@google.com> <25aa67c9-ac11-b6b3-7f94-142dd71d3df5@huawei.com>
In-Reply-To: <25aa67c9-ac11-b6b3-7f94-142dd71d3df5@huawei.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 28 May 2019 12:31:20 -0700
Message-ID: <CACdnJuvE6HC1Sd91YpzQkC=Cf=k6FhBTznn4qHxGJF=NhOp-5Q@mail.gmail.com>
Subject: Re: [PATCH V2] IMA: Allow profiles to define the desired IMA template
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 24, 2019 at 2:29 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 5/23/2019 8:18 PM, Matthew Garrett wrote:
> >               option: appraise_type:= [imasig]
> > +                     template:= name of an IMA template type (eg, d-ng)
>
> IMA template name or custom format (if specified in the kernel command
> line, see below).

ACK.

> > +             if (template_desc && entry->flags & IMA_TEMPLATE)
> > +                     *template_desc = entry->template;
> > +
>
> I would simply return the template, without checking the flags.

ACK.

> > +             case Opt_template:
> > +                     ima_log_string(ab, "template", args[0].from);
>
> Please add:
>
> if (entry->template)
>         return -EINVAL;

ACK.

>
> > +                     template_desc = lookup_template_desc(args[0].from);
>
> You assume that the template is already known, while users can specify
> in the policy a combination of template fields that is not in the list.

Yes, I'm not attempting to add support for dynamic template definition
in this patch.


> > @@ -36,6 +36,7 @@
> >   #define IMA_NEW_FILE                0x04000000
> >   #define EVM_IMMUTABLE_DIGSIG        0x08000000
> >   #define IMA_FAIL_UNVERIFIABLE_SIGS  0x10000000
> > +#define IMA_TEMPLATE         0x20000000
>
> I think it is not necessary to define a new flag here. It should be
> sufficient to check entry->template.

Ok.
