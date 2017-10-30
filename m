Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbdJ3RFk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 13:05:40 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1509382827.3583.143.camel@linux.vnet.ibm.com>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com> <1508774387.3639.128.camel@linux.vnet.ibm.com> <750.1509378910@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Mon, 30 Oct 2017 17:05:38 +0000
Message-ID: <3691.1509383138@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > Did you mean "true" rather than "TRUE"?
> 
> Yes, of course.  Commit 9f4b6a254d7a "ima: Fix bool
> initialization/comparison" already addresses it.  Please remove it
> from this patch.

Is that with James?  I don't seem to have a copy, and I don't want to cause a
patch collision.

> > I guess also that oopsing is okay if the allocation fails.  We've run out of
> > memory during early boot, after all.
> 
> If the memory allocation fails, the "secure_boot" policy will not be
> enabled for custom policies, but how is that "oopsing".

Sorry - I overlooked the fact that the variable is not used if it's not zero.

> If it fails, there needs to be some indication of the failure, which there
> currently isn't.  Perhaps also prevent loading a custom policy.

Does it need to panic (probably fine as a small memory alloc failed)?  If it
doesn't set this policy what's the effect on things using
is_ima_appraise_enabled() - assuming we get that far?

David
