Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55985 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbeCWKyo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Mar 2018 06:54:44 -0400
Date: Fri, 23 Mar 2018 11:54:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH v2 0/2] ima: Fallback to the builtin hash algorithm
Message-ID: <20180323105442.nyolkydmggw2uvlx@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180322144313.28748-1-pvorel@suse.cz>
 <1521747535.3848.273.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1521747535.3848.273.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Mimi,

> Agreed, the previous version was simpler/better.  My complaint with
> the previous version was that there was an error message, but
> continued without any indication of how it was resolved.  Changing the
> message in ima_init_crypto() is one solution, but adding an additional
> message works too. Would this work for you?

> @@ -73,6 +73,8 @@ int __init ima_init_crypto(void)
>                        hash_algo_name[ima_hash_algo], rc);
>                 return rc;
>         }
> +       pr_info("Allocated default hash algorithm: %s\n",
> +                hash_algo_name[ima_hash_algo]);
>         return 0;
>  }
Well, this is not correct, as if you specify correct (i.e. buildin) non default algorithm, it's said to
be the default. e.g. ima_hash=md5
[    2.161089] ima: Allocated default hash algorithm: md5
Just a detail, but why not be precise?
Going to post a version which fixes that having a message in ima_init_crypto().

> Mimi

Kind regards,
Petr
