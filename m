Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E24C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 23:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED7222C2
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 23:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfBLXL6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:11:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:63703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfBLXL6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 18:11:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 15:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="124013049"
Received: from briva-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.236])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 15:11:55 -0800
Date:   Wed, 13 Feb 2019 01:11:54 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH V2 2/4] tpm: Reserve the TPM final events table
Message-ID: <20190212231154.GC3977@linux.intel.com>
References: <20190204213303.131064-1-matthewgarrett@google.com>
 <20190204213303.131064-3-matthewgarrett@google.com>
 <20190211163855.GF8431@linux.intel.com>
 <CACdnJut2tNMZvjyc=TxaxRQiuj-Xjb1pyTZgHOYxkPO-VKYM1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJut2tNMZvjyc=TxaxRQiuj-Xjb1pyTZgHOYxkPO-VKYM1w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 12:58:21PM -0800, Matthew Garrett wrote:
> > Wondering that should this function instead do right `in the beginning:
> >
> > if (efi.tpm_log == EFI_INVALID_TABLE_ADDR &&
> >     efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
> >         return 0;
> >
> > Feels odd condition that the log would not be invalid but the post log
> > (using post would be more self-describing than final imho) would be. Can
> > that legitly happen?
> 
> The spec name is final, so I kept it that way for consistency. Keeping
> a separate check for the final event log is partly out of
> defensiveness against firmware implementations getting this wrong -
> I've definitely found implementations that just don't produce any
> final events, so it wouldn't surprise me if there are some that don't
> install the table.

OK, sounds very reasonable.

> Done. I'll send an updated patchset.

Awesome, thank you.

/Jarkko
