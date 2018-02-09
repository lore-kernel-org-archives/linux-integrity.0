Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeBIKCJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 05:02:09 -0500
Date: Fri, 9 Feb 2018 12:02:04 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180209100204.likckglpdx427dnl@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
 <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
 <1518109320.21828.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1518109320.21828.2.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
> There is an identified regression: the TPM driver will now periodically
> fail to attach.  However, there's no point reviewing until we agree
> what the fix is.  I was just waiting to verify this fixed my problem
> (which means seeing the messages it spits out proving the TPM has
> remained in self test).  I have now seen this and the driver still
> works, so I can submit a formal patch.

For the self-test the duration falls down to 2 seconds as the specs do
not contain any well-defined duration for it, or at least I haven't
found it.

I see three alternative ways the fix the self-test:

1. Execute self-test with fullTest = YES.
2. Have a flag TPM_CHIP_TESTING that is set when the self-test is
   started. Issue a warning on time-out. Check for this flag in
   tpm_transmit_cmd() and tpm_write() and resend self-test command
   if the flag is stil test before the actual command. Return -EBUSY
   and print a warning if self-test is still active.
3. Increase the duration to the "correct" value if we have one.

/Jarkko
