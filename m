Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:64625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730724AbeHGC0U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Aug 2018 22:26:20 -0400
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
 <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
 <1533596748.3159.19.camel@HansenPartnership.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
Date: Mon, 6 Aug 2018 17:09:01 -0700
MIME-Version: 1.0
In-Reply-To: <1533596748.3159.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 08/06/2018 04:05 PM, James Bottomley wrote:
> For an async interface, shouldn't I be able to queue an
> arbitrary number of commands without blocking?

That was the approach in the v1 version of this patch, but
Jason requested this to be changed so that only one command
at a time can be processed.
Thanks,
-- 
Tadeusz
