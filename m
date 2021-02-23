Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF35C433E0
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Feb 2021 23:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33CA64FC0
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Feb 2021 23:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBWXgp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:36:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:32968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233839AbhBWXep (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 18:34:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93768AC6E;
        Tue, 23 Feb 2021 23:34:00 +0000 (UTC)
Date:   Wed, 24 Feb 2021 00:33:58 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ima: Free IMA measurement buffer on error
Message-ID: <YDWQ5rBBe8t7+Bs2@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
 <YB0YdqbbdAdbEOQw@kroah.com>
 <7000d128-272e-3654-8480-e46bf7dfad74@linux.microsoft.com>
 <6a5b7a1767265122d21f185c81399692d12191f4.camel@linux.ibm.com>
 <b8573374-86d0-f679-6c9f-a61b2bc6f7ea@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8573374-86d0-f679-6c9f-a61b2bc6f7ea@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

<snip>
> > > > <formletter>

> > > > This is not the correct way to submit patches for inclusion in the
> > > > stable kernel tree.  Please read:
> > > >       https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > for how to do this properly.

> > > > </formletter>


> > > Thanks for the info Greg.

> > > I will re-submit the two patches in the proper format.

> > No need.  I'm testing these patches now.  I'm not exactly sure what the
> > problem is.  Stable wasn't Cc'ed.  Is it that you sent the patch
> > directly to Greg or added "Fixes"?

> I had not Cced stable, but had "Fixes" tag in the patch.

> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")

> The problem is that the buffer allocated for forwarding the IMA measurement
> list is not freed - at the end of the kexec call and also in an error path.
> Please see the patch description for

> [PATCH v2 2/2] ima: Free IMA measurement buffer after kexec syscall

> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  This buffer is not freed before
> completing the kexec system call resulting in memory leak.

> thanks,
>  -lakshmi

Mimi, Lakshmi, it looks like these two fixes haven't been submitted to stable kernels.
Could you please submit them?

Thanks a lot!

Kind regards,
Petr
