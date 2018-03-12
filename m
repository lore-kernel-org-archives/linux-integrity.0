Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLLJK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 07:09:10 -0400
Date: Mon, 12 Mar 2018 13:09:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180312110907.GA7448@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already applied to my master (bleeding edge) branch in order to
facilitate testing:

git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
