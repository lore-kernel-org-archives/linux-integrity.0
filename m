Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:52638 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbdJSLzz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 07:55:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id b190so9268361lfg.9
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 04:55:55 -0700 (PDT)
Date: Thu, 19 Oct 2017 14:55:52 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH] EVM: Add support for portable signature format
Message-ID: <20171019145552.36f309e6@totoro>
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
References: <20171018180111.13021-1-mjg59@google.com>
        <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Thu, 19 Oct 2017 11:02:51 +0000
Dmitry Kasatkin <dmitry.kasatkin@huawei.com> ?????:

> BTW.
> 
> Just to refresh my mind. What would be the correct order for setting
> this signature from package? On any attr/xattr change, EVM will set
> HMAC.

from tar's code:
- uid/git/mode/data/etc...
- all xattrs
- caps
- selinux
- EVM xattr

EVM xattr should be restored the last one, when all xattrs/metadata
already restored, but... as soon, as first protected xattr will be
restored from package, EVM HMAC will be generated.


> What is the value of setting signature after that unless there is a
> policy to require signature (immutable)? In my original patchset
> portable was also immutable and also included policy support to
> require EVM signatures.



-- 
Best regards,
Mikhail Kurinnoi
