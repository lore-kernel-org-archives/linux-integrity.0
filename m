Return-Path: <SRS0=HrVK=65=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B44C433DF
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 02:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3631204EF
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 02:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEOCWt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 May 2020 22:22:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:36183 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOCWt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 22:22:49 -0400
IronPort-SDR: kZkT15ogDObAj1NHh25jkvOMwC+C52VRUdohvyo6kB76s4WL7I5t4Xb/UsEoZJbvLLshiawzeU
 CVHRdkbMoeIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 19:22:48 -0700
IronPort-SDR: mGDAQwmgSbW6o10lke2zLirzMqjyP/gWtjh+d1Mfdny2xD8fTt/P51zrIyIb8VEtka0C1AUPFk
 T3iXhaM5nejQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="298905452"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2020 19:22:46 -0700
Message-ID: <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 05:22:31 +0300
In-Reply-To: <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> I'm compiling now kernel with all series included.
> 
> Kind of checking if I could just take the whole series. Let see.
> 
> In all cases I want the style errors in 3/8 to be fixes with a helper
> but maybe better to hold before sending anything. Possibly that is all
> needed I'll just carve that patch myself.
> 
> Please don't do anything for the moment.

This is what I tried first (with the full series applied):

#!/bin/sh

die()
{
	keyctl clear @u
	./tpm2-flush --all-transient
	exit $1
}

KEYHANDLE=$(./tpm2-root-key || die 1)
KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE hash=sha256" @u || die 1)

echo "$KEYID ($KEYHANDLE)"

keyctl pipe $KEYID > blob.hex || die 1
keyctl clear @u || die 1

echo "Import key from blob"

keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u || die 1

die 0

Result:

sudo ./keyctl-smoke.sh
566201053 (0x80000000)
keyctl_read_alloc: Permission denied

Any ideas what I might have done wrong? Have not tried auth value yet
but afaik the above should fully test import and export.

Uses tpm2-scripts:

https://github.com/jsakkine-intel/tpm2-scripts

I'll probably move these to git.infradead.org because I don't like
really like at all Github and my kernel tree is there anyway.

/Jarkko

