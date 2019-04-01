Return-Path: <SRS0=wDMX=SD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43828C43381
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067A32084B
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 19:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MUcury/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDATOb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:14:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33482 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfDATOb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Apr 2019 15:14:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id l5so3687122ywa.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Apr 2019 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7X0bSvolJDJPpVoArTx/EkG3ciEuleLeYJKoAOM3vs=;
        b=MUcury/ZCmfLMJh1eYktYvrs/5QcYN044HhtaQXALVopSNd+/Zviezfcm7pu4n+YN2
         L3GnmvPzRqLYdcCCFBbMvOWSbR4XW85owZaFYUvSwRHU/OU8Z2q+OiYmqx75acuMpGnz
         P0QTlbdCWbAe0WXGrTLJlqNXf/QoT0m8XjSf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7X0bSvolJDJPpVoArTx/EkG3ciEuleLeYJKoAOM3vs=;
        b=YBHd4MoaGH89vTN0ur7t35XtceK8qW03/UqvVn1FCWeODAMm70Ublr4BE9+GwG1bp2
         5b49m+CdWMzV1nTzOD8rPP3Tgmdek1c8GUHUp5mwXm4ZJqz12T6N06XRnsv0bL25+SfS
         jQcYJE3G3tadt5dp9nUpInmQcp75TLDP4zsPioz0btX81rntXCaO/42bdICTrXyavoOF
         175BVnGCXh1PMpdFbcEnNSzUAqry8OY5kAeB/JSOdWMEkpnok4e75glDthm6NEoYeCxE
         mMqLf2bvZpz1Ab1AX2pdjHNOSSxExX4fVSdfO6+YW1AFCPqHftM2FvqEniWZxbW9WHO+
         mexA==
X-Gm-Message-State: APjAAAX/QQtVDEhpux4CEpBjXJBhg7fD2wXtmxq0tt7Dd6VCxSq8HA7W
        HxKcrCJFmu/oXM2y+tpTGPkWXhP76ko=
X-Google-Smtp-Source: APXvYqzRbDs8JKCFCHbABwHbjVj7I9Upyy6iK6M8xtGLDEJR0yLi7d+ESJhPt1rcdY2pXQ1uPApZIA==
X-Received: by 2002:a81:5743:: with SMTP id l64mr45110594ywb.457.1554146069104;
        Mon, 01 Apr 2019 12:14:29 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id k125sm6158127ywb.26.2019.04.01.12.14.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 12:14:27 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id l5so3687057ywa.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Apr 2019 12:14:27 -0700 (PDT)
X-Received: by 2002:a81:4c13:: with SMTP id z19mr55177133ywa.57.1554146067104;
 Mon, 01 Apr 2019 12:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190401190607.GA23795@beast> <20190401190955.GJ6209@ziepe.ca>
In-Reply-To: <20190401190955.GJ6209@ziepe.ca>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Apr 2019 12:14:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKGwH2m1-z9mXeUJh-4GOFw4igPgEv7Z_K5oP4cr0wbYA@mail.gmail.com>
Message-ID: <CAGXu5jKGwH2m1-z9mXeUJh-4GOFw4igPgEv7Z_K5oP4cr0wbYA@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 1, 2019 at 12:09 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > + *   -errno otherwise ((positive TPM return codes are masked to -EIO)
>
> Extra bracket, but otherwise looks fine to me

Thanks! (And I guess it's time for lunch so I can take a break and
learn how to type again...)

-- 
Kees Cook
