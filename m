Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388038AbeGWV43 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 17:56:29 -0400
Subject: Re: [PATCH] tpm: add support for partial reads
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
Date: Mon, 23 Jul 2018 13:53:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180723201956.GB26824@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/23/2018 01:19 PM, Jarkko Sakkinen wrote:
> In this case I do not have any major evidence of any major benefit *and*
> the change breaks the ABI.

As I said before - this does not break the ABI.
As for the benefits - it help user space in how they implement the receive
path. Application does not need to provide a 4K buffer for every read even
if the response is, for instance 8 bytes long.
Thanks,
-- 
Tadeusz
