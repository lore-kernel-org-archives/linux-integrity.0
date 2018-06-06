Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752407AbeFFT5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jun 2018 15:57:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w56Jmqms092104
        for <linux-integrity@vger.kernel.org>; Wed, 6 Jun 2018 15:57:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jej203y7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Jun 2018 15:57:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 6 Jun 2018 20:57:15 +0100
Subject: Re: [PATCH] ima-evm-utils: attr/xattr.h is deprecated. Use
 sys/xattr.h instead
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Lars Wendler <polynomial-c@gentoo.org>,
        =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 06 Jun 2018 15:57:10 -0400
In-Reply-To: <20180524140410.16988-1-polynomial-c@gentoo.org>
References: <20180524140410.16988-1-polynomial-c@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528315030.3255.46.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Lars, Andre,

On Thu, 2018-05-24 at 16:04 +0200, Lars Wendler wrote:
> See also:
> http://git.savannah.nongnu.org/cgit/attr.git/commit/?id=7921157890d07858d092f4003ca4c6bae9fd2c38

I'm so sorry, but Andre Draszik's previously posted a patch[1] was
never upstreamed.  Could you review/ack his patch please?

Mimi

[1] https://sourceforge.net/p/linux-ima/mailman/linux-ima-devel/thread/20161017114532.1936-1-git%40andred.net/
> ---
>  configure.ac | 2 +-
>  src/evmctl.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 0497eb7..1f017e2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -30,7 +30,7 @@ AC_SUBST(OPENSSL_LIBS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> 
> -AC_CHECK_HEADERS(attr/xattr.h, , [AC_MSG_ERROR([attr/xattr.h header not found. You need the libattr development package.])])
> +AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
> 
>  #debug support - yes for a while
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2ffee78..3fbcd33 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -49,7 +49,7 @@
>  #include <stdint.h>
>  #include <string.h>
>  #include <dirent.h>
> -#include <attr/xattr.h>
> +#include <sys/xattr.h>
>  #include <linux/xattr.h>
>  #include <getopt.h>
>  #include <keyutils.h>
