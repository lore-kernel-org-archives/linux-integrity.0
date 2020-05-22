Return-Path: <SRS0=IAFg=7E=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15EC433E0
	for <linux-integrity@archiver.kernel.org>; Fri, 22 May 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303B1207D8
	for <linux-integrity@archiver.kernel.org>; Fri, 22 May 2020 20:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgEVUDw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 May 2020 16:03:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:20425 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730893AbgEVUDw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 May 2020 16:03:52 -0400
IronPort-SDR: +gDlE+e81/whp9+O3/bQlgy1q1MIJTOAcC8JCP1Hz0FOwK0yv/RguEYre6KPyuzRDWDVV2fGID
 F/kxuBhFVlFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 13:03:48 -0700
IronPort-SDR: UMxqP361Z5IU1SbIPlTOY0/kGZzClrkRm2tcgFjt2ftgo2VBoWiQ/jJLxFFMgoU5ThQTW2lPDS
 V1wHC6cYp+Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="412856691"
Received: from rpurrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.10])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2020 13:03:45 -0700
Date:   Fri, 22 May 2020 23:03:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
Message-ID: <20200522200346.GB150221@linux.intel.com>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org>
 <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 22, 2020 at 10:29:44PM +0300, Maxim Uvarov wrote:
> On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > > Register driver on TEE bus. module tee registers bus,
> >
> > "on the TEE bus"
> >
> > "The module tee"
> >
> > > and module optee calls optee_enumerate_devices() to scan
> > > all devices on the bus. Trusted Application for this driver
> >
> > Looking at drivers/tee, it shows that tee and optee are in fact the same
> > module as opposed to what your commit message says.
> >
> 
> In the current kernel it's 2 different modules.
> 
> > > can be Early TA's (can be compiled into optee-os). In that
> > > case it will be on OPTEE bus before linux booting. Also
> > > optee-suplicant application is needed to be loaded between
> > > OPTEE module and ftpm module to maintain functionality
> > > for fTPM driver.
> >
> > Why is this needed and why things worked before having this?
> >
> 
> Before these changes user space has to drive boot sequence. I.e.  tee
> and optee modules loads, then application tee-supplicant has to start
> and only then module ftpm can be loaded. The reason for that is
> storage services are implemented in userspace and driver needs them.

Is the TPM implementation uploaded to TEE from user space and or what
storage are we talking about? Not sure how these storage services
connect to the TPM.

/Jarkko
