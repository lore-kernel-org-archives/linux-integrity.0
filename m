Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJESah (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 14:30:37 -0400
Date: Fri, 5 Oct 2018 14:31:47 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20181005113147.GA25985@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 04, 2018 at 11:45:30AM +0000, Winkler, Tomas wrote:
> There is no API change, in that sense.
> The exported API is in tpm-interface.c int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)  
> that is used is outside of the tpm reminds the same, only the open coded implementation of tpm2_pcr_extned has moved to
> tpm2-cmd.c, This code is not called out of tpm module.
> Please review the code again.

I did now revisit this and you are right that my choice of word was not
exactly correct. I apologize for that. The patch introduces API that we
would take away and that does make much sense.

The best way to sort things out is to just fix the warnings and leave
the TPM 2.0 part open coded inside tpm_pcr_extend(). The rationale for
this is to avoid unnecessary mainline changes when ever possible (which
is bad for backporting for stable kernels).

> Thanks
> Tomas

/Jarkko
