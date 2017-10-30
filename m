Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:46982 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdJ3K3Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 06:29:16 -0400
Received: by mail-io0-f179.google.com with SMTP id 101so25987932ioj.3
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 03:29:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPVaeBk3C-jz3bQpJ01+H0=0nDc71hnu79aNwR9Ga5AeaCiPpQ@mail.gmail.com>
References: <CAPVaeBk3C-jz3bQpJ01+H0=0nDc71hnu79aNwR9Ga5AeaCiPpQ@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 10:29:14 +0000
Message-ID: <CACdnJuuSuEsoRmbsPmMYXSGjQS=+cuOcCyZDRgU=7CJkXONGYg@mail.gmail.com>
Subject: Re: Usage of inode number in EVM signatures
To: "Peter P." <p.pan48711@gmail.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Oct 27, 2017 at 4:08 PM, Peter P. <p.pan48711@gmail.com> wrote:
> Hi,
>
> I would like to better understand how the inclusion of the inode
> number and the other return values from stat add to the protection of
> the xattrs when security.evm contains a digital signature.
>
> If any of the security xattrs are tampered with, then I would expect
> EVM signature verification will fail. What added protections does one
> gain by including file information?

There's no real security advantage as long as IMA is in use. However,
EVM can be used without IMA, and in that case you'd end up with
signatures that could be moved between files. See the discussion of
the portable signature format going on at the moment.
