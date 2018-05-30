Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:57820 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932091AbeE3XzJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 19:55:09 -0400
Date: Thu, 31 May 2018 09:55:00 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: Tadeusz Struk <tadeusz.struk@intel.com>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix race condition in tpm_common_write()
In-Reply-To: <20180530205438.GA27912@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1805310954060.15212@namei.org>
References: <152702503883.25871.17829919385428251068.stgit@tstruk-mobl1.jf.intel.com> <20180523135003.GG363@linux.intel.com> <20180530171315.GA23184@linux.intel.com> <20180530205438.GA27912@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 30 May 2018, Jarkko Sakkinen wrote:

> Should I make a follow up PR for 4.18 with only this fix included?

What about for current -rc?

-- 
James Morris
<jmorris@namei.org>
