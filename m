Return-Path: <SRS0=wKLx=56=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A5C2BB1D
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A3B206E9
	for <linux-integrity@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504910AbgDNTfr (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:35:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:45322 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504805AbgDNTfq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 15:35:46 -0400
IronPort-SDR: BBNag4/vldgH1A6t2E9Xw8IV8nUBrHeLJoh/rhwstwKu8DFYwU8T44+uqjP/rZWcHGT17vEcdb
 rytmZlYBcX2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:35:45 -0700
IronPort-SDR: PdFZVdsop4wEI6kZ5uvPu49uwWNzttYDZCiEVJdjagXQLZy9j0X5G1FOz2eBNwHw/E3YIfFHTY
 cVdZQfx1tDBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="253291808"
Received: from jclobus-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.176])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 12:35:43 -0700
Date:   Tue, 14 Apr 2020 22:35:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200414193542.GB13000@linux.intel.com>
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
 <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 14, 2020 at 11:55:43AM +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Tianjia Zhang
> > Sent: Tuesday, April 14, 2020 1:42 PM
> > To: peterhuewe@gmx.de; jarkko.sakkinen@linux.intel.com; jgg@ziepe.ca;
> > arnd@arndb.de; gregkh@linuxfoundation.org; zhang.jia@linux.alibaba.com
> > Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> > tianjia.zhang@linux.alibaba.com
> > Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
> > 
> > For the algorithm that does not match the bank, a positive
> > value EINVAL is returned here. I think this is a typo error.
> > It is necessary to return an error value.
> 
> Yes, thanks.
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Happen to have the commit ID at hand for fixes?

Thanks.

/Jarkko
