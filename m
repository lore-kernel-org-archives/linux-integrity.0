Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD0C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16964206BA
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8MZn6lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDW0r (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:26:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40458 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfDDW0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 18:26:47 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so6410696itb.5
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aILiJVTXdWFACLNL/LizlLJjkfsIR9h8BgVLKKyPOTg=;
        b=C8MZn6lIJ5iIwfqYjnCRAnLzA0Lo5/BpPQgeDiedDBeTxa5LX5enA7jTPPEVW+N+x2
         F8zj/Zro9wdJd5D2iZDjH34fxYRxtseeVLm0NOWxlrUCNvTIYr1g4Ugt5sUlHqAD8iX7
         CSPtUPPY5p7mUi4z/korB4QTZVFDx/QF0bkJTfUldMDd1Fm9PFbg1d8EYZuHqoJJsuHN
         iPlpjLIaRpkLGzb+UYDMBO+fTwQh6x2JcAHyJfHlfot72yrAGYEAY50rugVaAbwsRxn3
         k+72aOSmWSRO0rz+xIC5qVvwLT2SSiG56r/BOjpxQShPMpYXDoRgIS0AUA0c7rMwM5CA
         791g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aILiJVTXdWFACLNL/LizlLJjkfsIR9h8BgVLKKyPOTg=;
        b=QH385a6DhFAZvQbVXy+mRbdsALJr9gS0eZ0CrkBpfHeK3YT/6htYGDdnBfc/3PBacF
         HygeNFzsIaMxJLSJ89dx5tPb1tBWke/tvxTxAwZvjHoVAN5GXaF50dodEgjJRkXCgK0D
         sz6aUzxlrlI/XTYh/8O+qGKbLD7hfIK6jRyCqIMi2EvfJdBvLoIh/YGxQ9ocYJ4ahg27
         V9Zz6Ff9ELTtFTweiv1yjTj7PTiwg3QGLswlkPXLkHcLPThOzlFAxML6BCVLkzeBmSip
         k+UKpFYqrnW7kq6dUTVBWQfNwwVmLO7fKnJ4+7QXbb8bCplPtSTH55NVL1VcKwUgO0Gg
         n19A==
X-Gm-Message-State: APjAAAWoKHantDaTT324lN88ivR4AlB4NyT4EbqEy0y5TnciRjFdRl9z
        DvwmKgZXX9GmMy72rGzU2FSpzD0iqACk/2dYqu1tnw==
X-Google-Smtp-Source: APXvYqzLdNaBH0YOCudXk658eRARc0U1MEItYLXnyFyx6e/QvP6Nvn0BtN6oEHMKXXLWfFvk0yCT64wHhfXclIWWc60=
X-Received: by 2002:a24:7294:: with SMTP id x142mr6995963itc.7.1554416806444;
 Thu, 04 Apr 2019 15:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com> <1554416328.24612.11.camel@HansenPartnership.com>
In-Reply-To: <1554416328.24612.11.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 15:26:34 -0700
Message-ID: <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 4, 2019 at 3:18 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> The obvious other thought is integration with fs-verity, which is a
> filesystem maintained possibly signed merkel tree hash.  The problem
> here is what does vfs_get_hash() actually mean?  The assumption seems
> to be that it is the flat hash of the entire file which doesn't work
> for merkle trees.  However, if it could be a representative hash of the
> file which is produced however the filesystem decides, it could work
> (well, unless the file is copied on to a different fs, of course ...).

We could always use fs-verity to store additional verifiable metadata
including actual hashes for consistency?
