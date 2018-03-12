Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55506 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeCLPCi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Mar 2018 11:02:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id q83so17276089wme.5
        for <linux-integrity@vger.kernel.org>; Mon, 12 Mar 2018 08:02:38 -0700 (PDT)
Date: Mon, 12 Mar 2018 09:02:32 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180312150231.GA24717@ziepe.ca>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.

The commit should explain why we'd want this..

eg Why does it matter to create the extra sysfs files to report an empty
log?

Jason
