Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:60148 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935403AbeEJSOW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 14:14:22 -0400
Date: Fri, 11 May 2018 04:14:20 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Matthew Garrett <mjg59@google.com>
cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Subject: Re: [PATCH V4 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
In-Reply-To: <20180509202811.29875-2-mjg59@google.com>
Message-ID: <alpine.LRH.2.21.1805110413500.1003@namei.org>
References: <20180509202811.29875-1-mjg59@google.com> <20180509202811.29875-2-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 9 May 2018, Matthew Garrett wrote:

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
>  Updated to add support for locking down the list, and also to forbid adding
>  the same xattr twice.
> 
>  Documentation/ABI/testing/evm       |  13 +++
>  security/integrity/evm/Kconfig      |  11 ++
>  security/integrity/evm/evm_crypto.c |   2 +-
>  security/integrity/evm/evm_main.c   |   6 +-
>  security/integrity/evm/evm_secfs.c  | 153 ++++++++++++++++++++++++++--
>  5 files changed, 175 insertions(+), 10 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>
