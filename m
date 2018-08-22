Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40176 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeHVOq0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Aug 2018 10:46:26 -0400
MIME-Version: 1.0
References: <20180814180551.28311-1-davidj@linux.ibm.com> <alpine.LRH.2.21.1808150427590.25735@namei.org>
In-Reply-To: <alpine.LRH.2.21.1808150427590.25735@namei.org>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 22 Aug 2018 14:21:43 +0300
Message-ID: <CACE9dm8NbQK-1ATWNLAQA2GnE0Eguidghr0V2dcZW7+NN+w7OA@mail.gmail.com>
Subject: Re: [PATCH 1/7] evmtest: Regression testing Integrity Subsystem
To: James Morris <jmorris@namei.org>
Cc: davidj@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, david@davidej.com, pvorel@suze.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I will have a look to patches.

Thanks,
Dmitry

On Tue, Aug 14, 2018 at 9:34 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 14 Aug 2018, David Jacobson wrote:
>
> > This patchset introduces evmtest -- a stand alone tool for regression
> > testing IMA.
>
> Nice!
>
> I usually run the SELinux testsuite as a general sanity check of LSM
> before pushing to Linus, and I'll also run this once it's merged.
>
> --
> James Morris
> <jmorris@namei.org>



-- 
Thanks,
Dmitry
