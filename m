Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD19DC10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9881320663
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX+TXbM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIH7G (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:59:06 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:41084 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDIH7G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 03:59:06 -0400
Received: by mail-lj1-f175.google.com with SMTP id k8so13570973lja.8
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2019 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g306jD0jgreUhK9VmxPNHzHQFdID0TxHWNL/6uQvNFs=;
        b=FX+TXbM3IbJ7ZNWcXHdx9dGZuE7zJXhLpPsyFy2jBVfDDx/S8vXka72+a0d4S7vz+B
         YYoqh9d0ie3aCFXEubeQ4WpBvnf01macuKlJlU2LvO+iC0TuctmBqMT0Fl6x+kpcYGe3
         WAcrs5As3FHShTMsLPNdiLfA+B/Dpf2+6jbznYytamyO+kqHbIx0JBx4FO4JVODAiVZn
         SoIgbOLuwNF95hk6jL75dRkdb5dyjhas7vB95dPjsole+H5tPdvJCWzgA4a/nI8Cy8KP
         rEfywyslN2HAD76DLjBdAZEOFtLcYysvM3bMSz8BM+m/pX0o1lG0W5SXRBwETqJFrvwp
         hSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g306jD0jgreUhK9VmxPNHzHQFdID0TxHWNL/6uQvNFs=;
        b=ZivcY9JoNQ3MAH5cAkXUa6kDmXBDxePLgATlebjOG3H/S15Tc3phjSXwcC/nXHywu6
         xqvWUsDZp1oVNADFAHe3JOct8SCrPPBMbOqn/IrnE+oBpFxRAEsef+yBhlDgLlbCCMEi
         ZfXlA4ex3VuW9XdOrO94jXbmcBadaMLQforwqQHbGuvfeQzr/v55pKRNMPYqTT9HLd4f
         q8MVKMH68FV4fu7FxmH5Wk/cyHL0AExBf9+qxtrqwiD14Hq30AFf9EI01F22ioAaL3cb
         56N38g5sm4DcCiO8uzAMyXegOYY7s75XeiXFo3ohrKA+8tXXNWC7BV+zYMNNVtP9+SQ1
         GYGA==
X-Gm-Message-State: APjAAAUG5Z1Vm9jI7ibi1OaVkpgdyw5db8JNisM+vXAK7t6vdRqkqIUf
        W1NAo+PFKXBekO7bj4ZMGrXP4o6f8xSb62hnvjkNfA==
X-Google-Smtp-Source: APXvYqwctgaIWR5FqUmzSQ1ng46ma6uhg/FAOK2Py0NGH1yg6iIhjRrSTjauuwJp/jdrHBAGcniOhAbMYxG6KWIu/68=
X-Received: by 2002:a2e:8719:: with SMTP id m25mr18605899lji.50.1554796744051;
 Tue, 09 Apr 2019 00:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
 <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com> <1554729047.17244.95.camel@linux.ibm.com>
In-Reply-To: <1554729047.17244.95.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 9 Apr 2019 10:58:52 +0300
Message-ID: <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 8, 2019 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> The question of how much/how little to measure/appraise/audit is based
> on policy and affects the integrity of the system and its performance.
>  Detecting and updating the file hash each time the file changes would
> have major performance repercussions.  Even that wouldn't solve the
> problem, as the file change is in cache.  Writing the file hash as an
> xattr and making the file change persistent needs to be coordinated,
> probably at the filesystem level.

As an experiment, I will add 'ima_file_update' function and call it
from few strategic spots (such as vfs write) and see how far that can
go removing the crash-recovery band-aid.

If the hash is in sync with the latest write, there is at least some
hope of recovery since the emergency sync on crash should flush this
data along the rest of it (I think). If this works, at least it will
give an option to use ima relatively safely given that you are aware
of it.


--
Janne
