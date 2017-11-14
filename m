Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:51893 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdKNCpU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 21:45:20 -0500
Received: by mail-it0-f54.google.com with SMTP id x28so6230731ita.0
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 18:45:20 -0800 (PST)
Date: Mon, 13 Nov 2017 19:45:16 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Laurent Bigonville <bigon@debian.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171114024516.GL22610@ziepe.ca>
References: <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca>
 <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca>
 <20171111203132.hkejjs6cdrrzq3y3@cantor>
 <06586f6e-cb43-6fa0-a8b4-cdc34ea90dfc@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06586f6e-cb43-6fa0-a8b4-cdc34ea90dfc@debian.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 14, 2017 at 01:26:16AM +0100, Laurent Bigonville wrote:

> I don't know if it's relevant, I was looking at the different tpm_* tools
> and tpm_nvinfo is giving me errors with 4.9:

This looks like good communication with the chip to me, just the chip
refusing to run the command for whatever reason?

Jason
