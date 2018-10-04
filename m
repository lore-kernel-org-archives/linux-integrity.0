Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot1-f74.google.com ([209.85.210.74]:48015 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJEDZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 23:25:05 -0400
Received: by mail-ot1-f74.google.com with SMTP id q3-v6so7398949otl.14
        for <linux-integrity@vger.kernel.org>; Thu, 04 Oct 2018 13:30:11 -0700 (PDT)
Date: Thu,  4 Oct 2018 13:30:04 -0700
Message-Id: <20181004203007.217320-1-mjg59@google.com>
Mime-Version: 1.0
Subject: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

As of d77ccdc644a59b412d8e101576134c90a0aa6797, IMA will trigger a
rehash of any file on a FUSE filesystem for every measurement. This has
a significant impact on performance. Individual FUSE filesystems may
have the ability to identify whether a file needs to be rehashed, and
some may even have the ability to obtain the file hash out of band
without needing the kernel to do it. Longer term, this may also be
usable for other scenarios where a filesystem can provide a trustworthy
hash (eg, fs-verity on ext4 could provide a hash and then later abort
any read()s that discover that the file doesn't match the measurement).
