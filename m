Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:47433 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbdJYKng (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 06:43:36 -0400
Received: by mail-it0-f48.google.com with SMTP id p138so510897itp.2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 03:43:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171025131326.2ebbb4a4@totoro>
References: <20171025095413.25794-1-mjg59@google.com> <20171025131326.2ebbb4a4@totoro>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 25 Oct 2017 03:43:34 -0700
Message-ID: <CACdnJutDgEsffdChL6LCf_+O15cUzJA0gt7jr4eC-ivQn43F7w@mail.gmail.com>
Subject: Re: [PATCH V3] EVM: Add support for portable signature format
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 25, 2017 at 3:13 AM, Mikhail Kurinnoi
<viewizard@viewizard.com> wrote:
> In case of IMA hash update we will forced to update EVM xattr from
> ima_fix_xattr() with __vfs_setxattr_noperm(), this mean we will not call
> evm_inode_setxattr(), but call evm_inode_post_setxattr().
>
> Dmitry's patch
> https://sourceforge.net/p/linux-ima/mailman/message/32987311/
> have work around for this issue. Since, in case we have immutable EVM,
> we should prevent any file data changes (IMA hash update).

Ah - does this need any more than adding EVM_XATTR_PORTABLE_DIGSIG to
the check in ima_appraise_measurement()? I can't see any other way
that we could get to ima_fix_xattr().
