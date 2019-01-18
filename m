Return-Path: <SRS0=DQCd=P2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0849C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 02:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B62220873
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfARCQQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:16:16 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfARCQQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jan 2019 21:16:16 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so9513545ioj.5
        for <linux-integrity@vger.kernel.org>; Thu, 17 Jan 2019 18:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1Vi2twaxCAxBYKd/ynqir+tFE92LwhK2OpVcmOSNbw=;
        b=gr/3Ec0qpeULEn25dpQRwUZlfdSBhAB4HVpUUq25eGM/6M7p+UMsLxvk6MILW7Y6pZ
         cCa9MaVBTCGuIccen3hSX7Ax2Zvk4+QlRa84yK7hHLUykbkXiJ+S350lKPBRu0pErTPl
         Iz7wsZbqZwpyKLpf12jUMPWRBW7JOrjpU9S4JDBOXG/k2GvJXyuVddVceLjJfbt84Ozg
         25tmRCUqLpRLogubADPBe/lHHMBQP7utTH77iz9drUJT0FyrLHtxVFMAzGKt7dsTfOb5
         zpFMCUpgJWEbuQjGbdyVpxiA8bDy3w2tezkKhJqlAKi2KMiwZz7wYDnYLBCVnvfIYBsQ
         VeCQ==
X-Gm-Message-State: AJcUuke3BVNsFo/iA3dsM2UrGKFtMm+X4T241qXVNQLgVzdveksekgj2
        lVZYXlIdy4LTKoe/s7tNApzFqKPydZy2Qwc78C9/kg==
X-Google-Smtp-Source: ALg8bN5KBYV4f5mSIXrD0uQ8LaRxTe21KhIWvhylevoKPAclagnGx4HrlWLHTf/Oux56KaUcEtMofXPU2RgfYPuuuFY=
X-Received: by 2002:a6b:b502:: with SMTP id e2mr8494488iof.43.1547777775146;
 Thu, 17 Jan 2019 18:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20190116101654.7288-1-kasong@redhat.com> <1547773684.4026.10.camel@linux.ibm.com>
 <20190118013530.GA2814@dhcp-128-65.nay.redhat.com> <20190118020006.GB2814@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190118020006.GB2814@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 10:16:04 +0800
Message-ID: <CACPcB9ftKKp_uZf=kN86K2xqbVmaNfs97iyc4zPA_7d7FfL9eg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Dave Young <dyoung@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 18, 2019 at 10:00 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/18/19 at 09:35am, Dave Young wrote:
> > On 01/17/19 at 08:08pm, Mimi Zohar wrote:
> > > On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> > > > This patch series adds a .platform_trusted_keys in system_keyring as the
> > > > reference to .platform keyring in integrity subsystem, when platform
> > > > keyring is being initialized it will be updated. So other component could
> > > > use this keyring as well.
> > >
> > > Remove "other component could use ...".
> > > >
> > > > This patch series also let kexec_file_load use platform keyring as fall
> > > > back if it failed to verify the image against secondary keyring, make it
> > > > possible to load kernel signed by third part key if third party key is
> > > > imported in the firmware.
> > >
> > > This is the only reason for these patches.  Please remove "also".
> > >
> > > >
> > > > After this patch kexec_file_load will be able to verify a signed PE
> > > > bzImage using keys in platform keyring.
> > > >
> > > > Tested in a VM with locally signed kernel with pesign and imported the
> > > > cert to EFI's MokList variable.
> > >
> > > It's taken so long for me to review/test this patch set due to a
> > > regression in sanity_check_segment_list(), introduced somewhere
> > > between 4.20 and 5.0.0-rc1.  The sgement overlap test - "if ((mend >
> > > pstart) && (mstart < pend))" - fails, returning a -EINVAL.
> > >
> > > Is anyone else seeing this?
> >
> > Mimi, should be this issue?  I have sent a fix for that.
> > https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.com/
>
> Hi, Kairui, I think you should know this while working on this series,
> It is good to mention the test dependency in cover letter so that reviewers
> can save time.
>
> BTW, Boris took it in tip already:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b
>

Hi, thanks for the suggestion, I did apply your patch to avoid the
failure. Will add such info next time.

Will send out V4 and update commit message as suggested by Mimi


--
Best Regards,
Kairui Song
