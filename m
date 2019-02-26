Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF7C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3392E217F5
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfBZSJR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:09:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:18001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfBZSJR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 13:09:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 10:09:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="150195259"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2019 10:09:14 -0800
Date:   Tue, 26 Feb 2019 20:09:13 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Markku Savela <msa@moth.iki.fi>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
Message-ID: <20190226180913.GA22368@linux.intel.com>
References: <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
 <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
 <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
 <1550753358.17768.85.camel@linux.ibm.com>
 <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
 <88215b47-976c-96d5-1098-40868d28d576@moth.iki.fi>
 <357e44f8-df31-48ec-d2f0-deabd0161fc0@moth.iki.fi>
 <1551183277.27819.66.camel@linux.ibm.com>
 <CAKv+Gu9H=yP8McwmsBP5nk-Fc3YHG2GF2zU+00gB4sqtfafyeg@mail.gmail.com>
 <1551189878.27819.86.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551189878.27819.86.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 26, 2019 at 09:04:38AM -0500, Mimi Zohar wrote:
> Hi Ard, thank you for responding.  The clk not being initialized early
> enough has been a problem for years.  Because of the clk not being
> initialized, the TPM initialization is deferred, causing IMA to go
> into TPM-bypass mode.

I'd guess this is an SPI issue and not really something that TPM could
resolve? Please correct me if I'm wrong. I.e. SPI gets initialized after
IMA.

/Jarkko
