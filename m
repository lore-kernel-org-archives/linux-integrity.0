Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:38285 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbdJSPLk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 11:11:40 -0400
From: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: Mikhail Kurinnoi <viewizard@viewizard.com>
Subject: RE: [PATCH] EVM: Add support for portable signature format
Date: Thu, 19 Oct 2017 15:11:33 +0000
Message-ID: <C2D7A727C393B644B70DF4B4DCFB60B921C44F66@FRAEML521-MBX.china.huawei.com>
References: <20171018180111.13021-1-mjg59@google.com>
         <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>,<1508414402.4510.117.camel@linux.vnet.ibm.com>
In-Reply-To: <1508414402.4510.117.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

1. I do not get the idea...

> ship EVM signatures in packages

System up and running EVM without hmac?
How it creates new files without hmac?

2. Mathew's patch is about portable signatures... not immutable

And I do not get idea why they are needed if they replaced by HMAC.
Practically file gets HMAC, then signature is set, and then replaced with HMAC

Dmitry

________________________________________
From: Mimi Zohar [zohar@linux.vnet.ibm.com]
Sent: Thursday, October 19, 2017 3:00 PM
To: Dmitry Kasatkin; Matthew Garrett; linux-integrity@vger.kernel.org
Cc: Mikhail Kurinnoi
Subject: Re: [PATCH] EVM: Add support for portable signature format

On Thu, 2017-10-19 at 11:02 +0000, Dmitry Kasatkin wrote:
> BTW.
>
> Just to refresh my mind. What would be the correct order for setting
> this signature from package?
> On any attr/xattr change, EVM will set HMAC.

The system is running without an EVM symmetric key, just an asymmetric
key.

> What is the value of setting signature after that unless there is a
> policy to require signature (immutable)?

> In my original patchset portable was also immutable and also
> included policy support to require EVM signatures.

In Matthew's usecase scenario, only immutable and portable signatures
exist.  The EVM verification for unsigned files will be
INTEGRITY_UNKNOWN.

Mimi
