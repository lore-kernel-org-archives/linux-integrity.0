Return-Path: <MAILER-DAEMON@orsmga103.jf.intel.com>
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state retries
Received: from mga11.intel.com ([192.55.52.93]:48905 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754974AbeARScf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:32:35 -0500
Date: Thu, 18 Jan 2018 20:32:31 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Message-ID: <20180118183231.xew6ta4okbzlmsdi@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-9-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-9-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:57PM +0100, Alexander Steffen wrote:
> There do not seem to be any real limits one the amount/duration of wait
> states that the TPM is allowed to generate. So at least give the TPM some
> time to clean up the situation that caused the wait states instead of
> retrying the transfers as fast as possible.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

I agreee with Mimis comment that this change should be based on
time rather than retries.

/Jarkko
