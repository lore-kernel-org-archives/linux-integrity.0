Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:44285 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAkP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 20:40:15 -0400
Date: Tue, 16 Oct 2018 19:48:51 +0300 (EEST)
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.ibm.com>
cc: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
In-Reply-To: <24b611f6-8080-3f99-56e5-818bd16ef4f8@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1810161947370.11306@jsakkine-mobl1>
References: <20180928223035.14471-1-tomas.winkler@intel.com> <20180928223035.14471-7-tomas.winkler@intel.com> <24b611f6-8080-3f99-56e5-818bd16ef4f8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 12 Oct 2018, Nayna Jain wrote:
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com>
>
> Sorry for bit delay in testing.
>
> Thanks & Regards,
>   - Nayna

Thank you. This is a big refactoring so your effort is highly
appreciated :-)

/Jarkko
