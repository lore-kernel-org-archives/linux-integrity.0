Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41799 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeEaUIA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 16:08:00 -0400
Received: by mail-io0-f193.google.com with SMTP id t5-v6so14597641ioa.8
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 13:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
 <20180530202804.148245-1-mjg59@google.com> <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
 <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com> <1527796502.3427.46.camel@linux.vnet.ibm.com>
In-Reply-To: <1527796502.3427.46.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 31 May 2018 13:07:48 -0700
Message-ID: <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: wangjunwen@baidu.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 31, 2018 at 12:55 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> On Thu, 2018-05-31 at 12:30 -0700, Matthew Garrett wrote:
> > Cool. Mimi, does this satisfy your concerns with the non-SHA1 patch?
>
> This should be posted as a separate patch, with the appropriate
> "Fixes" commit info.  It requires an ack from Herbert Xu.

The non-sha1 patch doesn't seem to be in -next at the moment - should
I wait for you to merge that so I can add the fixes tag?
