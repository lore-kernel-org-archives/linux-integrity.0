Return-Path: <SRS0=Ztmh=XF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02711C3A5A2
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588720872
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 11:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfIJLnl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:43:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:29533 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfIJLnl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 07:43:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 04:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="384302689"
Received: from mweingar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.26])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2019 04:43:37 -0700
Date:   Tue, 10 Sep 2019 12:43:36 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, dhowells@redhat.com
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190910114336.GA7018@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> @Jarkko: No worries, I understand the situation.

I made the call to add them anyway to my TPM tree.

/Jarkko
