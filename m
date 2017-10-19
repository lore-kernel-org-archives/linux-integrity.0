Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25461 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdJSBN7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 21:13:59 -0400
Date: Thu, 19 Oct 2017 12:13:49 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for Linux 4.15
In-Reply-To: <20171018155749.q5sl6chmsr2cwu7n@linux.intel.com>
Message-ID: <alpine.LFD.2.20.1710191212390.780@t440.gateway.2wire.net>
References: <20171018155749.q5sl6chmsr2cwu7n@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 18 Oct 2017, Jarkko Sakkinen wrote:

> Hi
> 
> Contains mostly minor fixes.
> 
> Selected more essential changes:
> 
> * Essential clean up for tpm_crb so that ARM64 and x86 versions do not
>   distract each other as much as before.
> * /dev/tpm0 rejects now too short writes (shorter buffer than specified in
>   the command header.
> * Use DMA-safe buffer in tpm_tis_spi.
> 
> /Jarkko
> 
> The following changes since commit 25eabb13c7d67ae32298015c5e28d00f604f412c:
> 
>   Merge tag 'v4.14-rc2' into next-general (2017-09-24 22:41:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20171018


Thanks, merged to next-tpm and next-general in:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git


- James

-- 
James Morris
<james.l.morris@oracle.com>
