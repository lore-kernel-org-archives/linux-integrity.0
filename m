Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A9C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71A9214DA
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 06:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZb1wOa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAJGq7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:46:59 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:36483 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGq7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 01:46:59 -0500
Received: by mail-io1-f54.google.com with SMTP id m19so8092858ioh.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Jan 2019 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wDB5SDMuh+Z+OAfteOJCIhehOJh/mbI+t0v7x/z9qY=;
        b=SZb1wOa1lPuTZSUt7vDpoNpY96VntINOQ6ovCBhg8yOWPGyIdN1UyvSLa3QqHic+1u
         bNE9lgnOuHIvvo+sQyyqBBSkJWWtFldUyYuWoEhh1HGzqjIphDL2asi9XMFirkfhsyPk
         PunFurjLDQ0uTdia9Rv2b7s8mAxU6JH+asT8Bfo/A+sj4S45TwEJntBwjqTcRqis1Y/g
         3BTiN6ZhQbHGp6DUeMoqIv9PxdQDIISORmumb/OXv5LyX9nvESaWHpHPAnNvfw0QZALE
         as395jQ/SuekJw47bGBFYuH8XaNn9VvyyRvuPsHhEifJ2ZyrpN6/bVYfc31kDYiuzMDI
         D+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wDB5SDMuh+Z+OAfteOJCIhehOJh/mbI+t0v7x/z9qY=;
        b=VuKbhht5alVPQEgZAvx4eEvd6Buyw2jV0suIpkdQF4jKDczKFufm0mnELY4HOeI6vY
         QaTFyMmkk5z27Qvf01/TDScHFwvMvBEO/RDr8UCY/fukNk0tHKn83rs8aLgzvAnhfLPc
         keSji5l5ZJsSqry0zyeqfnRXAbw66u9oaoX0yUdfPK1pdkvfFlqoaA1mHhy5CiAsXf14
         Z0MNeSf+38GHXzX9C4Na8HYEpP+bsSlLaNAnqm1T7SywwZ8vNoaX29cdM093BGhWO9OO
         vMtVWaxm1LUzp8KBi47guWEv8YJwxkEOZMknKHtnhRd652JdtOYyJpBoNJOWOhPxsiyA
         IzTw==
X-Gm-Message-State: AJcUukc+tCglDA42FrHRHSBzNUOZX478hEdvXX9QWIziHq5SeGfK9WW4
        ypVL7+g9OJVx+tpimoHP5U809aLkxdQ5iDHTcGUzwA==
X-Google-Smtp-Source: ALg8bN4i2PSwxbOfKvbDgnP+2AtdAgDpeV3iI8xxVQIyQ+2Wkd8CT4JsX50hqbBcJz8/LYf0m+cPg8bqBtQzr/uRlu0=
X-Received: by 2002:a6b:7e04:: with SMTP id i4mr5510008iom.116.1547102818115;
 Wed, 09 Jan 2019 22:46:58 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
 <1546981121.19931.130.camel@linux.ibm.com>
In-Reply-To: <1546981121.19931.130.camel@linux.ibm.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 10 Jan 2019 12:16:46 +0530
Message-ID: <CALUj-gvmo8pTGeHB=L+sZaP9a1QPTE2AXNc=vzzfZ+4GtVac3A@mail.gmail.com>
Subject: Re: OTA does not work with IMA due to xattr not supported by zip
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi. Any plan for zip archive format support.
Also when using EVM, the files has to be signed on target. So after
new files has been flashed on device during OTA, does private key also
needs to be present on system.


On Wed, Jan 9, 2019 at 2:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-08 at 06:56 +0530, rishi gupta wrote:
> > Hi Team,
> >
> > Android and android recovery based implementation for Linux, generates
> > ota package which is a zipped archive.
> >
> > I observed that xattr gets dropped when creating zip archive and
> > therefore after OTA system will not boot if IMA_APPRAISE_SIGNED_INIT
> > is used.
> >
> > This essentially means that IMA may not be used in commercial products
> > requiring OTA or I missed something or there is a workaround to such
> > problem.
> >
> > https://source.android.com/devices/tech/ota/tools
>
> Ok.  Some applications support xattrs (eg. RPM, tar); others don't
> (eg. Debian packages, CPIO/initramfs).  We worked with the RPM
> community to add xattr support.  Multiple attempts have been made to
> add xattr support to Debian packages.
>
> Mimi
>
