Return-Path: <SRS0=28DF=RX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42246C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113FB2175B
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zw73ro15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfCTRXR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:23:17 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:36003 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTRXR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Mar 2019 13:23:17 -0400
Received: by mail-it1-f180.google.com with SMTP id h9so48313itl.1
        for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2019 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/chIgrhghuZaiCql6Yx+6czPU6z+QR4IjhzFuUPCeI=;
        b=Zw73ro15RG+U63p71GvwWLJqaUplXJSVmp1vH7emAxv8PM5YpKjMSUNuZsF07EV04W
         zGg9QA3oLVb7VvfjqPo9Fqa5z+Mfq+2ASF639yQh2s9n5cf10v7DzHOZIPql5D5plBAh
         EcjNia4nKiC9QDu8/7eS13RCievG9Zy0BaZZV/WWHr1ug7aRId70bwPHviVZQjAvLnqc
         lneydXNjVkq166YegvA4lOoSXLz59xC2vC/xRBqlW2sKMPY2iQT4OVPKULytlpwJ3/ID
         NMxYQuBejImu0/hFzJXiy46U3pysp3Bbs5jnF69XljM8EZoOHjn7KAvZ1yHY69a3OAXk
         bPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/chIgrhghuZaiCql6Yx+6czPU6z+QR4IjhzFuUPCeI=;
        b=ovqsbKcoGtWJEV/QiUgM+WHsfMkn/tJhsRwVkXjTpyeNVeVXNjUgCAyl0a3F56B0pi
         wqH+wmUmaPEZwO0/m2lmyEYRwTZWkdWz8rhxlXtUJVLADxj93g07pmR3OmDUc/MP+swb
         ABpTs1LLqtqQiruEhBqeHiz8SPruozuzVR8zIJVV0qG+ed/sYhqtU5W73IPIBUaiqae7
         AnPpFVJAUdaSc9piDUYN+oG+ohaexibhHS863ayiKsRub7hThqWF0tSH8KdqbtAShKD/
         ig/QKGvoZLvLOHbdxjtcWpoIyJ8Bq3mtCQ1GdgCrNURLLZD80X2YMLzKdhASZ2bWde45
         sFZA==
X-Gm-Message-State: APjAAAWxy2vKyDFYERYZpV1ZBVow6qGupn4WL6VLBUd3OfOft7bLkcHF
        qDc7HunKDNhfIFVm2oDXND4JTcuq5yXtzsOpAI/KlA==
X-Google-Smtp-Source: APXvYqybbNe/pNLJJItyzbF6p/befx0mmnPcRG5eOLZKAO5mcev5p+vQM90FodhZUgZr3O9rYYvEBFY6aERTvwNb62I=
X-Received: by 2002:a24:7908:: with SMTP id z8mr6189967itc.16.1553102595744;
 Wed, 20 Mar 2019 10:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
In-Reply-To: <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 20 Mar 2019 10:23:04 -0700
Message-ID: <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 20, 2019 at 1:11 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:

> As for scripts interpreters like bash, yes, it will not protect against it.
> But IMA can check e.g. all files read by root including non-executable ones.

Non-JIT x86 emulators are basically just interpreters.

> My point was about better protecting of shared libraries making life harder
> for exploits that are downloading extra code from external servers.

Like you said, they can implement this by copying the code from
read-only pages to separate executable pages. It does make it harder,
but not to a huge degree - anything that's mprotect()ing file-backed
pages to PROT_EXEC later is presumably doing so to avoid IMA, and
making this change will just encourage them to add further
workarounds. Since this is a fight we literally can't win, what's the
benefit?
