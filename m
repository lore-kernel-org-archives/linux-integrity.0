Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:38154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbeIYUdg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 16:33:36 -0400
Message-ID: <ca7221f592cfcdc312fe1ec72623f118dfa21788.camel@linux.intel.com>
Subject: Re: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest()
 using tpm_buf
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Sep 2018 17:25:40 +0300
In-Reply-To: <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-21-tomas.winkler@intel.com>
         <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-09-25 at 15:53 +0530, Nayna Jain wrote:
> > +
> > +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
> 
> I think this needs to buf.data instead of &buf.data
> 
> Thanks & Regards,
>       - Nayna

You are absolutely right. Thank you.

/Jarkko
