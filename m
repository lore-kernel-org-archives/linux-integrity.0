Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:37586 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967889AbeBOMAn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Feb 2018 07:00:43 -0500
Date: Thu, 15 Feb 2018 14:00:38 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180215104901.7wrznmilvoqnnadw@linux.intel.com>
References: <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
 <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
 <1518109320.21828.2.camel@HansenPartnership.com>
 <20180209100204.likckglpdx427dnl@linux.intel.com>
 <3ddc36d3-f6ec-c107-bebd-b1692fa8fa2b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3ddc36d3-f6ec-c107-bebd-b1692fa8fa2b@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 09, 2018 at 04:00:44PM +0530, Nayna Jain wrote:
> IIUC, I see the duration and timeout specified in
> TCG_PC_Client_Platform_TPM_Profile_PTP_Specification_Family_2.0_Revision:
> Section 5.5.1.3 Command Timing: Table 15
>
> For selftest it is given as:
>
> Command                                      |  Duration[ms]    |
> Timeout[ms]
>
> TPM2_SelfTest(fullTest=YES)                 1000 2000
> TPM2_SelfTest(fullTest=NO) 20                        750
>
> With that I think, TPM is expected to complete the selftest in max 2000 ms.

Thanks. So it looks that some TPMs are not spec compliant.

> Thanks & Regards,
>      - Nayna

/Jarkko
