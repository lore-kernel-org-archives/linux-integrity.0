Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F2C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 01:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A89420835
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 01:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myt/D5ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCSBI5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:08:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34124 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSBI4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 21:08:56 -0400
Received: by mail-io1-f67.google.com with SMTP id n11so16418002ioh.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw4rcJJwCCpfpTna6h66copfppU4BWPDSiHRFS8F4kU=;
        b=Myt/D5ST2//89GQ588315gHcuuTmPw2yrU4nSfBbg259gHSeHhWxp6Ec6jl/wDyXyI
         wAZU8PXij1dmDdtFCIyUu0yoW7G6phZ66qX+PYNpiMtk5H+VvMfiwpUH/PaOZMP5ZsFO
         7WzNHdr9RieJcSu7zR+MWufQ3t7siW87gSHXxl4vtdkPS3HioLdgFrWdzDBGlLUU43Vo
         oMkGVKW0fYQsjVc01AugagfifYQrExGeGVXbkf9MTx9gUUxbtVaixUzQJfZLBC7gxxsz
         pypI4pCWxO4fAbNkiARNZICaPW3Wwbc3mO1rz2DH7m/V0bpO/IVGd5mkywuKfMGxnpZW
         Ufww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw4rcJJwCCpfpTna6h66copfppU4BWPDSiHRFS8F4kU=;
        b=UFvxxFQ4wEqSav+xkdLKf1TW8+/XXxm3p3rEKWiupE//aPsSDbuhgVLkacWR8ddYbn
         swzwiqC2hTkcqAYVHRq6qEzN2t56kzmzvbdpJfmQcZXjV2N3iBA64v67O4JZas4VbKrD
         5ccKLuYIFI/uVV0bfibOiwFW+dB1V4k8kOC6Ohz3XLAzg6Jf8hcDQadiVQB0cO6E2RNS
         yFJV/1E2p6pfniCNF97Ly1vaqOkbpGgKSfJ1GRvml3QDeZ8PMKpstE7Tcux6l1XKi8MR
         dzpskHY4M8WGyWgnlbZFJRTapP4w6oyUw795H18N0HP9/e52+0I3JTSdT/4xFOfB6Nk5
         GVAA==
X-Gm-Message-State: APjAAAXoMBwZNzS1c22/SPJzcyj2a9gqtmWoAS3HcCcSk2IHqtwo/LiL
        vgw3FOICUC2YVpKZ55pwHRIoifETlstRn6CSYvE=
X-Google-Smtp-Source: APXvYqxDo6C1qxoD27BlCL8gsEoEy9rGDxy01y0209pei0ciASdZMYcGqHaHWz5JRDppNCde9hzbF6k8G0xg8iMlAys=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr12676029ioh.156.1552957735972;
 Mon, 18 Mar 2019 18:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
In-Reply-To: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Mon, 18 Mar 2019 18:08:30 -0700
Message-ID: <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hmm, looks like my original email didn't make it to the linux-integrity
list, maybe the two attachments were too big. You can read it on the
linux-kernel list here:
https://marc.info/?l=linux-kernel&m=155294522323580

On Mon, Mar 18, 2019 at 2:39 PM Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Hello,
>
> I'm seeing suspend-to-ram fail consistently in 5.1-rc1. Dmesg shows a
> failure in the TPM subsystem. This is on an HP Elitebook 640 G1 running
> Linux Mint.
>
> [   43.110604] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
> [   53.179672] PM: suspend entry (deep)
> [   53.179674] PM: Syncing filesystems ... done.
> [   53.190349] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   53.192107] OOM killer disabled.
> [   53.192107] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   53.193147] printk: Suspending console(s) (use no_console_suspend to debug)
> [   53.209184] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> [   53.213137] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   53.214632] sd 0:0:0:0: [sda] Stopping disk
> [   53.241598] tpm tpm0: tpm_try_transmit: send(): error -5
> [   53.241600] tpm tpm0: Error (-5) sending savestate before suspend
> [   53.241606] PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x90 returns -5
> [   53.241609] PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns -5
> [   53.241610] PM: Device 00:06 failed to suspend: error -5
>
> Full dmesg and config attached. Anything I can do to help debug this?
> It takes about 45 minutes to do a full kernel rebuild on this machine,
> so doing a full bisection would be a little painful.
>
> -- Paul
