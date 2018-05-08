Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEHKri (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 06:47:38 -0400
Date: Tue, 8 May 2018 13:47:36 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180508104736.GA6132@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180504130022.5231-3-david.bild@xaptum.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
> Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
> for performing initialization of the TPM.  For these modules, the host
> kernel is the platform, so we perform the initialization in the driver
> before registering the TPM with the kernel TPM subsystem.
> 
> The initialization consists of issuing the TPM startup command,
> running the TPM self-test, and setting the TPM platform hierarchy
> authorization to a random, unsaved value so that it can never be used
> after the driver has loaded.
> 
> Signed-off-by: David R. Bild <david.bild@xaptum.com>

Have you checked what the TPM driver already does?

/Jarkko
