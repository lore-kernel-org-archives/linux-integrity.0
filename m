Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:45275 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdJYLYy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 07:24:54 -0400
Received: by mail-lf0-f51.google.com with SMTP id n69so27422381lfn.2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 04:24:54 -0700 (PDT)
Date: Wed, 25 Oct 2017 14:24:51 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Subject: Re: [PATCH V3] EVM: Add support for portable signature format
Message-ID: <20171025142451.188a4ddd@totoro>
In-Reply-To: <CACdnJutDgEsffdChL6LCf_+O15cUzJA0gt7jr4eC-ivQn43F7w@mail.gmail.com>
References: <20171025095413.25794-1-mjg59@google.com>
        <20171025131326.2ebbb4a4@totoro>
        <CACdnJutDgEsffdChL6LCf_+O15cUzJA0gt7jr4eC-ivQn43F7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Wed, 25 Oct 2017 03:43:34 -0700
Matthew Garrett <mjg59@google.com> ?????:

> On Wed, Oct 25, 2017 at 3:13 AM, Mikhail Kurinnoi
> <viewizard@viewizard.com> wrote:
> > In case of IMA hash update we will forced to update EVM xattr from
> > ima_fix_xattr() with __vfs_setxattr_noperm(), this mean we will not
> > call evm_inode_setxattr(), but call evm_inode_post_setxattr().
> >
> > Dmitry's patch
> > https://sourceforge.net/p/linux-ima/mailman/message/32987311/
> > have work around for this issue. Since, in case we have immutable
> > EVM, we should prevent any file data changes (IMA hash update).  
> 
> Ah - does this need any more than adding EVM_XATTR_PORTABLE_DIGSIG to
> the check in ima_appraise_measurement()? I can't see any other way
> that we could get to ima_fix_xattr().

I think, Dmitry put code into process_measurement() just because we
already have "mask" here, so, we could check it in easy way.

In previous discussion, Mimi asked move all EVM-related stuff
connected to this check into EVM module, instead of IMA. Probably, this
mean we should use EVM API (evm_verifyxattr(), called from
ima_appraise_measurement()), that we already have in order to EVM<->IMA
communication.



-- 
Best regards,
Mikhail Kurinnoi
