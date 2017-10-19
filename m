Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:43132 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdJSLA0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 07:00:26 -0400
Received: by mail-oi0-f47.google.com with SMTP id c77so13807063oig.0
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 04:00:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 19 Oct 2017 14:00:25 +0300
Message-ID: <CACE9dm_ijBqhyQOPmWYXq+uzJ2Cxi1J92QDuqketrF6HKfH8BA@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 2:12 AM, Matthew Garrett <mjg59@google.com> wrote:
> I'm interested in extending our use of IMA digital signatures to EVM
> in order to protect security.capability (and, in the near future,
> security.apparmor). However, right now this doesn't seem to quite work
> in terms of allowing updates to a running system. We've discussed the
> EVM siganture format's use of inode numbers and I think I've got that
> sorted (I'll send a patch once I've got a last couple of things
> working).
>
> However, I'm a little confused by how EVM should be working here. Once
> EVM is initialised, all EVM attributes will be protected, making it
> impossible to write new values to any xattrs covered by EVM unless
> IMA_NEW_FILE is set.


Sorry, why it is not possible to set xattrs?
system can change xattrs and hmac will be recalculated...


> But as far as I can tell, IMA_NEW_FILE will only
> be set if there's an IMA action that covers the file in question. This
> means it's possible to write out security.evm and friends on newly
> created files that would be appraised, but not on any other files. Am
> I missing something?



-- 
Thanks,
Dmitry
