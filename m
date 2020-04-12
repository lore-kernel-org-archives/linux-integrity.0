Return-Path: <SRS0=nhA0=54=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F11C2BA2B
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B9E206E9
	for <linux-integrity@archiver.kernel.org>; Sun, 12 Apr 2020 17:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgDLRPG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgDLRPG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Apr 2020 13:15:06 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 13:15:06 EDT
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC26C0A3BF0;
        Sun, 12 Apr 2020 10:07:22 -0700 (PDT)
IronPort-SDR: lQDYthYjuAhHSUjxlcGVfMtCP9BdVf6pRYeZsIEuLVgv+aw+RpPPs5rzS9wUfFIRnTXLOuamr0
 GUJasPAqg8Yw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 10:07:22 -0700
IronPort-SDR: SmiQxsz75gR7NkwXRwXj40onoVS8+6VYMMeh1GH4lu/xkkcnBrYaSGbxy/tBJmQF4cCgOa6TwY
 sgONkR7vLNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,375,1580803200"; 
   d="scan'208";a="453997712"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2020 10:07:20 -0700
Date:   Sun, 12 Apr 2020 20:07:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ezra Buehler <ezra@easyb.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
Message-ID: <20200412170719.GA324408@linux.intel.com>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
> Hi Jarkkon,
> 
> > On 12 Apr 2020, at 16:36, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > +        except ProtocolError(e):
> 
> Should this not be
> 
>         except ProtocolError as e:

Unless there is a functional difference, does it matter?

/Jarkko
