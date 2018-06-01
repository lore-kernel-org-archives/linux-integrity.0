Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750964AbeFAW07 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 18:26:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w51MO9EJ022687
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jun 2018 18:26:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jbaabaaf0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 18:26:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Jun 2018 23:26:56 +0100
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: wangjunwen@baidu.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 01 Jun 2018 18:26:41 -0400
In-Reply-To: <CACdnJutAGYyB2FW9W-0v2yVDHdAwcm0KQY7pUao8hsjf8ifw6A@mail.gmail.com>
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
         <20180530202804.148245-1-mjg59@google.com>
         <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
         <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
         <1527796502.3427.46.camel@linux.vnet.ibm.com>
         <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
         <1527798728.3427.58.camel@linux.vnet.ibm.com>
         <CACdnJuvRoZ=McstC_f9uaqZ+zWWDu9L=yQCBXDF6xQMtmTsfcQ@mail.gmail.com>
         <1527852067.3427.81.camel@linux.vnet.ibm.com>
         <CACdnJutAGYyB2FW9W-0v2yVDHdAwcm0KQY7pUao8hsjf8ifw6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527892001.13403.21.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-06-01 at 13:52 -0700, Matthew Garrett wrote:
> On Fri, Jun 1, 2018 at 4:21 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Thu, 2018-05-31 at 14:06 -0700, Matthew Garrett wrote:
> > > EVM looks like it SELECTs CONFIG_SHA1, so I /think/ it should be ok
> > > before that patch?
> >
> > According to Junwen, with CONFIG_TRUSTED_KEYS enabled the HMAC and
> > SHA1 are allocated at __init.  The locking problem occurs when
> > CONFIG_TRUSTED_KEYS is not enabled.  His solution would have been to
> > move the crypto_alloc_shash() in EVM to an __init function.
> 
> Ok - I think just allowing it to be deferred is preferable, since
> otherwise we'd have to build in every hash algorithm that could be
> used for the signatures (which wasn't a problem before the non-sha1
> patch). How would you prefer me to send these two? The non-sha1 patch
> isn't in -next, so I can't add a fixes: for it at this point.

Switch the order of the two patches.  The bug fix goes first, then the
non-sha1 patch.  Remember we need an Ack from Herbert Xu for
introducing CRYPTO_NOLOAD.

Mimi 
