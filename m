Return-Path: <MAILER-DAEMON@orsmga103.jf.intel.com>
Subject: Re: [RFC][PATCH 2/9] tpm_tis_core: access single TIS registers before doing
 complex transfers
Received: from mga09.intel.com ([134.134.136.24]:29084 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755307AbeARRQ1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 12:16:27 -0500
Date: Thu, 18 Jan 2018 19:16:21 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Message-ID: <20180118171621.jiqem5ak3ov22fzv@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-3-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-3-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:51PM +0100, Alexander Steffen wrote:
> There are several TIS registers that contain information on how exactly the
> TPM implements the TIS protocol. Complex commands that are used by the
> probe functions should only be sent to the TPM after all other registers
> have been read and the driver is properly configured to handle those
> transactions.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

The code change looks ok but the commit message does not describe what
the commit does. It describes a guideline and uses an abstract term
"complex command".

/Jarkko
