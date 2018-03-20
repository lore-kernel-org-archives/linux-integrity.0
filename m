Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39331 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeCTIk1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 04:40:27 -0400
Date: Tue, 20 Mar 2018 09:40:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Morris <jmorris@namei.org>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH] ima: Avoid using not initialized IMA
Message-ID: <20180320084026.tugrsi73qjxxkjig@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180316232827.3791-1-pvorel@suse.cz>
 <1521336476.3503.74.camel@linux.vnet.ibm.com>
 <alpine.LRH.2.21.1803191542410.5791@namei.org>
 <1521457159.3503.93.camel@linux.vnet.ibm.com>
 <20180319200516.5kgloj4vdigxb52y@dell5510>
 <1521490800.3503.202.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1521490800.3503.202.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

> > OK, I have v2 which use CONFIG_IMA_DEFAULT_HASH, I'll post it tomorrow.
> > But I'd also keep this patch as well, this check doesn't harm and IMHO you can never be
> > sure it does not fail.

> Adding a new measurement gap is not an acceptable solution.  Either an
> ima_init() failure causes the kernel to panic, or we force IMA to use
> the default builtin Kconfig hash algorithm.

Thank you for a clarification. I posted new patch which forces using default hash in case
of error and using different algorithm.

I don't know whether even this (third) attempt (to use default hash) can fail, but in case
it can, how do you prefer to handle this situation? If you really prefer kernel panic
(e.g. don't like previous patch fixing at least ima_post_path_mknod()), I suggest removing
ima_initialized as it's unused and confusing.

> Mimi


Kind regards,
Petr
