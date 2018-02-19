Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:42285 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932156AbeBSW0N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 17:26:13 -0500
Received: by mail-qk0-f173.google.com with SMTP id b130so14155367qkg.9
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 14:26:12 -0800 (PST)
Date: Mon, 19 Feb 2018 15:26:09 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180219222609.25wmxxfycwxixmdh@ziepe.ca>
References: <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
 <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
 <1518109320.21828.2.camel@HansenPartnership.com>
 <20180209100204.likckglpdx427dnl@linux.intel.com>
 <6066758e-efe3-7432-0b8f-540a781cb3aa@infineon.com>
 <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
 <1518707632.5667.118.camel@linux.vnet.ibm.com>
 <a85f5b00-8291-b394-ca76-a2044b347d64@infineon.com>
 <67ef8389-fefa-d2c0-43c0-11c87724abc0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67ef8389-fefa-d2c0-43c0-11c87724abc0@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Feb 19, 2018 at 02:45:31PM +0530, Nayna Jain wrote:

> To query for the result, it need not send self test command again, I think
> we can use TPM2_GetTestResult().
> According to Spec, TPM Rev 2.0 Part 3 - Commands , Section 10.4, the command
> will return the following possible test results.
> 
> TPM_RC_NEEDS_TEST - SelfTest has not been executed.
> TPM_RC_TESTING - Tests are still in progress
> TPM_RC_FAILURE - Tests Failure.
> TPM_RC_SUCCESS - Tests successfully completed.

That sounds like a great way to fix this TPM without creating a whole
new flow..

TPM1 doesn't have this command which is why the self test loop was
written with repeated self test, it just got copied that way when
someone implemented the same thing for TPM2..

Jason>
