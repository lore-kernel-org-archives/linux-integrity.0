Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:51055 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbdJQXMk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 19:12:40 -0400
Received: by mail-it0-f43.google.com with SMTP id 72so4512295itl.5
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 16:12:40 -0700 (PDT)
MIME-Version: 1.0
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 17 Oct 2017 16:12:38 -0700
Message-ID: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
Subject: Writing out EVM protected xattrs while EVM is active
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'm interested in extending our use of IMA digital signatures to EVM
in order to protect security.capability (and, in the near future,
security.apparmor). However, right now this doesn't seem to quite work
in terms of allowing updates to a running system. We've discussed the
EVM siganture format's use of inode numbers and I think I've got that
sorted (I'll send a patch once I've got a last couple of things
working).

However, I'm a little confused by how EVM should be working here. Once
EVM is initialised, all EVM attributes will be protected, making it
impossible to write new values to any xattrs covered by EVM unless
IMA_NEW_FILE is set. But as far as I can tell, IMA_NEW_FILE will only
be set if there's an IMA action that covers the file in question. This
means it's possible to write out security.evm and friends on newly
created files that would be appraised, but not on any other files. Am
I missing something?
