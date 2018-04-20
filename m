Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTLoT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 07:44:19 -0400
Date: Fri, 20 Apr 2018 13:42:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [LTP] [RFC PATCH v3 10/10] ima/ima_mmap: Rewrite to new library
Message-ID: <20180420114232.GD19090@rei>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-11-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419195503.7194-11-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi!
> -	ima_mmap $FILE &
> +	ima_mmap -f $FILE &
>  	# wait for violations appear in logs
>  	tst_sleep 1s

Whenever we wait for logs we should poll for them.

But same as the sleep in previous case, let's get these tests fixed
first, then we can improve on the performance and robustness.

-- 
Cyril Hrubis
chrubis@suse.cz
