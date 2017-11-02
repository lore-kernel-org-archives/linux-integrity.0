Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934115AbdKBVnl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Nov 2017 17:43:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1509658253.3416.1.camel@linux.vnet.ibm.com>
References: <1509658253.3416.1.camel@linux.vnet.ibm.com> <1509382827.3583.143.camel@linux.vnet.ibm.com> <1508774387.3639.128.camel@linux.vnet.ibm.com> <750.1509378910@warthog.procyon.org.uk> <22475.1509642717@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 02 Nov 2017 21:43:39 +0000
Message-ID: <13298.1509659019@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > +	bool kernel_locked_down = kernel_is_locked_down();
> 
> kernel_is_locked_down() requires a string.

Hmmm...  Probably don't want to call kernel_is_locked_down() here as that'll
get a message printed saying that you tried to do something that's disallowed.

Possibly:

	... = __kernel_is_locked_down("", false);

Though it might be better to provide a second vector.

David
