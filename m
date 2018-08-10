Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48923 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeHJT5y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Aug 2018 15:57:54 -0400
Date: Fri, 10 Aug 2018 20:27:00 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: add ptr to the tpm_space struct to file_priv
Message-ID: <20180810172700.GU4692@linux.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
 <153367366462.18015.12915462188877575543.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153367366462.18015.12915462188877575543.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Aug 07, 2018 at 01:27:44PM -0700, Tadeusz Struk wrote:
> Add a ptr to struct tpm_space to the file_priv to have an easy
> access to it in the async job without the need to allocate memory.
> This also allows to consolidate of the write operations for
> the two interfaces.

I think the 2nd premise should be the priority and the first premise should
be removed as it is not needed in any possible way to justify the
change.

/Jarkko
