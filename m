Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59587 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbeIRCpc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 22:45:32 -0400
Date: Tue, 18 Sep 2018 00:16:22 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20180917211622.GC6716@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-4-roberto.sassu@huawei.com>
 <20180916123749.GF5040@linux.intel.com>
 <322eb81b-3f3e-e37e-5fb0-a37aad3d06d7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <322eb81b-3f3e-e37e-5fb0-a37aad3d06d7@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 17, 2018 at 12:02:56PM +0200, Roberto Sassu wrote:
> This code has the same behavior of tpm2_get_pcr_allocation(). If some
> banks are not used, set the algorithm of the first unused to
> TPM_ALG_ERROR.

My point is that maybe it would sense to use zero for that in order
to make code a bit simpler.

/Jarkko
