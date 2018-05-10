Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:60116 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965644AbeEJSG0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 14:06:26 -0400
Date: Fri, 11 May 2018 04:06:17 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Petr Vorel <pvorel@suse.cz>
cc: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH] ima: Remove unused variable ima_initialized
In-Reply-To: <20180510151548.7155-1-pvorel@suse.cz>
Message-ID: <alpine.LRH.2.21.1805110406020.1003@namei.org>
References: <20180510151548.7155-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 10 May 2018, Petr Vorel wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  security/integrity/ima/ima.h      | 1 -
>  security/integrity/ima/ima_main.c | 7 ++-----
>  2 files changed, 2 insertions(+), 6 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
