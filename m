Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43911 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbdKJObW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 09:31:22 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1510319414.3359.27.camel@linux.vnet.ibm.com>
References: <1510319414.3359.27.camel@linux.vnet.ibm.com> <28799.1510313926@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: IMA secure_boot rules and the kernel_lockdown manpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Nov 2017 14:31:19 +0000
Message-ID: <32623.1510324279@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> This initially enforces kernel modules, firmware, the kernel kexec
> image, and the IMA policy itself are signed.

"Initially" meaning that this can be changed?

David
