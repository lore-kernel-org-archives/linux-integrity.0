Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4266DC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65320842
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkBn52rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfBYVDG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:03:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44331 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfBYVDG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 16:03:06 -0500
Received: by mail-io1-f68.google.com with SMTP id y13so8679495iop.11
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwIF9qmsOZVscXTDjDhUtAl0PzCd9Hmo/yZ4GbPHgqE=;
        b=SkBn52rjgjy3jw5VsOgEMVjtTizGRx0P2s95EymW7heDhWDLXzhbqdpq6qdQ5ZAv6E
         Ynphn9uTQSIEgdv8/OL7+ai3QSmH+GYP8Eu18qNWl5+sieTQSst3UXjEJLEOAiYOxaWT
         SZR5h3wV/f9mRbx/TpDcAthSouzzeWeDiD7j2wLFibYDQMHj/8Ga03zB8CuGCC6q/vZr
         fZ27lyWiTMLZu8eqDzOxqhInrE+g7gjF6bLP9cdhkCPfSMRoiH34JGIpHjtvkEwU0VTB
         M/0VlA62DUIuSMgYSNIxjrWXJjnmoHYbcBZp3rlJYSbBJqeQauZtadBsUAqiTqwjddl5
         CKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwIF9qmsOZVscXTDjDhUtAl0PzCd9Hmo/yZ4GbPHgqE=;
        b=ZgGfCCdG9UVWgl19mNv+5cUINTFTSc/IQTwPHThiSSB7MptDJjUtELX0kos57LUffu
         WWbARS4vYoN6rJ5I89gYVThSjjGEM5Wa++S98IPpYgX6pXb7KJ+fA/m+9+1QSLwVCGfP
         aNzR0eDhrilR4YS3OwBHNlExDj5Tnls2veIjsCoIxdQ5olBXaKcMaUOqkgjstu76Udhv
         Bk4L1QFOatGniUCY+wQdw5SOzDScoHa0jhiJiKbuP8IWOJ2Om2LM4QIC643hBX6oyGrn
         qhmXU2F2voaTpcAnF+LDI9+eZixMVno8njpy1DAX2ZtDSQrh0nDD7cJSrTl0G5+fiDyA
         faPQ==
X-Gm-Message-State: AHQUAuZrfSrFZz4jvtRpuJkn/W6uMlw08XcsMER/6u5ChRPSGDKTpciM
        n1f/Fyk64gC7bwZdHyz+IXU0Q3jtzZFxHDAk29H+kQ==
X-Google-Smtp-Source: AHgI3IY/QxLL3oa99jdtLtKQkMUZWc5jBFihAyhAc4N4pv93yHPYWy7ntoGQGuwoVAvT4ho0isAJmRIDwHf96yNQ13g=
X-Received: by 2002:a5e:dc4c:: with SMTP id s12mr1929234iop.304.1551128584851;
 Mon, 25 Feb 2019 13:03:04 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com> <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com> <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
In-Reply-To: <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 13:02:53 -0800
Message-ID: <CACdnJutzRur52hbJ_Ckm64RPfuv5MrMBY3OwO1yM+QC8Ax_Rvw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 25, 2019 at 1:00 PM Matthew Garrett <mjg59@google.com> wrote:
> > I'm still looking for the pragmatic use case.  I think yours is attack
> > surface reduction, because the virtio discovery and operation is less
> > code and therefore more secure than physical hardware discovery and
> > operation?  I'm not entirely sure I buy that because the TPM
> > communication interface is pretty simple and it's fairly deep down in
> > the kernel internal stack making it difficult to exploit.
>
> Being able to get away without any LPC support code at all seems like
> a win, as does not having any ACPI or DeviceTree parsing code.
> Injecting the hardware information via the kernel command line isn't
> impossible, but it's not an attractive solution.

Oh, but to be clear - I think the bigger win is having a reduced
surface in the *hypervisor*, not the kernel. Just having enough
support to pass commands through to the vTPM is a lot easier than
emulating the whole hardware interface to the TPM (and see the number
of bugs in things like qemu's floppy drive emulation as an example of
how hard this can be to get right)
