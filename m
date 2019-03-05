Return-Path: <SRS0=PR+Z=RI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF02BC43381
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 00:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5AB206DD
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 00:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+nlUa0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfCEA0K (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:26:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40285 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEA0J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Mar 2019 19:26:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id x187so5423764oia.7
        for <linux-integrity@vger.kernel.org>; Mon, 04 Mar 2019 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE6VQdg+8YYbuSTcnLW4igmT+bgWRCnZA8Pdl0h5EBM=;
        b=B+nlUa0gILUu395l1N6nbOY1Ns0PIOVLNvGHPoiKKIJ7pLDMDEpnamOg8waetDLran
         cT/64JNJFvWkLJwgBIi36MXmkqLhQsFEOBWxpL5lpDgGOB+7nTb0utkz8Cdq9NJiecay
         kBuJMdtAong5qAgjGcpTAMhZmygxWmivQxUbqzYE5HQdWDAPvZ9INZXsg8mE1k5bXUCu
         tIwAkiPDNEYzNtnjqjH318sta37s+jnC09qsgqhu5wW7yCpOwt5zR+01foWqY5Di0YAi
         cy/vtGRI/Hs0xJabDSDjrakYbe6esqGJr17xFNIvUtu4DP70NL0olz6xJhIeB0a8+HpM
         hu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE6VQdg+8YYbuSTcnLW4igmT+bgWRCnZA8Pdl0h5EBM=;
        b=OjLTQSFVjADlvYXguz956t6hqHUj91OGHhVLvxuxBaDPETgyNbCGkhypc7EAML+xER
         WK6KXPi6N3uX2c7vmKnd4ijLoZG9sjl/G46sg6uOo5VFUU9RrbWt1oJno8ziDRIRyIUw
         pMWzEufYIvND8FeJNwWHFr4tnvJNXQ75tIy1Ah/2afhRda5CXtkTu5SAX2ihPSXRapvy
         JlJUZEcT8S+nbWpKUfTAiiurUQ3BiWD59FMtX05cdqxYowZBAXqHfWSwLnhxDXaxAqXc
         2yxbpCvxSV786nEoF+//j8t2Yd/ujZmBqjHKuo/dyxcsNi/LEfnLhVen3FBS/PtFlwLb
         79MQ==
X-Gm-Message-State: AHQUAuYvTS+26i0vgJaIgxzCWY++8U1TR713ZTQDrljm72KT9XdEMfTr
        RqwojRXS/9/cB5/Pge5Am9pG86Ft5QKLaBiwrOtBaA==
X-Google-Smtp-Source: APXvYqzWQnmHO/Nl1M7vzOAJ8CzF9yn8lv7uYkuDV0Tpf8O8Gt6PL6cTdguwb6YuhqwRuOeWdsyPRQY7gGgMcRGjvY0=
X-Received: by 2002:aca:a847:: with SMTP id r68mr13838596oie.175.1551745568952;
 Mon, 04 Mar 2019 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20190301201010.19094-1-jannh@google.com>
In-Reply-To: <20190301201010.19094-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 Mar 2019 01:25:42 +0100
Message-ID: <CAG48ez0=-kVinYDSQ6NS2AxhL=5xHiunfBGXQnYZZmJ3F3fpPA@mail.gmail.com>
Subject: Re: [PATCH] integrity: use KERNEL_DS instead of get_ds()
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Jann Horn <jannh@google.com>
Cc:     linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 1, 2019 at 9:10 PM Jann Horn <jannh@google.com> wrote:
>
> get_ds() is a legacy name for KERNEL_DS; all architectures #define it to
> KERNEL_DS, and almost every user of set_fs() uses the name KERNEL_DS.
>
> Let the integrity subsystem also use KERNEL_DS so that we can get rid of
> get_ds() at some point.

Nevermind, Linus just did this across the tree in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=736706bee3298208343a76096370e4f6a5c55915
.
