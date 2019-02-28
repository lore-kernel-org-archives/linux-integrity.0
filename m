Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B31C4360F
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 22:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A243B218D9
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 22:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6c4yxnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfB1WiV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:38:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39161 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfB1WiV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Feb 2019 17:38:21 -0500
Received: by mail-io1-f66.google.com with SMTP id x3so18001365ior.6
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 14:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8O7WqQc1DZnqHtkq8g/3QEBeDVizB2XDZnR8IskrEK0=;
        b=U6c4yxnJsTGS18fv8Uf9EMGZm/vDikEZdk8/3iwvvp+rv2Myg75ayR/DRIkEQM6ai6
         gqSVuSoHs/KQmEHjxdGbh+CF/MJKU2hqqTeKSzE3oMdrpHM86r+CktoKnu/I7R7Q9Q8H
         64OP9bKtdBBOqkpe3TFWu4aOBOF6bsj18WVU5wLEKA/QMqatgJgRX9vua040y8OROoeA
         1VwLFdjd8EubpvrszaTkdek7XvJ68d5QP04S0bJXibjiOa6x8YOa8bgC1ZlRBf3ZS1FW
         jy5EHYC8nHMl1I3ANxpfJQAjWpdkiUnnjNKxEfLFjW3v/FpKiCekz00vQy8df80Th5bI
         0pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8O7WqQc1DZnqHtkq8g/3QEBeDVizB2XDZnR8IskrEK0=;
        b=XG1BaH6Wfc04t+zhf7cO8aFa+3kqvytebcu0nSYHMb3xurVs3oMcdgY1CKNMZfldyg
         OJbGVzEGzPwRw/pAb6Owg7MgvWY8Rl/dZ1z7mok0dzOxVYRtpO2zBY/7C5aQTrU69qbH
         rikd0/r4wU95utkamZfawMINMV3spagooy+YkJmPvsvleLbdehA/2nf9N+wb7HrObcSD
         8Q5AOfQgmsBnoksTot/gjott7Sd8Uj9ITkdHwD6LC6jrrt1RWuUCvD8I3Pyc8oiMH+/p
         RN8nVUOCDb2JawIk9UJu/N4/CvcVD8tms2bSJJ140w/8Xw+D5gijwmzC+8ToK2XaiqE8
         cjrA==
X-Gm-Message-State: APjAAAWMnmjSdEt3df/t0ss5hW1gSUkypV09tJ/4Td28QIXZPdujgl3x
        S6RdDjEgvt/KhGktfVPGxmwYSKI+hkDGq1PQX94U5A==
X-Google-Smtp-Source: APXvYqz6QQTnzFIAzhWFfaa1nk5BJKtzMScG9WZX0f59i98VZtcKP1wIFIfRlE8XIjTH8/Pvmf8V42/RKr2n0X+00B8=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr1037727ioh.169.1551393500313;
 Thu, 28 Feb 2019 14:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com>
In-Reply-To: <1551391154.10911.210.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 14:38:09 -0800
Message-ID: <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 28, 2019 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2019-02-28 at 13:41 -0800, Matthew Garrett wrote:
> > If collect_type=get_hash and the filesystem doesn't support the
> > get_hash type, should the behaviour be to fall back to read?
>
> "get_hash" should be limited to a specific filesystem type and
> subtype.  Based on the filesystem type and subtype, couldn't a warning
> be emitted at policy load time.

The policy may be loaded before the filesystem is mounted, so even if
we added a capabilities mechanism we wouldn't be able to verify it.
There's also potentially cases where a filesystem could support hash
retrieval for some files but not others, and in that case we'd
probably want to fall back to reading the file.
