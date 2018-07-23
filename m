Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388137AbeGWXDh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 19:03:37 -0400
Subject: Re: [PATCH] tpm: add support for partial reads
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
 <20180723215620.GH532@ziepe.ca>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
Date: Mon, 23 Jul 2018 15:00:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180723215620.GH532@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> The proposed patch doesn't clear the data_pending if the entire buffer
> is not consumed, so of course it is ABI breaking, that really isn't OK.

The data_pending will be cleared by the timeout handler if the user doesn't
read the response fully before the timeout expires. The is the same situation
if the user would not read the response at all.
Thanks,
-- 
Tadeusz
