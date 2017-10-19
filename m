Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1366 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753427AbdJSOWw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 10:22:52 -0400
Date: Thu, 19 Oct 2017 17:22:44 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v4 3/4] tpm: reduce tpm polling delay in tpm_tis_core
Message-ID: <20171019142244.7aaqyc3hizzt7n7p@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
 <20171017203232.2262-4-nayna@linux.vnet.ibm.com>
 <20171018152447.b6scwbbmulrfzymw@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018152447.b6scwbbmulrfzymw@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 06:24:47PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 17, 2017 at 04:32:31PM -0400, Nayna Jain wrote:
> > The existing wait_for_tpm_stat() polls for the chip status after
> > 5msec sleep. As per TCG ddwg input, it is expected that tpm might
> > return status in few usec. So, reducing the delay in polling to
> > 1msec.
> > Similarly, get_burstcount() function sleeps for 5msec before
> > retrying for next query to burstcount in a loop. If it takes
> > lesser time for TPM to return, this 5msec delay is longer than
> > necessary.
> > 
> > After this change, performance on a TPM 1.2 with an 8 byte
> > burstcount for 1000 extends improved from ~14sec to ~9sec.
> > 
> > Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkkko.sakkinen@linux.intel.com>

/Jarkko
