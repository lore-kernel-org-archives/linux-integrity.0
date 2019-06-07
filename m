Return-Path: <SRS0=eDk/=UG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3672C28CC3
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Jun 2019 05:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B91420825
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Jun 2019 05:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SP39a6dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFGFTS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:19:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40008 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFGFTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 01:19:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so606930lff.7
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcgoiMaasR9GYRsYKIbgillYLme+avvxyb1D2UipF2A=;
        b=SP39a6dKhm2JhOqt3S0Fm0qRBQu9iyXJKug3k/afiQrepK7Q2eS1h0zRSVggRpCuuR
         g9Waph99295vdX3PMAjEGsSeAs1TBn/4CX99WfxKIuzqjFADrB9+b6f8DcX/DP+HcPFt
         kILQsby0yTn/aQE3U0yncwScOJUmJKIBNnUBDm3GO+rAjm2bKQcCCz86gS1h+9zE7Jy5
         Kqt8eQ21CZWLEDCqZKd8vdPHSNJ++duTcJr+GNaDNvj339S7HBzy6A2s3IiFd2ozg6nI
         4kYz/ztUrgXhV7m5UnC5fsEVRsDs0j6wS5CG5WeT6dwdNNevjmQo1do8nK1KjAXT4hs3
         qzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcgoiMaasR9GYRsYKIbgillYLme+avvxyb1D2UipF2A=;
        b=iRMR1omdEHoflEEODWIc8eUW5n1511eK0N0QcrvJjAMTf2EH63uVrjEw2l+Sf/y8wy
         2KGOvFpC5zYbapgin4saEQOHNXqMNxl92P86Mxuc5XZcZIAmvJRu+d0N8WL+qd+Ip9aO
         SvlrGQe7EfXWIMoEVvRQAEy/bZhxTiCj1eZ5ci0sOTlalOHkAH7PkLvK7q1STxTMs74O
         e9Jtf5ffN0FRg9M2gJ9MHOpgty7/ufCFCmh4amfPj4OFzLPMF39yYF32upWQXXso/6hc
         Z6D5XH9P4pfdSIZua7Mg3hoXXOEsoBn5NJpDbgDb8pUabVjQFqVL6YICxCI+bmrm+MMx
         sEhg==
X-Gm-Message-State: APjAAAVkQstehd1nDk7MkUXO0FGkUSqWT4R8usrRg3FQhBYV2mwp8NEi
        tiQTehcM1Hnh6B0WLGtrTceSS6LMiDa7tBS2wtfo
X-Google-Smtp-Source: APXvYqzsTuviT5aNkwwxpngJQ/DjOkvU8YIIHHF9yGzi6lk6g5L9aG5wM1AhEEb5I6PbUv2+dma9rY8UVj6QAQGcTGU=
X-Received: by 2002:a19:7716:: with SMTP id s22mr8063496lfc.64.1559884755951;
 Thu, 06 Jun 2019 22:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
 <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
 <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com> <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
 <alpine.LRH.2.21.1906071043160.21512@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906071043160.21512@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jun 2019 01:19:04 -0400
Message-ID: <CAHC9VhSrjVmnsAuXDmHVmsyDaEF10nsvdxq7VsfCsh=NfaOMQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 6, 2019 at 8:45 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 5 Jun 2019, Paul Moore wrote:
> > On Wed, Jun 5, 2019 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> > >
> > > One hook with an added "bool blocking" argument, if
> > > that's the only difference?
> >
> > I think there is value in keeping a similar convention to the notifier
> > code on which this is based, see include/linux/notifier.h.
>
> Although this doesn't seem to be what other users in the kernel are doing.

How many of them potentially have the need for both blocking and
non-blocking notifiers?  I didn't go through the entire list of
callers, but it seems all that I looked at used only one type.  The
simple fact that we started with one type of notifier for the LSM, and
we are now switching to the other (and getting lucky that it is safe
to do so for the existing callers) seems to lend some weight to the
argument we may need both and adding "block"/"blocking"/etc. to the
name has value.

-- 
paul moore
www.paul-moore.com
