Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:36788 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbeB1PaR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Feb 2018 10:30:17 -0500
Date: Wed, 28 Feb 2018 09:30:15 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH v2 3/4] ima: fail signature verification based on policy
Message-ID: <20180228153015.GA30654@mail.hallyn.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1519335184-17808-4-git-send-email-zohar@linux.vnet.ibm.com>
 <20180227223545.GB18767@mail.hallyn.com>
 <1519817938.3737.72.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1519817938.3737.72.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> On Tue, 2018-02-27 at 16:35 -0600, Serge E. Hallyn wrote:
> > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > This patch addresses the fuse privileged mounted filesystems in
> > > environments which are unwilling to accept the risk of trusting the
> > > signature verification and want to always fail safe, but are for
> > > example using a pre-built kernel.
> > > 
> > > This patch defines a new builtin policy "unverifiable_sigs", which can
> > 
> > How about recalc_unverifiable_sigs?
> 
> Cute, I really like that name, but in this case we're failing the
> signature verification.
> 
> > It's long, but unverifiable_sigs
> > is  not clear about whether the intent is to accept or recalculate them.
> > 
> > (or fail_unverifiable_sigs like the flag)
> 
> Could we abbreviate it to "fail_usigs"?  Or perhaps allow both
> "fail_unverifiable_sigs" and "fail_usigs".

That sounds good.  Or fail_unverified?  But so long as 'fail' is somehow
clearly implied by the name.
