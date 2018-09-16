Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbeIQAkK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 20:40:10 -0400
Date: Sun, 16 Sep 2018 22:16:05 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Martin Galvan <omgalvan.86@gmail.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: Question about the TPM driver
Message-ID: <20180916191605.GB7473@linux.intel.com>
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 13, 2018 at 10:14:30AM -0300, Martin Galvan wrote:
> Hi all,
> 
> I noticed that, after a command is done, the TPM driver only allows
> for a single read operation (for a limited time). If I wanted to e.g.
> check a command's response code before attempting to read the rest of
> the response, my next read would fail. Same happens if I take too long
> to read a command's results.
> 
> I can understand the timeout, but I'm curious about this single-read
> policy, especially since some commands such as GetCapability don't
> guarantee how much data will actually be returned. Does anyone know
> why it was implemented this way?
> 
> Thanks

I understand your concerns but without a concrete workload there is no
problem with this behavior.

/Jarkko
