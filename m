Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D1C282C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D47218D3
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 10:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbfBMKqt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:46:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:10970 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBMKqt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 05:46:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 02:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="274709607"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 02:46:44 -0800
Date:   Wed, 13 Feb 2019 12:46:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V3 3/4] tpm: Append the final event log to the TPM event
 log
Message-ID: <20190213104644.GC7087@linux.intel.com>
References: <20190211215518.81419-1-matthewgarrett@google.com>
 <20190211215518.81419-4-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211215518.81419-4-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 01:55:17PM -0800, Matthew Garrett wrote:
> +	if (efi.tpm_final_log != EFI_INVALID_TABLE_ADDR &&
> +	    efi_tpm_final_log_size != 0) {
> +		if (tpm_log_version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {

Instead of nesting code heavily I would just:

if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
    efi_tpm_final_log_size == 0 ||
    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
    goto out_memunmap;

And in the tail:

out_munmap:
	memunmap(final_tbl);
	memunmap(log_tb);
	return tpm_log_version;

err_munmap:
	memunmap(final_tbl);
	memunmap(log_tb);
	return -ENOMEM;
}

/Jarkko
