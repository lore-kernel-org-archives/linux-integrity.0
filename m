Return-Path: <SRS0=VzeC=SZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F091C10F03
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Apr 2019 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8A214AE
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Apr 2019 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jx6BGgkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWSAD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:00:03 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:36483 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWSAD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Apr 2019 14:00:03 -0400
Received: by mail-it1-f171.google.com with SMTP id y10so1696790itc.1
        for <linux-integrity@vger.kernel.org>; Tue, 23 Apr 2019 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ir5zAlJOThdiM80QszhFRhq6A6JO767qSeIlElonU8=;
        b=Jx6BGgkp8LbEXOuBVXAMNvYGbeR/WEXbNqpWuWwtxYIGcsUqCl54qXrdDQqjz3UvyD
         CEnAp8iXuubOBLWk9Lcsz+t4Zl/fsuoM03q8OX8jtaHD9vJBeWvywsEHUO+zLwj/eh2e
         GM/e/73zKRMli6njW/tBI1J7R5f5o4ClSrZ0sQkNAm14/gvswc5j1wczns9SjFLYDgLd
         W2nJ46D/Gp1kbc37acC3C0C6nHP62KjMD52QriFVJGp6u7bnAmEcFxU83qWDBMKG7Er0
         z46aAtI6W11FeDfkB/e0VCbXW6kdUk2rVPtn+wyjeuyVP08DEMvGSKnsaQix8lSdgVC+
         mlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ir5zAlJOThdiM80QszhFRhq6A6JO767qSeIlElonU8=;
        b=QMXEg3o+qBt/p94/MmpROkLNC4Z240BjgEWZvegp6KILbmKo4xPtnoR1ApURrsGm8+
         ziBHSaucQ06uz6JeY+6S6Dbd2G0JFfZjDwiIL3u/G6wWAMzV3H6zRgnpX0D5TO2FuJbx
         HkLeujxCbFcenDuXiQyZhgHGFKSgUyK66RmZyn2vNAOJ/e4MHzfxrxu/4sYfGjpIhKcs
         j+wYmYXb9KKVbE1hn6LvUguLaxjdICKD0H1P7tpIwmWHcsDYFLZy3Z4pQCE+VehYS2Kn
         rC3i+ipf5dGFLcLRyguNU3sJZmDNkXpyxdlF0PPKFYWJeN+ygPH+Ky02BVFdytsqcg5q
         ckoQ==
X-Gm-Message-State: APjAAAU6MdshRMW/hFXQSSMS86hpkLqYBQ+uuNiitBAVUvsC/2UWjm3I
        YMbFo75vKs9DyYs4KkE4LEYtzE4gXd6lIFt7EN98FQeEjUc=
X-Google-Smtp-Source: APXvYqx2noFUXjvpsOYDNFXNw0oPuZrNNEhIWyGVtJ+dBG4sMi735Ieb5rxDVU7XBv7qDiNMySTtjeK705QyUxsR860=
X-Received: by 2002:a24:41a9:: with SMTP id b41mr3382727itd.16.1556042401899;
 Tue, 23 Apr 2019 11:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
In-Reply-To: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 23 Apr 2019 10:59:50 -0700
Message-ID: <CACdnJutoJGm8mJJvgXZqpD7sa+OUxYqHHVyJEeGMu2WrubddZQ@mail.gmail.com>
Subject: Re: Can we enforce "IMA Policy" based on file type
To:     Kavitha Sivagnanam <kavi@juniper.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 19, 2019 at 5:08 PM Kavitha Sivagnanam <kavi@juniper.net> wrote:
>
> Hi
>
> I am wondering, in the current implementation of IMA policy, if there is a way to enforce appraisal on a file based on the file type.  The file type that I am interested in enforcing the policy is for SquashFS files.

Not directly - the kernel has no idea of what type a file has. If you
use selinux or smack then you can label squashfs files with a specific
type and then use the obj_role option in your policy. You'd also need
policy that prevents anyone else from modifying these, so depending on
what your threat model is this may not work out.
