Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29976 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbeGSSiS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Jul 2018 14:38:18 -0400
Subject: Re: [PATCH] tpm: add support for partial reads
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <1532020750.5396.4.camel@HansenPartnership.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
Date: Thu, 19 Jul 2018 10:54:03 -0700
MIME-Version: 1.0
In-Reply-To: <1532020750.5396.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/19/2018 10:19 AM, James Bottomley wrote:
> That's just an implementation, though, what's the use case?

Hi James,
The use case is described in the TCTI spec [1] in the
"3.2.5.2 receive" section.

Thanks,
-- 
Tadeusz

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_TCTI_v1.0_r12_PUBLIC_REVIEW.pdf
