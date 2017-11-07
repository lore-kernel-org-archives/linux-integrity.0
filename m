Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:47189 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934280AbdKGOtW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 09:49:22 -0500
Received: by mail-io0-f196.google.com with SMTP id h70so2379224ioi.4
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2017 06:49:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 7 Nov 2017 06:49:20 -0800
Message-ID: <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 7, 2017 at 2:36 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> Finally, digest lists address also the third issue because Linux
> distribution vendors already provide the digests of files included in each
> RPM package. The digest list is stored in the RPM header, signed by the
> vendor.

RPM's hardly universal, and distributions are in the process of moving
away from using it for distributing non-core applications (Flatpak and
Snap are becoming increasingly popular here). I think this needs to be
a generic solution rather than having the kernel tied to a specific
package format.
