Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:41716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbeIQAu6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 20:50:58 -0400
Date: Sun, 16 Sep 2018 22:26:56 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tstruk@gmail.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>, flihp@twobit.us,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tpm: add support for nonblocking operation
Message-ID: <20180916192656.GA9053@linux.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
 <20180916120349.GB5040@linux.intel.com>
 <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Sep 16, 2018 at 08:11:44AM -0700, Tadeusz Struk wrote:
> On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> > I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async
> 
> This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
> To enable it you need to configure tss with --enable-tcti-device-async=yes
> Thanks,
> Tadeusz

Thank you. Looking forward to try it out tomorrow.

/Jarkko
