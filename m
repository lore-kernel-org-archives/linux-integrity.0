Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50166 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeIJWSo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Sep 2018 18:18:44 -0400
Subject: Re: [PATCH v5 0/2] tpm: add support for nonblocking operation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <20180831085711.GC12908@linux.intel.com>
 <20180831085825.GD12908@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <67bab063-e24d-461c-dacb-5c9458ef9784@intel.com>
Date: Mon, 10 Sep 2018 10:23:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180831085825.GD12908@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 08/31/2018 01:58 AM, Jarkko Sakkinen wrote:
> Just the change to the commit message. Mislooked patchwork, the typo was
> in my response :-) I'll do recheck for 2/2. Check those comments before
> v6 if there is anything else.

Hi,
I have done the changes you requested and ran the "checkpatch.pl --strict"
on it and it says that "no obvious style problems and is ready for submission".
Thanks,
-- 
Tadeusz
