Return-Path: <SRS0=mfW3=B5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2774C433E1
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Aug 2020 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8459207DE
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Aug 2020 21:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHSVxg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:53:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:44132 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHSVxg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 17:53:36 -0400
IronPort-SDR: TlXrS0ydSYt4PDAuFZ2vM36TjSTO1/OV8m177OiUNdlMy/ijZgHjpx1t0KpLedtNRI+JropvRo
 B6VD4OykFm0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="155174000"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="155174000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:53:35 -0700
IronPort-SDR: VthLa+/XxyY0rKKYAV2WFC8niqi1SKbXzCClajSp3R6ZLgUnlaP7x3MR21yNinjKp9bHYZCyIQ
 I9XDD6nUUoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="472396506"
Received: from pbooyens-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2020 14:53:33 -0700
Date:   Thu, 20 Aug 2020 00:53:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819215332.GI9942@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <1597769070.3898.36.camel@HansenPartnership.com>
 <20200818171712.GZ24045@ziepe.ca>
 <1597776566.3898.52.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597776566.3898.52.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Tue, 2020-08-18 at 14:17 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:
> > 
> > > The question you should be asking isn't whether the information
> > > *could*
> > > be obtained by other means, but whether providing it in this form
> > > facilitates current operations and whether the interface would have
> > > users.
> > 
> > Sure. What are the use cases that need PCRs but no other TPM
> > operations?
> > 
> > The cover letter didn't say. As PCR is really only useful in the
> > context of the local TPM I'm not thinking of anything..
> 
> The three use cases I picked up at the Boot and Security MC were:
> 
>    1. local log verification: a script can run through the IMA ascii log
>       and construct the PCR 10 hash which can then be verified
>    2. Knowing what the PCR values actually are for sealed keys.  With the
>       current trusted key infrastructure you have to calculate and supply
>       the hash yourself.  With the new proposed infrastructure, the hash
>       would be calculated by the seal operation, but you're still going to
>       need the actual PCR values to debug unseal failures.
>    3. As a stability check for log shipping: you read the PCR take the log
>       then read the PCR: if the two reads are the same the PCR backing the
>       log is stable for quoting.
> 
> James

The proposed sysfs attributes are racy in the sense that PCRs could
change in-between reading different hashes.

A blob containing all the hashes would make more sense as it does not
have this issue.

If this is for scripts to further process, it is also more efficient
than printable ASCII text.

/Jarkko
