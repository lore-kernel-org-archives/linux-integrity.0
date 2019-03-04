Return-Path: <SRS0=kjGR=RH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13547C43381
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D056020823
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 19:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWznco1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCDTwe (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:52:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35735 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTwe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Mar 2019 14:52:34 -0500
Received: by mail-it1-f193.google.com with SMTP id 188so688486itb.0
        for <linux-integrity@vger.kernel.org>; Mon, 04 Mar 2019 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRTZuRxyUgNjF0HjeCnbizljMfwLDQZWApGcGjmXMJw=;
        b=rWznco1tJ6C//UtLtqinphJW9J11I4enzPlBxPdmgVaVfhvnmoHhDIsH3ooFtob57h
         0urMlsNQh9w6rQz97HPtzUbQvoN7sqTlnk0k09+X7MdAfKvz85B5Rv8P0zq4vjXFfBU8
         l5ZlLnm6N03cFYjHBEus6+Hh6afFCPhrR4wKJxIaWS+2lxUK0OOJFFka/cDDxlQwKJpn
         fmL1oaSjfYGcvDEuuqkLO7TLW7+WM1DgYUi9KtZ9mU8V8D5sCPEjI4Kp/zZWW2ZUOyNg
         qcfcZQ6wDElsVjFHstFeFM2DurTbXFNvsr+TYOIuVYwAP6uzSew1FAWbsYy5OrgD5wwL
         ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRTZuRxyUgNjF0HjeCnbizljMfwLDQZWApGcGjmXMJw=;
        b=Ih99KjnWgEFOnD/coVQExF3g8DKVyp8ckKaQl2dEkiIU5FNpF7uwYaMePkfET6oLci
         YeeHf6NzJpEmojeMT6yi5wzsW9Z6QQjGIm6ZMAGzPFWKfntyI4+IRVGkTMQw+wt29LL8
         vKaPjfg2jTJzpcroFxftTlRG+GzGnKWhcsNokWUZ9rZWgUfTxbTDr5nCWIVj6gvxGU7w
         1fVl2c/EPB4mQp7RfCo6xamnYEp+M39kbSEFylE4SeMSKfOfu4LevM9DkcacRQ+DcDki
         9Xlz3brk5R8Kl/wm9Z7FKSyUW8jpgtO18HAkpSS9BTFZgi8uNAkcijudjTdXNbu1c9kf
         PWWQ==
X-Gm-Message-State: APjAAAXZpj8Wd3VBTukevkG0p7wq9nfqmCZz5Jf4hBbMzI/HcBPYVURu
        +WhYqPEDmy6HaZvLDFf7WjcO0adHMJvYYZB5eCzK1zA+U4c=
X-Google-Smtp-Source: APXvYqx4Fr0NzmmKPOHAoJm2fOyfvDmI8uqdgjxOjcafzHA8ICOhyQf7HAsJXcHKofEQxluPKNy3cTGqZziMVWCB+T0=
X-Received: by 2002:a02:23cd:: with SMTP id u196mr10499515jau.103.1551729152986;
 Mon, 04 Mar 2019 11:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
In-Reply-To: <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 4 Mar 2019 11:52:22 -0800
Message-ID: <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 28, 2019 at 2:38 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Feb 28, 2019 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2019-02-28 at 13:41 -0800, Matthew Garrett wrote:
> > > If collect_type=get_hash and the filesystem doesn't support the
> > > get_hash type, should the behaviour be to fall back to read?
> >
> > "get_hash" should be limited to a specific filesystem type and
> > subtype.  Based on the filesystem type and subtype, couldn't a warning
> > be emitted at policy load time.
>
> The policy may be loaded before the filesystem is mounted, so even if
> we added a capabilities mechanism we wouldn't be able to verify it.
> There's also potentially cases where a filesystem could support hash
> retrieval for some files but not others, and in that case we'd
> probably want to fall back to reading the file.

To be clear, I'm entirely happy to make this change - I'd just like to
ensure that I do it the right way!
