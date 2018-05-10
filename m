Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:60140 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757277AbeEJSNu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 14:13:50 -0400
Date: Fri, 11 May 2018 04:13:47 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Matthew Garrett <mjg59@google.com>
cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Subject: Re: [PATCH V4 1/2] EVM: turn evm_config_xattrnames into a list
In-Reply-To: <20180509202811.29875-1-mjg59@google.com>
Message-ID: <alpine.LRH.2.21.1805110413280.1003@namei.org>
References: <20180509202811.29875-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 9 May 2018, Matthew Garrett wrote:

> Use a list of xattrs rather than an array - this makes it easier to
> extend the list at runtime.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/evm/evm.h        |  7 ++-
>  security/integrity/evm/evm_crypto.c | 10 ++--
>  security/integrity/evm/evm_main.c   | 72 +++++++++++++++++++----------
>  3 files changed, 59 insertions(+), 30 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>
