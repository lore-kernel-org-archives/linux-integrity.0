Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39613 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeA0KJJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jan 2018 05:09:09 -0500
Date: Fri, 26 Jan 2018 14:11:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Subject: Re: [LTP] [RFC PATCH 2/2] security/ima: Run measurements after policy
Message-ID: <20180126131145.GB12731@rei>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <20180111202821.31639-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111202821.31639-3-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/ima | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/runtest/ima b/runtest/ima
> index 20d2e0810..3462d12b1 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -1,5 +1,5 @@
>  #DESCRIPTION:Integrity Measurement Architecture (IMA)
> -ima01 ima_measurements.sh
> -ima02 ima_policy.sh
> +ima01 ima_policy.sh
> +ima02 ima_measurements.sh
>  ima03 ima_tpm.sh
>  ima04 ima_violations.sh

Uh, depending on order of testcases in runtest file is broken anyways,
what is the real problem here?

Also I suppose that we may as well rename the test ids (e.g. ima01) to
match the shell script name, since I find it more descriptive.

-- 
Cyril Hrubis
chrubis@suse.cz
