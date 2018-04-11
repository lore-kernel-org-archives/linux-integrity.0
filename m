Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757092AbeDKUDj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Apr 2018 16:03:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3BK0p5a102889
        for <linux-integrity@vger.kernel.org>; Wed, 11 Apr 2018 16:03:39 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h9p3tqj18-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Apr 2018 16:03:38 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 11 Apr 2018 21:03:36 +0100
Subject: Re: [RFC PATCH v2 1/4] security/ima: Rewrite tests into new API +
 fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Wed, 11 Apr 2018 16:03:33 -0400
In-Reply-To: <20180411190335.GB25859@x230>
References: <20180314155731.5943-1-pvorel@suse.cz>
         <20180314155731.5943-2-pvorel@suse.cz>
         <1522177951.3541.180.camel@linux.vnet.ibm.com>
         <20180329085947.hns5mhwu3co2tkox@dell5510>
         <1523375764.5268.12.camel@linux.vnet.ibm.com> <20180411190335.GB25859@x230>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523477013.5268.72.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-04-11 at 21:03 +0200, Petr Vorel wrote:
> Hi Mimi,
> > > > >  load_policy()
> > > ...
> > > > >  	cat $1 |
> > > > > -	while read line ; do
> > > > > -	{
> > > > > -		if [ "${line#\#}" = "${line}" ] ; then
> > > > > -			echo $line >&4 2> /dev/null
> > > > > +	while read line; do
> > > > > +		if [ "${line#\#}" = "${line}" ]; then
> > > > > +			echo "$line" >&4 2> /dev/null
> > > > >  			if [ $? -ne 0 ]; then
> > > > >  				exec 4>&-
> > > > >  				return 1
> > > > >  			fi
> > > > >  		fi
> > > > > -	}
> 
> > > > Originally writing the policy was done one rule at a time, but hasn't
> > > > been required for a long time.  dracut and systemd 'cat' the policy
> > > > directly to the pseudo file.
> > > OK, let's simplify it to catting the content.
> 
> > Replacing the builtin policy with a new policy in the initramfs was
> > considered safe.  With commit 38d859f991f3 ("IMA: policy can now be
> > updated multiple times") the policy can be extended multiple times,
> > not only from the initramfs.  For it to be safe to extend the IMA
> > policy (eg. CONFIG_IMA_WRITE_POLICY), the policy must be signed.
> 
> > These tests assume the policy does not need to be signed.

> Is it a good idea to expect that policy must be signed also for older kernels
> (kernels before 4.5)?

The ability to sign the policy file was introduced with commit 7429b09
("ima: load policy using path").  According to "git branch --
contains", it was upstreamed in linux-4.6.

Mimi
