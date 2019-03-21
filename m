Return-Path: <SRS0=2aJh=RY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7BAC43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF895218A2
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 18:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsuO6RjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCUSEU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:04:20 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:38930 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCUSET (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Mar 2019 14:04:19 -0400
Received: by mail-it1-f181.google.com with SMTP id 139so5500949ita.4
        for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2019 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/A6vP4t6zfVrY/1RiXNGB+6/8R/hFMF0nNOxFjC3xzQ=;
        b=QsuO6RjBw0D8T4oSwdZ9ZHplbVjafiewHYky1VtP+kk4+ItVAa5BzvpsGaqq5n8vW8
         tDjcVyt3zaG6YWYHwOUxlODMZ4dqQP7lq0OD9NjeHijnttYzEJt9OkPGP4NSFvv+YhlF
         V0mzbu4M0cU85Ulfwa6UAJZjQMnHIo4RGKE77CXIgI7iJpVAuTraJinEQDD7zpcmeUjj
         Qi5ZEuRU8chg8/Z52I2eI94KXuID5XOY4mM22N+SH8rQAS6cWLM51mHEngu848wj+x5Y
         xmPREFx8YomwRjyzL205B2tv9YocZbktsaWSGqM7kXpO4EIN0f4DkSRl0ZWz9PWK6Tkp
         TMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/A6vP4t6zfVrY/1RiXNGB+6/8R/hFMF0nNOxFjC3xzQ=;
        b=adHyt9Z0awynvef9MWli6tspCFgFwbCbpk0tmLYSPWOpMRD0ohXmyx9+ppQfdSpYZm
         tiQNAZlvSL5cqBH7pz0Q6VuTSeGFstwggb5vKTDGB84YE488WKbiqlBwsiFlfc6W367H
         6K4wrNy9GBA/ZkZafQ9ExhdH8CZC7YqbUmsU6TU5NwMG3BI7e8pOv1qHj7vwZbNKXnRP
         cE10q5VZOlrGIPsMWLOBuZf5oDLIy1h69WE88tWIMk8qXCueyzm2xrcmzAWT+8S4r8LY
         6aReOw8AxUEh17TrKseRr5F+1/qyUtpDV+rQx/E6f17fveK3x4L/ftCMDI5JiiR64vdj
         adfg==
X-Gm-Message-State: APjAAAXIqqgFjSR/rN2AM9Dot5R9TU8SXtqVyUdFs0sJF/0Yzut/AIpb
        i9LyxCJsilGhjjuhVSQKAPZ9MvbLyW7iqHvm5LtM2A==
X-Google-Smtp-Source: APXvYqwBdJEPidPpJVaKlx0GfRPBUyIYOAOpXp7iUlmcLuRo2pOqb9FAO+vD/2wtZNKokT+VVAWv83+40Zoe1sXM9p8=
X-Received: by 2002:a02:9045:: with SMTP id y5mr3743779jaf.102.1553191458799;
 Thu, 21 Mar 2019 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com> <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
In-Reply-To: <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 21 Mar 2019 11:04:07 -0700
Message-ID: <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 21, 2019 at 4:48 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> Along with disabling creating anonymous executable pages at all since
> is is hardly needed for the system services for normal work.

Is this true? Do no JIT compilers behave this way?
