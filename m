Return-Path: <SRS0=3Dhz=SE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC7C4360F
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A465420700
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WptWuTid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfDBWb3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:31:29 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:41191 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBWb3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Apr 2019 18:31:29 -0400
Received: by mail-io1-f44.google.com with SMTP id v10so12374029iom.8
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2019 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DmDhALOp4W4hwgMy0RgzNEv3ZYxzD6tzqj/wRI+ePI=;
        b=WptWuTidQoehNyUyEWUTooygxBInCY50i7Wkl2i6+zubfv64+beXTmeRDqKSja1LAS
         fHu1hv0haNYyJJxc7EUh21efnO/fDE92p/+II0KDP4+R4Q3ugK0jxm5n5OxRqTYkITZg
         tcyksHLKVkfCccnvKw6yj2wyuNNduiu3SkhsohrQP+WXZxAQ56OiLgIobUt6WBdWItK2
         2JbKNY+gi7Xacu2rk4FlNyfKWDxQry+hLo6ojT86Kk5KpgcCB22s9WP3F9TdDVSXuYbS
         sG1iqw8qiqJFsQgORlTchFPGLzVDyTCGECNZGOviGxWaj7cdp/a/1/6YzLzdiq/7w/J0
         bN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DmDhALOp4W4hwgMy0RgzNEv3ZYxzD6tzqj/wRI+ePI=;
        b=cs2T5ft3FZenU6kygTfnCZWmKU6MEHx9jshllz2eH+DSDY/hkuXPXTSVMQ88LkXdMo
         SEyoLOTlFRc9lj9aTwrHZEwJw9ZxqIIdJnPFGWt7YJ75Xe6IGznEqVekMpuGsiBsPdYu
         GNzRTxVput9+fpnOM7f5OlbNppOX45CwpVxwY24kJrKsNXyyIYmONrMVaTt4YRiZ5Uoh
         exyaVgRLAqqzO8EJM6JSU/8dymeCkf3nvmafDZBIAqOWV0qxOw+xsazNvchEloKPoqfX
         SDCvyHDqUUAdNbj21C58bl9u1EtR+atwCFimBFroifMrLbuhh49Oz8lwn0rEa9pUhxeP
         U5Ug==
X-Gm-Message-State: APjAAAXD1ufXtEXYrfAWFafqV3yiwVLoYePjKV0B3RT4+/RAh8GyFcWa
        IWiGoa+1WbvmKZ12jMZH1tMNet/29eXQVa4c3YjpiA==
X-Google-Smtp-Source: APXvYqxwQLhI9x050g8UFS0xNTi5uv3jGERYobgO2O6EG+UkWQ90h8DwGJJR0Lhn6w66UVy+R8wRgUwM8O+8+lWCQcU=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr5876000ioa.147.1554244288310;
 Tue, 02 Apr 2019 15:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com> <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru> <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru> <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov> <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
In-Reply-To: <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 2 Apr 2019 15:31:16 -0700
Message-ID: <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 29, 2019 at 5:50 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> I want to be sure that no unsigned code page could be executed. So exploits
> could only be of ROP kind and not being able to download any extra code
> from their servers. That's why I found that disabling of anonymous executable
> pages could be useful for that (as well as disabling of making executable
> pages writable to modify already mapped code). In conjunction with IMA it
> should guarantee that no untrusted code could be executed.

Remember that many interpreted languages allow execution of code
provided to them on the command line (eg, python -c) and also grant
access to arbitrary syscalls, so there's still no guarantee that
you're only executing trusted code.
