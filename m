Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbdJSIKi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 04:10:38 -0400
Subject: Re: [PATCH] MAINTAINERS: update TPM driver infrastructure changes
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, tpmdd@selhorst.net,
        ashleydlai@gmail.com, zohar@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?Q?H=c3=a5vard_Skinnemoen?= <hskinnemoen@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Gertjan van Wingerde <gwingerde@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20170915223811.21368-1-jarkko.sakkinen@linux.intel.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <67e2777b-cb15-6104-b5c6-00c764029148@arm.com>
Date: Thu, 19 Oct 2017 09:10:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170915223811.21368-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 15/09/17 23:38, Jarkko Sakkinen wrote:
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  CREDITS     |  7 +++++++
>  MAINTAINERS | 13 ++-----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 5d09c26d69cd..dcd761885ea8 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4130,6 +4130,13 @@ D: MD driver
>  D: EISA/sysfs subsystem
>  S: France
>  
> +N: Marcel Selhorst
> +E: tpmdd@selhorst.net
> +D: TPM driver
> +
> +N: Ashley Lai
> +E: ashleydlai@gmail.com
> +D: IBM VTPM driver
>  
>  # Don't add your name here, unless you really _are_ after Marc
>  # alphabetically. Leonard used to be very proud of being the 
Given the comment here, can these two entries be moved to their
legitimate location? I'm quite proud (just like Leonard was before I
pushed him up) to be at the bottom of that file, and my family has
worked hard over generations to ensure its place at the end of most
alphabetical lists. I want my patch of CREDIT back! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
