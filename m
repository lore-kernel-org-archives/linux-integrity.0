Return-Path: <SRS0=UO4a=55=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E83C2BA19
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Apr 2020 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D3F20731
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Apr 2020 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgDMSE6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:04:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:21995 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387498AbgDMSE5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Apr 2020 14:04:57 -0400
IronPort-SDR: vJilkxm2cgYF+COsdmieKZZulFmGLwHKxnPNAAm8yeYy2iwXqwkDPu4E8xCYNC/QlO+OVUv5SR
 7vFa3lJmoPIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 11:04:56 -0700
IronPort-SDR: 2Jv2GVqHHih2DWxtcSjbsstTeFF/7vWompjE/cJJAd4lhG+cYngayireNFDKpAD1Lgod8I+DTo
 fd87PsO8483w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="252946877"
Received: from sarsteda-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.40.211])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 11:04:53 -0700
Date:   Mon, 13 Apr 2020 21:04:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ezra Buehler <ezra@easyb.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
Message-ID: <20200413180440.GA10917@linux.intel.com>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
 <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 13, 2020 at 07:02:20AM +0200, Ezra Buehler wrote:
> Hi Jarkko,
> 
> On 12 Apr 2020, at 19:07, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
> >> Hi Jarkkon,
> >> 
> >>> On 12 Apr 2020, at 16:36, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >>> +        except ProtocolError(e):
> >> 
> >> Should this not be
> >> 
> >>        except ProtocolError as e:
> > 
> > Unless there is a functional difference, does it matter?
> > 
> > /Jarkko
> 
> Well, your patch confuses me a lot. It looks to me like you are passing
> the undefined `e` variable to the constructor.
> 
> When I run flake8 on it I get following error (among others):
> 
>     F821 undefined name 'e'

I don't know what flake8 is.

> What I suggested is the standard syntax:
> https://docs.python.org/3/tutorial/errors.html

It passed the Python 3 interpreter.

> Did you test this? You should get an error as soon as an exception
> occurs.

Yes. Interpreter did not complain. I did not know that the language
is broken that way that you have to exercise the code path to get
a syntax error.

/Jarkko
