Return-Path: <SRS0=wDMX=SD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCEC43381
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88E20880
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkX95TEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfDASzB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:55:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44822 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfDASy4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Apr 2019 14:54:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so6178014vsd.11
        for <linux-integrity@vger.kernel.org>; Mon, 01 Apr 2019 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vThWi9g5/qJmdB4uS99oEI6x0u1DMV7y38c2bqYqBlY=;
        b=jkX95TEsaEzXy/QmyrssEXYhAVvQ7DMF+8pCwbBZOKrnLihi9zA+8wZSSLDp6px59B
         f3Z9GQPnIkNMJi4m8m6bLoc/LZ8STZbethSPuKYk4SYbxavQc8QBsBggPbubmBARnA9X
         yZS34AYj506J+NkPdzAiudLenVm0F7wl9Ki4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vThWi9g5/qJmdB4uS99oEI6x0u1DMV7y38c2bqYqBlY=;
        b=udfjL8r2xHPLV5K893DT4NfHGEVECcoW8EmKmLpGcMDQU3WD3V769Kmr+QoW86VI1+
         JKZU0XAxxODzVSpEFT4q1OAv0szjt9pQaMchnttR3cyjkqfuUT7xn7gJ+mf5NJmVJrnS
         s1Lu4hEnxCbytOY03hYcTY78D2Y3tmd/HXk8MjawjaA/BXG5RjSKSJHuIo7/vy95K9uW
         55qeSmZ487EQq/qH9WWen8NnRM2b5/GPEqOdZoIMk2tD+8yyfMJHu3+ijw8Udpwl7gRW
         VMHSBQWANzfarBAW8NsZ3rWfgsCCnl7Vc0iuwPOu6TESAzBAyyBevpbdnb6kHhiXHR6d
         DXiQ==
X-Gm-Message-State: APjAAAX3mE7I6/72BA4c4c4APgFxL/5lB4GR4puW8I8x+TE1TBK0mWcV
        H0AM0RIpqiZSl9rzB8dn+4zqTr0X71A=
X-Google-Smtp-Source: APXvYqwiUpCVmzTFmrNKfP8fytEKbyjUvitjgu+w6hjb7gBjWBl2D6x+IYFRGjYtF22/jULo9OSoZw==
X-Received: by 2002:a67:edc3:: with SMTP id e3mr18092858vsp.123.1554144895099;
        Mon, 01 Apr 2019 11:54:55 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id e81sm5678110vkd.56.2019.04.01.11.54.52
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:54:52 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id x84so1045358vkd.1
        for <linux-integrity@vger.kernel.org>; Mon, 01 Apr 2019 11:54:52 -0700 (PDT)
X-Received: by 2002:a1f:6bcb:: with SMTP id k72mr7359745vki.80.1554144891661;
 Mon, 01 Apr 2019 11:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190401183211.GA21228@beast> <1554144741.3029.18.camel@HansenPartnership.com>
In-Reply-To: <1554144741.3029.18.camel@HansenPartnership.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Apr 2019 11:54:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLuPTvcQbhEXKfh0fgWkA4g__kET=tbY8njraXXQYug+Q@mail.gmail.com>
Message-ID: <CAGXu5jLuPTvcQbhEXKfh0fgWkA4g__kET=tbY8njraXXQYug+Q@mail.gmail.com>
Subject: Re: [PATCH] tpm: Actually fail on TPM errors during "get random"
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 1, 2019 at 11:52 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2019-04-01 at 11:32 -0700, Kees Cook wrote:
> [...]
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
> >   *
> >   * Return:
> >   * *  number of bytes read
> > - * * -errno or a TPM return code otherwise
> > + * * -errno (positive TPM return codes are masked to -EIO)
> >   */
> >  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >  {
> > @@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8
> > *dest, size_t max)
> >
> >       rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
> > TPM_ORD_GET_RANDOM);
> >       if (rc)
> > -             return rc;
> > +             goto fail;
> >
> >       do {
> >               tpm_buf_append_u32(&buf, num_bytes);
> > @@ -559,7 +559,10 @@ int tpm1_get_random(struct tpm_chip *chip, u8
> > *dest, size_t max)
> >       rc = total ? (int)total : -EIO;
> >  out:
> >       tpm_buf_destroy(&buf);
> > -     return rc;
>
> You can't remove this otherwise the only return will ever be a failure.
>
> I think what you're trying to catch is tpm_transmit_cmd returning a
> positive failure, So you need to check the output of tpm_transmit_cmd
> as well and goto failure leaving the above return in place.

eek, yes. I double-checked this in tpm2, but tpm1 is different...

-- 
Kees Cook
