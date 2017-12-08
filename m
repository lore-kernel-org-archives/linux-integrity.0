Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753959AbdLHQR7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 11:17:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8GDbeS059066
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 11:17:58 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eqvs75462-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 11:17:58 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 16:17:55 -0000
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error
 (2314) occurred continue selftest`
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com
Cc: pmenzel@molgen.mpg.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Dec 2017 11:17:51 -0500
In-Reply-To: <20171208155641.GA2883@ziepe.ca>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
         <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
         <20171207183743.GB16884@ziepe.ca>
         <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
         <20171208155641.GA2883@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512749871.4364.9.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-12-08 at 08:56 -0700, Jason Gunthorpe wrote:
> On Fri, Dec 08, 2017 at 12:14:04PM +0000, Alexander.Steffen@infineon.com wrote:
> 
> > Is it really that ugly? I still need delay_msec to increase the
> > delay each round. I can see the benefit of your suggestion when it
> > is important to get the timing exactly right (and also account for
> > time spent elsewhere, when our code might not be executing). But in
> > this case having delays that are approximately right (or longer than
> > intended) is sufficient.
> 
> For timeouts like this we really need to be above the TPM specified
> delay in all cases, even if usleep_range selected something
> smaller/larger.. The only way to do that is with an absolute timeout..
> 
> 
> > Anyway, from the log messages it is clear that tpm_msleep got called
> > seven times with delays of 20/40/80/160/320/640/1280ms. But still
> > all timestamps lie within the same second. How can this be with a
> > cumulated delay of ~2.5s?
> 
> Yes, that does seem to be the bug, our sleep function doesn't work
> aynmore for some reason :|
> 
> > Also, I've just noticed that despite the name tpm_msleep calls
> > usleep_range, not msleep. Can this have an influence? Should
> > tpm_msleep call msleep for longer delays, as suggested by
> > Documentation/timers/timers-howto.txt?
> 
> This change was introduced recently and is probably the source of this
> regression.

msleep() waited a lot longer than the requested time, causing long
delays.  Using usleep_range() still waits more than the requested
time, but less than msleep().

static inline void tpm_msleep(unsigned int delay_msec)
{
        usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
                     delay_msec * 1000);
};

Other TPM performance improvements have not yet been upstreamed.

Mimi
