Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:57143 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdKKPpT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Nov 2017 10:45:19 -0500
Received: by mail-it0-f53.google.com with SMTP id r127so4862489itb.5
        for <linux-integrity@vger.kernel.org>; Sat, 11 Nov 2017 07:45:19 -0800 (PST)
Date: Sat, 11 Nov 2017 08:45:16 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Laurent Bigonville <bigon@debian.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171111154516.GI17451@ziepe.ca>
References: <20171023134515.56siz3m6lhrhnovv@rhwork>
 <20171024135123.uqail7olnespun4k@linux.intel.com>
 <20171024145706.na56ff34w5agzo2t@rhwork>
 <20171024160725.r6kj452jdzpkbb6o@linux.intel.com>
 <8f4df9a9-c8cd-832f-4c3f-5305fabab7a8@debian.org>
 <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 10, 2017 at 01:53:00PM -0700, Jerry Snitselaar wrote:

> I wonder if it is possible that the release locality from the probe
> isn't completing on the chip until after the request/check that
> happens at the beginning of the tpm_get_timeouts.  Perhaps we need
> something like wait_for_tpm_stat for the access register, and
> verifying that locality was released before returning out of
> release_locality?

This is not a bad guess.. Adding a largish delay after
release_locality might be interesting too.

Are we sure our tis request/release process is even right? Another
options is that the 'check if already in locality' doesn't work on
this chip, or isn't coded right...

Jason
