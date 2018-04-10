Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751505AbeDJP4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 11:56:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3AFrEgY091064
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 11:56:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h8wtd8pgx-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 11:56:10 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 10 Apr 2018 16:56:08 +0100
Subject: Re: [RFC PATCH v2 1/4] security/ima: Rewrite tests into new API +
 fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Tue, 10 Apr 2018 11:56:04 -0400
In-Reply-To: <20180329085947.hns5mhwu3co2tkox@dell5510>
References: <20180314155731.5943-1-pvorel@suse.cz>
         <20180314155731.5943-2-pvorel@suse.cz>
         <1522177951.3541.180.camel@linux.vnet.ibm.com>
         <20180329085947.hns5mhwu3co2tkox@dell5510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523375764.5268.12.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-29 at 10:59 +0200, Petr Vorel wrote:
> Hi Mimi,

> > >  load_policy()
> ...
> > >  	cat $1 |
> > > -	while read line ; do
> > > -	{
> > > -		if [ "${line#\#}" = "${line}" ] ; then
> > > -			echo $line >&4 2> /dev/null
> > > +	while read line; do
> > > +		if [ "${line#\#}" = "${line}" ]; then
> > > +			echo "$line" >&4 2> /dev/null
> > >  			if [ $? -ne 0 ]; then
> > >  				exec 4>&-
> > >  				return 1
> > >  			fi
> > >  		fi
> > > -	}
> 
> > Originally writing the policy was done one rule at a time, but hasn't
> > been required for a long time.  dracut and systemd 'cat' the policy
> > directly to the pseudo file.
> OK, let's simplify it to catting the content.

Replacing the builtin policy with a new policy in the initramfs was
considered safe.  With commit 38d859f991f3 ("IMA: policy can now be
updated multiple times") the policy can be extended multiple times,
not only from the initramfs.  For it to be safe to extend the IMA
policy (eg. CONFIG_IMA_WRITE_POLICY), the policy must be signed.

These tests assume the policy does not need to be signed.

Mimi
