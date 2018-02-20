Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:49468 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932260AbeBTAwy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 19:52:54 -0500
Date: Tue, 20 Feb 2018 11:52:42 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
In-Reply-To: <87zi44mz26.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1802201152240.883@namei.org>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>        <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com> <87zi44mz26.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 19 Feb 2018, Eric W. Biederman wrote:

> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > Files on untrusted filesystems, such as fuse, can change at any time,
> > making the measurement(s) and by extension signature verification
> > meaningless.
> 
> Filesystems with servers?
> Remote filesystems?
> Perhaps unexpected changes.
> 
> Untrusted sounds a bit harsh, and I am not certain it quite captures
> what you are looking to avoid.

Right -- I think whether you trust a filesystem or not depends on how much 
assurance you have in your specific configuration, rather than whether you 
think the filesystem can be manipulated or not.

There is a difference between:

  - This fs has no way to communicate a change to IMA, and;

  - This fs could be malicious.

In the latter case, I suggest that any fs could be malicious if the 
overall security policy / settings are inadequate for the threat model, or 
if there are vulnerabilities which allow such security to be bypassed.

Whether a user trusts FUSE on their particular system should be a policy 
decision on the part of the user.  The kernel should not be deciding what 
is trusted or not trusted here.



-- 
James Morris
<jmorris@namei.org>
