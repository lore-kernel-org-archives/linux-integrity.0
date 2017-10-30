Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:44720 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdJ3OEN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 10:04:13 -0400
Received: by mail-io0-f179.google.com with SMTP id m16so27378887iod.1
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 07:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509371927.3583.87.camel@linux.vnet.ibm.com>
References: <20171026083144.16247-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C4718F@FRAEML521-MBX.china.huawei.com>
 <1509366611.3583.65.camel@linux.vnet.ibm.com> <CACdnJuvz3RHG-asaN8NiJ=3uz-EH9CRAoc+kwG0gL+ChjJ64FQ@mail.gmail.com>
 <1509371927.3583.87.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 14:04:11 +0000
Message-ID: <CACdnJusKZWBkutyjd+pZKqkk95BH515QGd6jxrHNv5=pWaYqyA@mail.gmail.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 30, 2017 at 1:58 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> We're discussing setattr, not setxattr here.  Any file metadata change
> (eg. chmod, chown, etc) will result in the file signature being
> converted to an HMAC.

Gah. Sorry, you're completely correct. Ok, I'll think about the best
way to approach this.
