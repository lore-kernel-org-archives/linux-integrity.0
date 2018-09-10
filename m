Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:56425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeIJXjw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Sep 2018 19:39:52 -0400
Date: Mon, 10 Sep 2018 21:44:16 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] tpm: add ptr to the tpm_space struct to file_priv
Message-ID: <20180910184416.GD20225@linux.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
 <153659990801.2284.8342428711970626698.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153659990801.2284.8342428711970626698.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 10, 2018 at 10:18:28AM -0700, Tadeusz Struk wrote:
> Add a ptr to struct tpm_space to the file_priv and consolidate
> of the write operations for the two interfaces.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.om>

/Jarkko
