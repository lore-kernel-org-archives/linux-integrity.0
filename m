Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34625 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMSYI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 14:24:08 -0400
Received: by mail-wr1-f49.google.com with SMTP id g33-v6so5587109wrd.1
        for <linux-integrity@vger.kernel.org>; Thu, 13 Sep 2018 06:14:43 -0700 (PDT)
MIME-Version: 1.0
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Thu, 13 Sep 2018 10:14:30 -0300
Message-ID: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
Subject: Question about the TPM driver
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi all,

I noticed that, after a command is done, the TPM driver only allows
for a single read operation (for a limited time). If I wanted to e.g.
check a command's response code before attempting to read the rest of
the response, my next read would fail. Same happens if I take too long
to read a command's results.

I can understand the timeout, but I'm curious about this single-read
policy, especially since some commands such as GetCapability don't
guarantee how much data will actually be returned. Does anyone know
why it was implemented this way?

Thanks
