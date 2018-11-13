Return-Path: <SRS0=mv0F=NY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC1C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Nov 2018 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E572086B
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Nov 2018 15:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E572086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeKNBoc (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:44:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:56693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKNBoc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Nov 2018 20:44:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 07:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="99910896"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga003.jf.intel.com with ESMTP; 13 Nov 2018 07:45:49 -0800
Date:   Tue, 13 Nov 2018 17:45:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Kenneth Goldman <kgoldman@us.ibm.com>
Subject: Re: [PATCH] Apply on top of: tpm: dynamically allocate active_banks
 array
Message-ID: <20181113154547.GA4601@linux.intel.com>
References: <20181109092925.2908-1-roberto.sassu@huawei.com>
 <1d2e39fe-4bfb-4644-d216-f962c168668e@linux.ibm.com>
 <82565c56-d3a3-ac15-4345-7e19b90fabf1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82565c56-d3a3-ac15-4345-7e19b90fabf1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 13, 2018 at 10:49:31AM +0100, Roberto Sassu wrote:
> On 11/12/2018 7:09 PM, Nayna Jain wrote:
> > 
> > 
> > On 11/09/2018 02:59 PM, Roberto Sassu wrote:
> > > This patch checks if a PCR bank is active (at least one bit in the
> > > pcr_select mask is set).
> > > ---
> > >   drivers/char/tpm/tpm2-cmd.c | 44 +++++++++++++++++++++++++++----------
> > >   1 file changed, 32 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > > index 533089cede07..eba8f8d00a09 100644
> > > --- a/drivers/char/tpm/tpm2-cmd.c
> > > +++ b/drivers/char/tpm/tpm2-cmd.c
> > > @@ -854,15 +854,20 @@ struct tpm2_pcr_selection {
> > >   static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> > >   {
> > > -    struct tpm2_pcr_selection pcr_selection;
> > > +    struct tpm2_pcr_selection *pcr_selection;
> > >       struct tpm_buf buf;
> > >       void *marker;
> > >       void *end;
> > >       void *pcr_select_offset;
> > >       u32 sizeof_pcr_selection;
> > > +    u32 nr_possible_banks;
> > > +    u32 nr_active_banks = 0;
> > 
> > The TCG Spec uses the term "allocated" and not "active".  For
> > consistency, I think we can also use the term "allocated". For example -
> > nr_allocated_banks and *allocated_banks both here and in struct
> > tpm_chip.
> > 
> > Sorry, it took me sometime to be clear on this else would have mentioned
> > previously.
> 
> Thanks. Jarkko?
> 
> Roberto

Agree with Nayna.

/Jarkko
