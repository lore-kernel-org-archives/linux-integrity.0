Return-Path: <SRS0=wcDA=23=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C4BC33C8C
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 21:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34843207FF
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 21:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFVx1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:53:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:47253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFVx1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 16:53:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 13:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="420836500"
Received: from ryanchev-mobl.ger.corp.intel.com ([10.252.23.147])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2020 13:53:24 -0800
Message-ID: <abc1b20bf3170eeed11922f5678608a6357160f1.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/9] security: keys: trusted: use ASN.1 tpm2 key
 format for the blobs
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 06 Jan 2020 23:53:23 +0200
In-Reply-To: <20191230173802.8731-5-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-5-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:

Again bad formatting in the short summary.

> Modify the tpm2 key format blob output to export and import in the
> ASN.1 form for tpm2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two tpm2b quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.

I think this is fair enough when it comes to backwards compatibility.

What you should do with the earlier patch is to document in the commit
message this framework for backwards compatibility. It is redundancy
but makes the commit log easier to follow. E.g. tell in that commit
message that ASN.1 loader will handle loading old blobs.

> The benefit of the ASN.1 format is that it's a standard and thus the
> exported key can be used by userspace tools.  The format includes
> policy specifications, thus it gets us out of having to construct
> policy handles in userspace and the format includes the parent meaning
> you don't have to keep passing it in each time.

Please be explicit with the tools you are referring. Point out what
you are using if there is variable number of choices.

In high-level the code change itself looks good.

/Jarkko

