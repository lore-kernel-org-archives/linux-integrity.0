Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:44919 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdI1Pvb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 11:51:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170928135416.GA30859@bombadil.infradead.org>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com> <20170928135416.GA30859@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Sep 2017 08:51:30 -0700
Message-ID: <CA+55aFwte=U_YCeV8u+5+7VrJs-mz6ieqM8zu2j7Ox-7+F3C0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: define new read_iter rwf flag
To: Matthew Wilcox <willy@infradead.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 6:54 AM, Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't like adding a bool parameter everywhere.  Why not add a flag
> to the kiocb ki_flags?
>
> #define IOCB_RWSEM_HELD         (1 << 8)

Yeah, I think that would be a nicer approach, with filesystems that
don't care being able to just ignore it entirely.

                     Linus
