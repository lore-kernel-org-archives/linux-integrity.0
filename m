Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:45685 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeCVVjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 17:39:41 -0400
Received: by mail-wr0-f169.google.com with SMTP id h2so10169443wre.12
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 14:39:41 -0700 (PDT)
Date: Thu, 22 Mar 2018 15:39:37 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: A subtle problem when resuming xen-front and using IMA and
 multiple TPM devices on the system
Message-ID: <20180322213937.GF9469@ziepe.ca>
References: <28f8dc8a-cfa3-376a-5e6a-98d79418e3d1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28f8dc8a-cfa3-376a-5e6a-98d79418e3d1@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 22, 2018 at 12:20:33PM -0400, Stefan Berger wrote:
> I tried to convert the IMA code to look up a TPM chip and use it until
> shutdown, when it releases it before device_shutdown(). Ideally this would
> work but because of xen-front's resume code it doesn't. There the chip is
> unregistered upon domU resume (tpmfront_resume calls tpmfron_remove) and for
> that reason IMA cannot be holding onto that chip until shutdown.

Well removing the TPM during resume seems totally wrong, don't do
that.

Jason
