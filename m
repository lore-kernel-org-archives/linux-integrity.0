Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:47088 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752511AbeDXTrh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Apr 2018 15:47:37 -0400
Date: Tue, 24 Apr 2018 14:47:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [Fwd: Re: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt]
Message-ID: <20180424194736.GA23575@mail.hallyn.com>
References: <20180419163242.GA3049@mail.hallyn.com>
 <1524589082.3364.26.camel@linux.vnet.ibm.com>
 <B30998E8-66A3-49FE-8078-B4B4A9AFD480@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B30998E8-66A3-49FE-8078-B4B4A9AFD480@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Quoting Chuck Lever (chuck.lever@oracle.com):
> Hi Serge-
> 
> Apologies for the delay. My e-mail system dropped your reply.
> Mimi forwarded it to me today (thanks!). See below.

Oh - I hope this one goes through :)

> > On Apr 24, 2018, at 10:58 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
...
> > Hi Chuck,
> > 
> > did you have any plans to extend the file capabilities support to
> > also handle namespaced file capabilities?  Is that orthogonal to
> > this spec?
> 
> It probably isn't clear to readers who are not familiar with
> how the IETF works; that's OK, there have been similar comments
> about this document in other forums. Just to be clear, this I-D
> is not a design doc for a Linux implementation of either IMA on
> NFS, or file capabilities on NFS. It is only about what goes on
> the wire. An eventual prototype implementation will help us
> understand subtleties and further implementation requirements.

Right so the details of how they are namespaced are (I believe) out
of scope not only for the wire protocol but also for the NFS server.
However the V3 capabilities (see below) will need to be able to pass
a "namespaced root ID" along with the capability.  This is to support
serving a filesystem which will be used by a user namespace (usually
meaning "a container") created by the namespace which mounted the NFS
filesystem.

This will allow a host (or a container) to nfs-mount a filesystem
which has files owned by (say) uid 100005, with file capabilities
attached which will only take effect when (say) uid 100000 is mapped to
root in the container.

So root in the container will be able to add cap_net_raw=pe to
/usr/bin/ping, and that capability will take effect only inside the
container, not on the host.  Without this ability, installing/upgrading
fedora/centos fails in user namespaced containers.

> My naive response to your specific question is that namespaces
> are objects that exist on Linux NFS clients, thus are not directly
> exposed to servers or other clients. Do you have a convenient
> description of file capabilities so I can better understand if
> the NFS protocol needs to be aware of namespaces?

The general capabilities.7 and user_namespaces.7 manpages (see
http://man7.org/linux/man-pages/man7/capabilities.7.html
and
http://man7.org/linux/man-pages/man7/user_namespaces.7.html )
give some background - see section 'File capabilities' in
capabilities.7 .  The capabilties.7 update for namespaced file
capabilities is still under discussion - the latest commit is
at
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6442c03b6815eda1202def03cc1e4eb9a57830f1
with the resulting file at
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/capabilities.7?id=6442c03b6815eda1202def03cc1e4eb9a57830f1
(check out maybe starting at line 935), and the email thread is at
http://www.spinics.net/lists/linux-man/msg12492.html

Finally, the original patch description is here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xattr.c?h=v4.17-rc2&id=8db6c34f1dbc8e06aa016a9b829b06902c3e1340

thanks,
-serge
