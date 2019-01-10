Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A268C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227DC208E3
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfAJRkz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:40:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:25300 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfAJRkz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 12:40:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="113735969"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2019 09:40:52 -0800
Date:   Thu, 10 Jan 2019 19:40:50 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: Add support for the TCG2 event log on UEFI systems
Message-ID: <20190110174050.GH6589@linux.intel.com>
References: <20190109014847.39980-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 08, 2019 at 05:48:42PM -0800, Matthew Garrett wrote:
> There are several complexities associated with handling the crypto-agile
> log format from TPM2 systems on UEFI platforms. The first is that each
> log entry may be of variable length, necessitating parsing the log
> in-kernel to determine its length. The second is that the log is kept in
> boot services memory (which is reclaimed by the OS after
> ExitBootServices() is called), but ExitBootServices() may introduce
> additional log entries. These additional log entries are added to a
> separate log which should then be merged into the initial log.
> 
> This patchset makes the existing support for calculating TPM events more
> general (in order to allow it to be used from the EFI boot stub), adds
> support for copying up crypto agile logs from the boot environment to
> the running kernel and adds support for merging the final events log
> into the initial events log.

With a brief look, looks really good. I'll probably don't have time
to do a detailed review this week (still catching up after holidays).

/Jarkko
