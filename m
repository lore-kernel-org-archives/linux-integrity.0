Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44684 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdKUS7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 13:59:02 -0500
Received: by mail-wr0-f194.google.com with SMTP id l22so12224000wrc.11
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 10:59:01 -0800 (PST)
Date: Tue, 21 Nov 2017 11:58:56 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171121185856.GG18272@ziepe.ca>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
 <20171120231728.GR29075@ziepe.ca>
 <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
 <20171121182858.GA4895@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171121182858.GA4895@roeck-us.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 10:28:58AM -0800, Guenter Roeck wrote:

> I'll split the patch into two parts, and only add (hopefully)
> non-controversial tpm2 attributes for now (which I think is durations
> and timeouts). Or, in other words, I'll split the attributes into
> two groups - one generic and one for tpm1.

Ok. Please look at new attributes you wish to add for tpm2 and see if
they meet the modern sysfs sensibility of one value per file, etc.

Jason
