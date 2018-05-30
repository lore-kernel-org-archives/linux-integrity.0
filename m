Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54602 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbeE3RYy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 13:24:54 -0400
Subject: Re: [PATCH v2] tpm: fix race condition in tpm_common_write()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <152702503883.25871.17829919385428251068.stgit@tstruk-mobl1.jf.intel.com>
 <20180523135003.GG363@linux.intel.com>
 <20180530171315.GA23184@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <c93827bb-bce6-1db4-360e-c5092a3ebe38@intel.com>
Date: Wed, 30 May 2018 10:24:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180530171315.GA23184@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/30/2018 10:13 AM, Jarkko Sakkinen wrote:
> I pushed it now with appropriate tags, please check.
Looks good. Thanks.
-- 
Tadeusz
