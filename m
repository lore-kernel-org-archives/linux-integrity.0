Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37092 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbdKTSCO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 13:02:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id k61so8883843wrc.4
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 10:02:13 -0800 (PST)
Date: Mon, 20 Nov 2017 11:02:04 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171120180204.GA29075@ziepe.ca>
References: <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
 <20171117235526.GX4276@ziepe.ca>
 <f77f3fa3-94ed-40fe-228b-b24dd5539754@redhat.com>
 <20171119152721.GY4276@ziepe.ca>
 <36e9ad69-225b-ca2b-7047-d188a50b1438@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BF41F@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC563F4BF41F@ORSMSX115.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 04:14:41PM +0000, Roberts, William C wrote:

> That's policy, and shouldn't be hardcoded in the kernel. Let the DAC
> permission model And LSMs sort that out.

Of course this is what was done, there are two cdevs, one with full
access to the TPM and one that runs through the RM.

The distro/admin gets to choose how to set the up, as is typical.

One of the use models for the RM cdev was to support unpriv access to
that cdev, if the admin chooses to grant access to the /dev/ node.

That work isn't quite complete, as it was envisioned to include kind of
user space controlled command filter/restriction.

Safe unpriv access is explicitly not a design goal of /dev/tpmX.

Jason
