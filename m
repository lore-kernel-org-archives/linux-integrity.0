Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:36322 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeERROD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 13:14:03 -0400
Date: Sat, 19 May 2018 03:13:37 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>        <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>        <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com> <87y3ghhbws.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 17 May 2018, Eric W. Biederman wrote:

> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.

Hmm, it's not even doing that.

There's already an if(!file && read_id == X) { } check and this is another 
one being added.

> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

All ima_read is doing in both the old and new case is checking if there's 
no file then if it's a certain operation, returning an error.

To echo Eric and Casey's suggestions, how about changing the name of the 
hook to security_kernel_read_data() ?

Then ima_read_file() can be changed to ima_read_data(), and then instead 
of two if (!file && read_id == X) checks, have:

	if (!file) {
		switch (read_id) {
		}
	}




-- 
James Morris
<jmorris@namei.org>
