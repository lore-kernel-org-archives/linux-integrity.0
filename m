Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:55548 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbdI0WRE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:04 -0400
Received: by mail-oi0-f74.google.com with SMTP id n82so6460124oib.14
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:04 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:47 -0700
Message-Id: <20170927221653.11219-1-mjg59@google.com>
Subject: RFC: Make it practical to ship EVM signatures
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

These are basically untested, but I'd like to get some feedback on the
problem I'm trying to solve here. We'd like to be able to ship packages
with verifiable security xattrs, but right now EVM makes this difficult
due to its requirement that the inode number be encoded in the hmac. This
patchset is intended to make it possible to protect a subset of metadata
rather than all of it, and also to permit using EVM digital signatures in
a similar way to how IMA digital signatures can be used now (ie, protecting
the metadata using public/private crypto rather than having a local
symmetric key and generating the HMACs locally). The expected workflow is:

1) During package build or mirroring process, appropriate security metadata
   is added (IMA hash, selinux label, etc)
2) An EVM digital signature is generated based purely on the security
   metadata present during the build or mirroring process
3) IMA is extended to allow it to force EVM validation during appraisal even
   if no symmetric EVM key has been added, which allows IMA appraisal to
   appraise not only the IMA hash but also the additional metadata
4) If EVM is never enabled, binaries are purely validated using the EVM
   digital signatures and are not transitioned to using HMACs
5) If EVM is desired, userland can set the set of metadata to be incorporated
   into the EVM HMAC before enabling EVM
