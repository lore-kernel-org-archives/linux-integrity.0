Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933761AbeALOxW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jan 2018 09:53:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0CEr1dM120258
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jan 2018 09:53:22 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fey0rgnaa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jan 2018 09:53:22 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 12 Jan 2018 14:53:19 -0000
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        kgold@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Date: Fri, 12 Jan 2018 09:53:15 -0500
In-Reply-To: <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
         <20171208184658.9588-9-Alexander.Steffen@infineon.com>
         <1515700018.3420.13.camel@linux.vnet.ibm.com>
         <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515768795.3420.111.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-01-12 at 09:28 +0100, Alexander Steffen wrote:
> On 11.01.2018 20:46, Mimi Zohar wrote:
> > Hi Alexander,
> > 
> > On Fri, 2017-12-08 at 19:46 +0100, Alexander Steffen wrote:
> >> There do not seem to be any real limits one the amount/duration of wait
> >> states that the TPM is allowed to generate. So at least give the TPM some
> >> time to clean up the situation that caused the wait states instead of
> >> retrying the transfers as fast as possible.
> > 
> > Without this patch, the TPM performance on the pi is amazing!  A
> > thousand extends takes ~6.5 seconds.  Unfortunately, the same thousand
> > extends with this patch takes > 2+ minutes.  TPM_TIMEOUT (5 msecs) is
> > a really long time.  Why so long?
> 
> My problem is the lack of specification for the wait state 
> functionality. How many wait states may be signaled by the TPM? For how 
> long may the TPM signal wait states? Do you know any more details?

First, let me apologize for not thanking you for making these changes
in the first place.  With just the burstcount patch, but without your
wait state patches, the pi doesn't boot.  I now have a test
environment and can reproduce the problem.  :)  

With your wait state patches, but without this patch, the time is ~14
seconds per thousand extends, as opposed to the ~6.5 I reported above.
 [The ~6.5 seconds is for already measured files.  Files that have
already been measured are not re-measured, so the TPM is not extended
again.  On other systems, "re-measuring" a 1000 files takes less than
1 sec.  I'm not sure why it is taking so long on the pi.]

Without any sleeps, I'm seeing that when it goes into a wait state, it
mostly loops once, every so often 3 times, but printing the counter
introduces delays and probably skews the results.  To get more
accurate results, would require aggregating the results and only
printing them after N number of extends.  I'll try to get that
information for you next week.

> The current implementation is based on the assumption that wait states 
> are the exception rather than the rule, so that longer delays are 
> acceptable. And without knowing for how long wait states can happen, I 
> chose rather longer delays (with this patch the TPM has several seconds 
> to clear wait states) to avoid failing on some unknown TPM 
> implementation in some special cases.
> 
> What would be a better implementation? No delay and simply retry for 
> five seconds?
  
Perhaps use TPM_POLL_SLEEP (1 msec), which Nayna introduced to sleep
within a max time loop.  Instead of using the number of retries, which
is currently defined as 50, define a max end time.  You could still
increment the timeout, but instead of "i * TPM_TIMEOUT) use "i *
TPM_POLL_SLEEP".  Although usleep_range is a lot better than msleep(),
there is still some overhead.  With tpm_msleep(), we don't have a way
of sleeping for less than 1 msec.  Perhaps the first time, when "i ==
0", try again without sleeping.

> What TPMs are you using for your tests? At least for the TPMs that I 
> have available for my tests (with a FIFO size of ~256 bytes) I would not 
> expect any wait states for extend commands.

I'm also surprised. The TPM on the pi isn't on a real SPI bus.  The
test is a tight loop, which forces N number of extends.  The pi is at
work, but I'm working from home today. :(  I'll have to get this info
next week.

Have you tried booting the pi with the "ima_tcb" boot command line
option?  Do you have any performance results that you could share? 

thanks,

Mimi
