Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52972 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbeIMTbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 15:31:55 -0400
Message-ID: <1536848529.3436.2.camel@HansenPartnership.com>
Subject: Re: Question about the TPM driver
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Martin Galvan <omgalvan.86@gmail.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Date: Thu, 13 Sep 2018 10:22:09 -0400
In-Reply-To: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-09-13 at 10:14 -0300, Martin Galvan wrote:
> Hi all,
> 
> I noticed that, after a command is done, the TPM driver only allows
> for a single read operation (for a limited time). If I wanted to e.g.
> check a command's response code before attempting to read the rest of
> the response, my next read would fail. Same happens if I take too
> long to read a command's results.
> 
> I can understand the timeout, but I'm curious about this single-read
> policy, especially since some commands such as GetCapability don't
> guarantee how much data will actually be returned. Does anyone know
> why it was implemented this way?

Internally the TPM has a single message buffer.  It can't be reused for
the next command until the last one is fully received.  For
efficiency's sake you should have a pending read as soon as the command
is sent so the return of the read tells you the TPM has finished and
the TPM can get on to the next user.  The timeout is merely a courtesy
for the case the command completes before you can queue a read.  It's
short by design otherwise you give users the ability to DoS the TPM.

Exact buffer size hasn't been thought to be an issue since you know
that any response will fit into MAX_RESPONSE_SIZE which the current
implementation defines to be 4096.

James
