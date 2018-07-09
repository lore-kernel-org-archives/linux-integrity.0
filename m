Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932764AbeGITlo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jul 2018 15:41:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69JdL19087496
        for <linux-integrity@vger.kernel.org>; Mon, 9 Jul 2018 15:41:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4d2pbqcn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Jul 2018 15:41:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 9 Jul 2018 20:41:41 +0100
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 09 Jul 2018 15:41:34 -0400
In-Reply-To: <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
         <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1531165294.3332.40.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Some systems are memory constrained but they need to load very large
> > firmwares.  The firmware subsystem allows drivers to request this
> > firmware be loaded from the filesystem, but this requires that the
> > entire firmware be loaded into kernel memory first before it's provided
> > to the driver.  This can lead to a situation where we map the firmware
> > twice, once to load the firmware into kernel memory and once to copy the
> > firmware into the final resting place.
> >
> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
> > that allows drivers to request firmware be loaded directly into a
> > pre-allocated buffer. (Based on the mailing list discussions, calling
> > dma_alloc_coherent() is unnecessary and confusing.)
> >
> > (Very broken/buggy) devices using pre-allocated memory run the risk of
> > the firmware being accessible to the device prior to the completion of
> > IMA's signature verification.  For the time being, this patch emits a
> > warning, but does not prevent the loading of the firmware.
> >
> 
> As I attempted to explain in the exchange with Luis, this has nothing
> to do with broken or buggy devices, but is simply the reality we have
> to deal with on platforms that lack IOMMUs.

> Even if you load into one buffer, carry out the signature verification
> and *only then* copy it to another buffer, a bus master could
> potentially read it from the first buffer as well. Mapping for DMA
> does *not* mean 'making the memory readable by the device' unless
> IOMMUs are being used. Otherwise, a bus master can read it from the
> first buffer, or even patch the code that performs the security check
> in the first place. For such platforms, copying the data around to
> prevent the device from reading it is simply pointless, as well as any
> other mitigation in software to protect yourself from misbehaving bus
> masters.

Thank you for taking the time to explain this again.

> So issuing a warning in this particular case is rather arbitrary. On
> these platforms, all bus masters can read (and modify) all of your
> memory all of the time, and as long as the firmware loader code takes
> care not to provide the DMA address to the device until after the
> verification is complete, it really has done all it reasonably can in
> the environment that it is expected to operate in.

So for the non-IOMMU system case, differentiating between pre-
allocated buffers vs. using two buffers doesn't make sense.

> 
> (The use of dma_alloc_coherent() is a bit of a red herring here, as it
> incorporates the DMA map operation. However, DMA map is a no-op on
> systems with cache coherent 1:1 DMA [iow, all PCs and most arm64
> platforms unless they have IOMMUs], and so there is not much
> difference between memory allocated with kmalloc() or with
> dma_alloc_coherent() in terms of whether the device can access it
> freely)
  
What about systems with an IOMMU?

Mimi
