Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBHZM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:25:12 -0400
Date: Tue, 2 Oct 2018 03:44:40 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Message-ID: <20181002004440.GE23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:14AM +0300, Tomas Winkler wrote:
> This patch series provides initial separation of tpm 1.x and tpm 2.x
> commands, in foresight that the tpm 1.x chips will eventually phase out
> and can be compiled out for modern systems.
>  A new file is added tpm1-cmd.c that contains tpm 1.x specific commands.
> In addition, tpm 1.x commands are now implemented using tpm_buf
> structure and instead of tpm_cmd_t construct. The latter is now removed.
> 
> Note: my tpm 1.x HW availability is limited hence some more testing is needed.
> 
> This series also contains two trivial cleanups and addition of new
> commands by TCG spec 1.36, now supported on new Intet's platforms.

Would be nice if the change log was here and not scattered into
patches.

/Jarkko
