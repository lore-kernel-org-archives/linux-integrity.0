Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44745 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdLUMqa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 07:46:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id t8so15682173wmc.3
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 04:46:30 -0800 (PST)
Subject: Re: [PATCH 0/4] tpm: fix PS/2 devices not working on Braswell systems
 due CLKRUN enabled
To: James Ettle <james@ettle.org.uk>, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
References: <20171220113538.16099-1-javierm@redhat.com>
 <5c098570-5aea-533c-c096-b5eb5ecc5c95@ettle.org.uk>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <225df7f0-2422-1c5a-f44e-96cfd3b24232@redhat.com>
Date: Thu, 21 Dec 2017 13:46:27 +0100
MIME-Version: 1.0
In-Reply-To: <5c098570-5aea-533c-c096-b5eb5ecc5c95@ettle.org.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello James,

On 12/21/2017 11:51 AM, James Ettle wrote:
> OK, I built a kernel based on:
> 
> - git clone of git.infradead.org/users/jjs/linux-tpmdd.git taken last night
> - applying the patch in https://patchwork.kernel.org/patch/10119417/

I meant linux-tpmdd + the 4 patches in this series.

> - stock config-4.14.6-300.fc27.x86_64 + make oldconfig
> 
> The tpm modules are loaded and the keyboard is working.
> 
> Note: I won't have access to this machine over the next few weeks.
> 

No worries, there shouldn't be any function changes anyways with the previous
patch shared in the other thread and the changes are quite simple so I think
it's OK.

Again thanks a lot for your help and merry Christmas / happy new year.

> Thanks,
> James.
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
