Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:60020 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbeFGNpH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jun 2018 09:45:07 -0400
Date: Thu, 7 Jun 2018 08:45:06 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [Fwd: Re: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt]
Message-ID: <20180607134506.GA27228@mail.hallyn.com>
References: <20180419163242.GA3049@mail.hallyn.com>
 <1524589082.3364.26.camel@linux.vnet.ibm.com>
 <B30998E8-66A3-49FE-8078-B4B4A9AFD480@oracle.com>
 <20180424194736.GA23575@mail.hallyn.com>
 <F9577105-BC5B-4084-BD8D-3B6B5D8FEC1D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9577105-BC5B-4084-BD8D-3B6B5D8FEC1D@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Quoting Chuck Lever (chuck.lever@oracle.com):
> 
> 
> > On Apr 24, 2018, at 1:47 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > 
> > Quoting Chuck Lever (chuck.lever@oracle.com):
> >> Hi Serge-
> >> 
> >> Apologies for the delay. My e-mail system dropped your reply.
> >> Mimi forwarded it to me today (thanks!). See below.
> > 
> > Oh - I hope this one goes through :)
> > 
> >>> On Apr 24, 2018, at 10:58 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > ...
> >>> Hi Chuck,
> >>> 
> >>> did you have any plans to extend the file capabilities support to
> >>> also handle namespaced file capabilities?  Is that orthogonal to
> >>> this spec?
> >> 
> >> It probably isn't clear to readers who are not familiar with
> >> how the IETF works; that's OK, there have been similar comments
> >> about this document in other forums. Just to be clear, this I-D
> >> is not a design doc for a Linux implementation of either IMA on
> >> NFS, or file capabilities on NFS. It is only about what goes on
> >> the wire. An eventual prototype implementation will help us
> >> understand subtleties and further implementation requirements.
> > 
> > Right so the details of how they are namespaced are (I believe) out
> > of scope not only for the wire protocol but also for the NFS server.
> > However the V3 capabilities (see below) will need to be able to pass
> > a "namespaced root ID" along with the capability.  This is to support
> > serving a filesystem which will be used by a user namespace (usually
> > meaning "a container") created by the namespace which mounted the NFS
> > filesystem.
> > 
> > This will allow a host (or a container) to nfs-mount a filesystem
> > which has files owned by (say) uid 100005, with file capabilities
> > attached which will only take effect when (say) uid 100000 is mapped to
> > root in the container.
> > 
> > So root in the container will be able to add cap_net_raw=pe to
> > /usr/bin/ping, and that capability will take effect only inside the
> > container, not on the host.  Without this ability, installing/upgrading
> > fedora/centos fails in user namespaced containers.
> 
> OK, fair enough.
> 
> There is an interoperability concern with how file capabilities
> are represented in text format. Currently the I-D does not
> specify how this conversion is done, but rather rashly assumes
> that all NFS endpoints that claim to support Linux file capabi-
> lities will be able to understand that format.
> 
> Mostly this is because I don't know of a real citable standard
> that describes the text that comes out of cap_to_text(3). A man
> page doesn't really count as citable :-)
> 
> So if cap_to_text(3) handles namespaces already, then this
> should be taken care of transparently. Otherwise, we have to
> start thinking carefully about what else will go into the text
> strings: versioning, namespace, and so on, and that will have
> to be spelled out to some extent in the I-D.

cap_to_text does not, and actually the cap_t itself does not
have a concept of the namespaces either.  That's because for
the most part the kernel transparently does the conversion: if
you want filecaps in a user namespace, you'll generally enter
the user namespace to do the writing.  The one case where it
doesn't is when you are in a parent namespace and want to
immediately write a capability for a namespace with rootid=100000.
In that case right now you need to write the xattr by hand.

It would definately be worth it to update the the libcap api
to handle this.  I'm going to make a long term note to look
into a clean way to do that.

thanks,
Serge
