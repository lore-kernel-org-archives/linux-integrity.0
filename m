Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12891 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeCESBv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 13:01:51 -0500
Date: Mon, 5 Mar 2018 20:01:44 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and
 recv() in tpm_transmit()
Message-ID: <20180305180144.GE5791@linux.intel.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
 <20180301092222.GC29420@linux.intel.com>
 <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
 <20180305105633.GE25377@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180305105633.GE25377@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:56:33PM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 02, 2018 at 12:26:35AM +0530, Nayna Jain wrote:
> > 
> > 
> > On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> > > On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> > > > In tpm_transmit, after send(), the code checks for status in a loop
> > > Maybe cutting hairs now but please just use the actual function name
> > > instead of send(). Just makes the commit log more useful asset.
> > Sure, will do.
> > > 
> > > > -		tpm_msleep(TPM_TIMEOUT);
> > > > +		tpm_msleep(TPM_TIMEOUT_POLL);
> > > What about just calling schedule()?
> > I'm not sure what you mean by "schedule()".  Are you suggesting instead of
> > using usleep_range(),  using something with an even finer grain construct?
> > 
> > Thanks & Regards,
> >      - Nayna
> 
> kernel/sched/core.c

The question I'm trying ask to is: is it better to sleep such a short
time or just ask scheduler to schedule something else after each
iteration?

/Jarkko
