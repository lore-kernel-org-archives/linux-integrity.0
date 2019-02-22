Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D5BC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 19:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D90920700
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 19:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx0ThaoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfBVTYd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:24:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42291 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTYc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 14:24:32 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so2626610iod.9
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r11V34qQwIIuk2RAAExLMxeBQnb9jBurmUiEhxLRnX0=;
        b=Gx0ThaoHbXT/I4dMiUL/y6NKDS556QBD41380GjAv9KjRPgt8uLDQ8nilV0t4seGGC
         BQYzthrB1rytrag6bor2GvmqzyKNZkfvA2vzk/BmcEFP0d73Xtmtfzxb4Qpjkt32cT1G
         g+vI3WdW52ERYNzxtx3bOn1DJ1ejuycICOzSX5VtLGRf7Flzhm9OeKSzahCDmR7833qg
         t2c8WGhj65BvUx39Q3k3FY6j4//wukAlpSJ+55o5MA4nruWLp01u/PZxXwT8g/Y6X0b8
         HI3oOaHHjnjOOjkPrVVSKNEFNgZ6zivEw7VL/hoCHy4shv1Yc1d60qdkB4IQ6YkyJvOh
         96ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r11V34qQwIIuk2RAAExLMxeBQnb9jBurmUiEhxLRnX0=;
        b=iokhhF4y+CpECl+uLdQ2V1mc3J/5uWv37vgilo3laU5g7Zmiox4ckzvDyMspF0j9Uz
         0moTr8Mo8uMqx6FsFFos9vfC7KhneDE2milWsAAJwAV5kiaYXECn012fqO5ZNpA2IyXS
         fdSSgSqdSyFXFHXVD0KkL3X8x4zWHINFhA0ImawBdCCvUn9QFLUTI1sN5uv6YsPnUT7l
         qnXu8MkgQunzoZJeZPt32x1tmzyupIayhfuzg9VQOFQkgJykq+0ChUuSaVzBR8hg/+Se
         4p2qvqgKmmdultDBGtVrtfD371nVYv315DJLHC7fyKd2QUs2ibUu9R0nrszI2L9gnav8
         isgg==
X-Gm-Message-State: AHQUAuZPsfnzrcGcWh/1rGvcPo+f5gB71HBzY6ap84DWGeW4KFQJKuKy
        Q3ffwgUSyO3NNVOk3GcAbpIyhjcVkwPhNx4ClpHySQ==
X-Google-Smtp-Source: AHgI3IZ4VrqIARngueUujLjQKpC2yGLnemJih6j4KGBPzwsYycY/erdhWo2qHCi6X1/KDxegEKeozU3GZ/fooUig+L8=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr3133577ioh.169.1550863471635;
 Fri, 22 Feb 2019 11:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20190211215518.81419-1-matthewgarrett@google.com>
 <20190219115652.GA29454@linux.intel.com> <CACdnJus0nkTtYyVsb71_nN11Oazj2xyR8WoMs6+r+jN=RYos8g@mail.gmail.com>
 <20190221121635.GC7918@linux.intel.com>
In-Reply-To: <20190221121635.GC7918@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 22 Feb 2019 11:24:20 -0800
Message-ID: <CACdnJuvt3i+uEzq0xyj4_3GP5DVbtZ1WywyoetS0SE9E-BRLVw@mail.gmail.com>
Subject: Re: [PATCH V3] Add support for TPM2 event logs on EFI systems
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 21, 2019 at 4:16 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:28:13AM -0800, Matthew Garrett wrote:
> > On Tue, Feb 19, 2019 at 3:56 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > Tried to test with a Geminilake NUC but for some reason do not see the log
> > > file with this machine.
> >
> > I'll retest a rebased tree on my NUC on Friday - just ran out of time
> > to get a build done before I had to leave for a trip.
>
> Great, thanks. I'm in process of getting v19 of SGX patch set out
> hopefully next week so probably won't have time to look at this
> before latter part of that week.

Tested on an Apollo Lake NUC and I see
/sys/kernel/security/tpm0/binary_bios_measurements with this. dmesg
shows both the TPMFinalLog and the TPMEventLog.
