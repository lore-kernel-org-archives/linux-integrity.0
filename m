Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbdKJLis (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Nov 2017 06:38:48 -0500
From: David Howells <dhowells@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: IMA secure_boot rules and the kernel_lockdown manpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Nov 2017 11:38:46 +0000
Message-ID: <28799.1510313926@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

I need to add a statement about the IMA secure_boot rules to the
kernel_lockdown manual page.  Is this enough:

	IMA requires the addition of the "secure_boot" rules to the policy,
	whether or not they are specified on the command line, for both the
	builtin and custom policies in secure boot lockdown mode.

I don't know what this actually does/achieves.

David
