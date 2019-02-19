Return-Path: <SRS0=Dh8F=Q2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83518C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Feb 2019 11:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E220449
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Feb 2019 11:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfBSL4y (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:56:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:17406 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSL4y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Feb 2019 06:56:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 03:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="321547895"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.132])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2019 03:56:52 -0800
Date:   Tue, 19 Feb 2019 13:56:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com
Subject: Re: [PATCH V3] Add support for TPM2 event logs on EFI systems
Message-ID: <20190219115652.GA29454@linux.intel.com>
References: <20190211215518.81419-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211215518.81419-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 01:55:14PM -0800, Matthew Garrett wrote:
> Updated with review feedback comments, no functional change.

Tried to test with a Geminilake NUC but for some reason do not see the log
file with this machine.

The final log *does* get reported:

[    0.000000] efi:  ACPI 2.0=0x69ca2000  ACPI=0x69ca2000  TPMFinalLog=0x69ce4000  SMBIOS=0x69f63000  SMBIOS 3.0=0x69f62000  ESRT=0x69f3e818  MEMATTR=0x63474118

I'll try to debug this further later on.

/Jarkko
