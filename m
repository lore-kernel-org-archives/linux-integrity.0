Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28347 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeBTNab (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 08:30:31 -0500
Message-ID: <1519133428.4113.7.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 15:30:28 +0200
In-Reply-To: <1518805037.4640.27.camel@HansenPartnership.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 10:17 -0800, James Bottomley wrote:
> so I think it's something to do with tpm_validate_command.  I think,
> perhaps, we shouldn't call the getcaps for the command codes until
> the
> self test is over, but I need to do more debugging to track down
> what's
> going on.

The calls for tpm2_get_pcr_allocation() and tpm2_get_cc_attrs_tbl()
could be also moved before the self test.

/Jarkko
