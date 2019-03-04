Return-Path: <SRS0=kjGR=RH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E907BC43381
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 22:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55EE2070B
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ4Tjgf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDWKY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:10:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36815 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDWKY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Mar 2019 17:10:24 -0500
Received: by mail-it1-f193.google.com with SMTP id v83so1279225itf.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 Mar 2019 14:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvrQBbD9NfUnjP2UMOyzpSPQmVjyHJI+n9Qa4R4WbwA=;
        b=PQ4Tjgf0dMju7OfVKD5vjm8zGJH9hnQ/oV+aQv9PODPfGElJKDMnvofMNr7Phg+Lt6
         fgGENcYnpwT30+sRSzYOLZv5xyIm7Xy7i5us9rp+Z+Jh+U48U076gniqDCS/T5ACRLE4
         fuH6m1C7M3skCGHHo3kTQxhlQ/3SrbVwhu/LE7+qQMcbKbsvGzY2BqA2q3X1GmpG7tdC
         eGrKhqQ9oVOGi5CShXTdzXdj17snvcDR28L3KbFCiKSFJ2wZHd1cB3Bmk95aynweh9ar
         Vff3xvj1/dVRpnV7gBG/EBJ8sR8sT4j9LGuLqO6sYqWxDERNRFFj9n9z+x01zkG4p1UR
         aTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvrQBbD9NfUnjP2UMOyzpSPQmVjyHJI+n9Qa4R4WbwA=;
        b=eHeByuI3TS6MaUld9B8w1AJ1YlDVbVKX73ryqGyMjt/rypGEnKEHgsOvCXD3Lhlvv8
         vLrDbr2e7nBraZ3UCqHJFLxx1Yv2WQnMkhl6AkG/Y+MfNet4ysvTjM56zSrHc57aB4v/
         R0jHMIGpIQ7GLCzDln3pwiNgmaahvbWbzcS/PisbSVnNm4g1+Sw6lROWIrGL4Is74vPk
         EbDDm6BGL/1iiKRDMkA5LLe5ANBGNWmD/9Yt1UPHJ0tJbcXh0dIiv4CTevy3ADux40Yj
         d1lCnAg0Bu56CQe9UA5+Bio7W6r36phj6DLm8Ab8o+UdfbwQfOCMsS2GPlWqNKSytE0p
         nOsw==
X-Gm-Message-State: APjAAAXD3UMUU0EiOvmVMPCdp/ZYGlHFuUBf8Nt8P0ZKrE15rM7pTAl4
        84chmuY6T4PTPf6Xq5K/nBBBl006mHefawUnUyZFzQ==
X-Google-Smtp-Source: APXvYqxXjyyXxJtBWUtDomFBIxwBf8RT1wkWgB6tS2PUAwblAUhs4waPPp4wrmLzxKHxLB/ePS3AMbskdl8DdysS7So=
X-Received: by 2002:a02:240d:: with SMTP id f13mr12225088jaa.105.1551737423427;
 Mon, 04 Mar 2019 14:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com> <1551731553.10911.510.camel@linux.ibm.com>
In-Reply-To: <1551731553.10911.510.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 4 Mar 2019 14:10:12 -0800
Message-ID: <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
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

On Mon, Mar 4, 2019 at 12:32 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Mon, 2019-03-04 at 11:52 -0800, Matthew Garrett wrote:
> > To be clear, I'm entirely happy to make this change - I'd just like to
> > ensure that I do it the right way!
>
> Falling back to reading the file is fine.  So we're assuming that the
> person signing a policy containing "get_hash" understands the
> ramifications.  And yes, only signed policies containing "get_hash"
> should be loaded.

I'm not clear on why requiring signed policies is helpful here. If you
allow FUSE mounts at all then you need to trust the FUSE filesystem to
return good results, in which case you can trust it to return valid
hashes. If you don't trust the FUSE filesystem then generating the
hash via read doesn't win you anything - the filesystem can return one
set of data on the initial IMA hashing, and then return a second set
later. Requiring signed policy doesn't change that.
