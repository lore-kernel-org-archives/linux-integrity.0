Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B10C64E7B
	for <linux-integrity@archiver.kernel.org>; Mon, 30 Nov 2020 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B492076E
	for <linux-integrity@archiver.kernel.org>; Mon, 30 Nov 2020 22:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="FjoZwlqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbgK3WvH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgK3WvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 17:51:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF8C0613D3
        for <linux-integrity@vger.kernel.org>; Mon, 30 Nov 2020 14:50:21 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o24so20718094ljj.6
        for <linux-integrity@vger.kernel.org>; Mon, 30 Nov 2020 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bDJzC+7/EeDz8Z4TYtcl8pVmXB1VZfQyZ+oFPIZuXs=;
        b=FjoZwlqRl25v3f0bwesiLG6VMDJ0cdT+WZsk9oJG7qotZdfQy3Bnzm/ErkRC6KEF0Q
         V8tXzsGFOERVPlB9fDDUrXunF4OR96Byp7o91ITmQ4f6ghX4OplZA9VRfMBWotgDeDXS
         4fMHVDZZFkLBQZtMZ9inRIOYwvw2PRu8hX+wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bDJzC+7/EeDz8Z4TYtcl8pVmXB1VZfQyZ+oFPIZuXs=;
        b=NHgMEUhnI/+9ACfYGJZ65YjuQHajwcxUmDm3eB+n2R9KBvZk6HTkLiTjljOJvy5u75
         U7ceWVlo2BeGv0DRRo8zY+h5KHkrSpNDXmsyU0ET7lowc/mwIlBtk2W+fJqcz8iMcghP
         10pVja5ahd77PbVHru0aoKJAyAyrz0EGFl2bAVZpvBoB7S1QB6iaBsL4fkyq309DL4l7
         PPq5QMqeUIS480AcWuLnp+VjWW47KGnyc231j6ospl62xAZpgkshidb5MmLRaZbeM7yj
         iNcaPibtCXaoEgPrwK5kkLM5Qi2YZXx865G3guCBGb+8iDzSevuI+YMjx/qXbxb9sDT7
         7Fvw==
X-Gm-Message-State: AOAM532NaecP0ApEPVfnUcXuqnOpyUpZyiXBY+RjJw0GwGTaFxuZu+SD
        VgWDtjvtTZXfunV2uyXPNCZXQGD8o16pp0AACvELQg==
X-Google-Smtp-Source: ABdhPJyMsQBDmsS07l72ppmPq7n5DMn6hdGTx4GyLQK7ar2TSxkO0y0Q1aohyJmtrB+4dMWzWOlvHMr1zq5pbE7LHlg=
X-Received: by 2002:a2e:b386:: with SMTP id f6mr10646917lje.320.1606776619482;
 Mon, 30 Nov 2020 14:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com> <20201128213527.2669807-33-christian.brauner@ubuntu.com>
In-Reply-To: <20201128213527.2669807-33-christian.brauner@ubuntu.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Mon, 30 Nov 2020 17:50:08 -0500
Message-ID: <CAHap4zu3wjCqjbxaXbsPqz2Q_oNRm0Q=xQMudPStwN8h92Stcw@mail.gmail.com>
Subject: Re: [PATCH v3 32/38] fat: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        fstests@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> mount2 --idmap both:1000:1001:1
>

Nit: missing arguments to mount2.
