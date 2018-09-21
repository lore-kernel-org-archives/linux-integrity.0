Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:46678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391400AbeIVDrw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Sep 2018 23:47:52 -0400
Date: Sat, 22 Sep 2018 00:57:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2, RESEND 2/3] tpm: modify tpm_pcr_read() definition to
 pass TPM hash algorithms
Message-ID: <20180921215701.GA23799@linux.intel.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
 <20180917093820.20500-3-roberto.sassu@huawei.com>
 <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Sep 21, 2018 at 12:24:15PM +0200, Roberto Sassu wrote:
> On 9/17/2018 11:38 AM, Roberto Sassu wrote:
> > Currently the TPM driver allows other kernel subsystems to read only the
> > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > tpm2_pcr_read() to pass an array of tpm_digest structures, which contains
> > the desired hash algorithms. Initially, the array size is limited to 1.
> 
> Jarkko, is this patch ok?
> 
> Mimi, I wait for your review of the IMA part.
> 
> Roberto

Oops, just bumped into these. Have to check next week. Please add me to
either to- or cc-field in the future.

/Jarkko
