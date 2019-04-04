Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE076C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC36206DF
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyR91XKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDDRYe (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:24:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42003 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDRYe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 13:24:34 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so2659435ioh.9
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkdUEkcxFkzk6/8LedbuZeBMeRGDZcjzLzb6vhWuFOE=;
        b=dyR91XKloyyp+E859Ey8oSsuOa0peX78frffGQaDEBpqPLgjGPCUZkwof2Inry+5fk
         6EIa0s7GuXpgNwp1ORheRePXR0WrAp2zkiOk80sAplV3ToyNV/5Tob8UI6qtFylPR62u
         bb6L6D8/ifc29N9T3XPlVtogOzBmbOlzoCwtnu0/WdwbkJSygax5RACm+L7n1hudLz6B
         3/9avlC+aZS5c09xexGUuXb4c3pjN4n1LEda6KKhM4DrW7MftH+u44Hd2t4hUJeCUfnL
         OpOChi3xSgbU9BDXe9PCDNYrrZc7LH/gEecV5w9QNZ83VC0pwa8YZkrx1v1W1D5o5TND
         DWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkdUEkcxFkzk6/8LedbuZeBMeRGDZcjzLzb6vhWuFOE=;
        b=Y+2uiKsvFVY8XvFjIhrv2tLxQMXXbd3//2pqxQ8nWq/bjNZnZlTMSA7L7uzSOCjlJL
         X52cPjJOat/Sm5gShwZLbBtfEU9++PCZaoUs2PMfDHvMCOy2r6VNh1reRzC2WrhKRzoq
         Mvb3h3SR1GbQFYG/C65S2G/1rtN8de/W5UHJ7OEJenH78oGGuRevY0kzRAuTKSMMsAdg
         P8BpEMsUPpU8sUh/4qlfbuI1kS4xyXM7gZwD9XQcF9o9n8GyOjTBbgZcoGAgWNWKWrT+
         8/O8gBcC2EZiXi1Q2c+g6Q3q0ZZ3ihPzEKON9yZy4/cNY2jNTdvH5DaTvOkObFyX9fyc
         AtjQ==
X-Gm-Message-State: APjAAAX4ZoMRUlKP8RFzF1xA++WIDJ0zl9FmlQduHzVCpc3LmcmypVAx
        c0VNjgRaigtzg+OqRUAomZxNtUGnNL1FnRhMLpH/Qg==
X-Google-Smtp-Source: APXvYqztxdGonMa4pstJ/7vRubkc7YZsFytjtWtE0y/NyV5nZ2xpD80rsAtV3lZX5D4GvPVD7zAGkqrNa7i8yFftSj8=
X-Received: by 2002:a6b:691a:: with SMTP id e26mr4984716ioc.124.1554398672881;
 Thu, 04 Apr 2019 10:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com> <20190404124057.GC14738@linux.intel.com>
In-Reply-To: <20190404124057.GC14738@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 10:24:21 -0700
Message-ID: <CACdnJusEua0nyF2xhSVbFKnUxNVPT01e65yJs8cROMMO-nT6QQ@mail.gmail.com>
Subject: Re: [PATCH] TCG2 log support build fixes for non-x86_64
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 4, 2019 at 5:41 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Apr 02, 2019 at 02:55:54PM -0700, Matthew Garrett wrote:
> > Couple of patches to fix ktest reported issues with the crypto-agile log
> > format support.
>
> I guess I squash these to your earlier commits?

Works for me.
