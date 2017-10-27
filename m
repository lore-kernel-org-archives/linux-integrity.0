Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:53127 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdJ0PIG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2017 11:08:06 -0400
Received: by mail-yw0-f170.google.com with SMTP id w2so5984684ywa.9
        for <linux-integrity@vger.kernel.org>; Fri, 27 Oct 2017 08:08:06 -0700 (PDT)
MIME-Version: 1.0
From: "Peter P." <p.pan48711@gmail.com>
Date: Fri, 27 Oct 2017 11:08:05 -0400
Message-ID: <CAPVaeBk3C-jz3bQpJ01+H0=0nDc71hnu79aNwR9Ga5AeaCiPpQ@mail.gmail.com>
Subject: Usage of inode number in EVM signatures
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I would like to better understand how the inclusion of the inode
number and the other return values from stat add to the protection of
the xattrs when security.evm contains a digital signature.

If any of the security xattrs are tampered with, then I would expect
EVM signature verification will fail. What added protections does one
gain by including file information?

Thank you,

Peter
