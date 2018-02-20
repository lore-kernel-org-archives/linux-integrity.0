Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:50940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeBTOYK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:24:10 -0500
Message-ID: <1519136646.4113.13.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 16:24:06 +0200
In-Reply-To: <1518810337.4475.16.camel@HansenPartnership.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1518807576.4475.3.camel@HansenPartnership.com>
         <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
         <1518810337.4475.16.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 11:45 -0800, James Bottomley wrote:
> tsscreateek -cp -alg ec -noflush

Can you describe in high-level what this command does? I will rather
add a test to my smoke test suite than depend on TSS implementations
for various reasons. This seems like a good test case to add as
part of it.

/Jarkko
