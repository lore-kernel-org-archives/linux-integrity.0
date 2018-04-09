Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752596AbeDIOaI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Apr 2018 10:30:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w39EU7rR063726
        for <linux-integrity@vger.kernel.org>; Mon, 9 Apr 2018 10:30:07 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h86t99hu4-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Apr 2018 10:30:05 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 9 Apr 2018 15:30:03 +0100
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Date: Mon, 09 Apr 2018 10:29:58 -0400
In-Reply-To: <20180407103610.GA22542@linux.intel.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
         <20180405101210.GA21636@linux.intel.com>
         <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
         <20180407103610.GA22542@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523284198.16421.196.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-04-07 at 13:36 +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 06, 2018 at 02:03:37PM +0530, Nayna Jain wrote:
> > On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> > > On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> > > > Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> > > > handle the TPM2_RC_RETRY error. The loop retries the command after
> > > > sleeping for the specified time, which is incremented exponentially in
> > > > every iteration. This patch fixes the initial sleep to be the default
> > > > sleep time.
> > > I think I understand the code change but do not understand what the
> > > long description.
> > 
> > It tells that the first sleep is delay_msec * 2 and not delay_msec.
> 
> So the problem is that the loop doubles the time before sleeping
> for the first time. This is missing from the description. Please
> refine it in some way.

Sure, how about replacing the last line of the patch description with:
    Unfortunately, the loop doubles the time before sleeping, causing the
    initial sleep to be doubled.  This patch fixes the initial sleep time.

If this change is acceptable, do you want to make the change or should Nayna repost the patch?

thanks,

Mimi
