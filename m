Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A5C43444
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADDB208E3
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEvwKMeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfAJSUn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:20:43 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:53427 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfAJSUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 13:20:43 -0500
Received: by mail-it1-f176.google.com with SMTP id g85so12024ita.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jan 2019 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLBFbzNc/cg17AQaAXx/9GyEjtfOkogJU6dZqtLyhWA=;
        b=gEvwKMeKUvjEDtyjHszXXA5dCcvjfhPVQp+5BTsum4XEUlC4/K0NSv2vVbpBSj23jZ
         qJZyaoq8ECBVM4HmrCxldv1oXV27NqqOVl5BMb62nYY8bB9OK8WkXmhsQq4gkW6ndOzD
         aIhn0jdrDD7+6a1fM9LKp6YhhZjyjM/yorZxLbdxpqGWTgHOm8jXvR8uTxDeQ/od36GY
         E0NvezJkQrKqK+ZYAnBAzNmCYr1zlJ8fFdEiW0dw2s7VhVnVj5AJcmJjPVWx1xDDzGXL
         un2M/EgjXwiuZzmMcL5tlso000+aPdXstS8P+VYKzqBaMGIxSeG+Q+vXNiMXjKeJt6HL
         F8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLBFbzNc/cg17AQaAXx/9GyEjtfOkogJU6dZqtLyhWA=;
        b=spsrbmYGbM/EZbypTo2MGLbCmq3IwhVEfFAX8Cz3dKev6A/eHmrKuSOtNg2iPOOstU
         GBP8+cEIhL9QPtkfE/U8VNBwze5dTQGCo5S8ZsvUqfduRnK2H+q8U7Us4bDcTWLTE0iF
         hhDUyRWfJqUdELoqOtLEu7lC7SzXyExXurlDxs1cvlPugaqhPVLP8JM7SUo71sisb3zd
         MRx+vPNHQqvm6/IrujGLDtsu78eSQUBA2DyzO3umacLPRTRP41MbUZewZ5uAxt8H+3Yc
         EpggkGhDgsmOhYKhmYHUFmcNpHDvLw3Kv3EBg1vzQksl+7AoAUqMf/N3t2oWX6lMfUtm
         FvVw==
X-Gm-Message-State: AJcUukeNaqs77sI24xBAU4TFfw5slcurXQiFvdL7t/yubqmOe1kp75kG
        6rrGFUKwG84Nlpqnz65kPTIx+oaEvNyk5O6Cbzwqrg==
X-Google-Smtp-Source: ALg8bN7KRn6jkTUv5kvUsZpttDqwzHJaJYTcEAD0s26Dgm3bDvHiWs8smYTPH6ih3Jbt5Xt2rqOedQeqYhQS8pb128g=
X-Received: by 2002:a24:2b81:: with SMTP id h123mr17397ita.16.1547144441481;
 Thu, 10 Jan 2019 10:20:41 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
 <1546981121.19931.130.camel@linux.ibm.com> <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
In-Reply-To: <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 10 Jan 2019 10:20:29 -0800
Message-ID: <CACdnJusByW8ybecgaMRHooi_vhJkuUzmf3MeEsQmNP38TiZkdA@mail.gmail.com>
Subject: Re: OTA does not work with IMA due to xattr not supported by zip
To:     rishi gupta <gupt21@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 9, 2019 at 10:47 PM rishi gupta <gupt21@gmail.com> wrote:
>
> Thanks Mimi. Any plan for zip archive format support.
> Also when using EVM, the files has to be signed on target. So after
> new files has been flashed on device during OTA, does private key also
> needs to be present on system.

This is what the portable EVM format is for - it allows EVM signatures
to be generated remotely and shipped as part of a package.
