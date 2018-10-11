Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.hallyn.com ([178.63.66.53]:43208 "EHLO mail"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbeJKX0E (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 19:26:04 -0400
Date: Thu, 11 Oct 2018 15:48:47 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Monty Wiseman <montywiseman32@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Subject: Re: LPC 2018
Message-ID: <20181011154847.GA5978@mail.hallyn.com>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Would be awesome if some meeting notes could be sent to this list after
the fact :)

thanks,
-serge

Quoting Monty Wiseman (montywiseman32@gmail.com):
> I'll be there and am interested. I'm co-chair of the TCG Infrastructure
> working group which is defining
> an Event log format for firmware and IMA.
> 
> 
> On 10/09/2018 11:58 AM, Chuck Lever wrote:
> > I'm planning to attend LPC next month. I'm interested in discussing
> > IMA on distributed file systems in particular with anyone here who
> > might also attend. I expect it would be a narrow topic, so a birds
> > of a feather is probably appropriate, but hallway track could work
> > too.
> > 
> > I especially would like to discuss the on-disk format of IMA
> > metadata, and how the IMA module behaves when it encounters metadata
> > it does not recognize (or how you do on-disk format versioning).
> > 
> > I'm still working on an Internet Draft that specifies how to enable
> > IMA on NFS files. The biggest challenge has been the lack of IMA
> > spec. The current revision of the Draft describes the requirements
> > in generic terms, and cites the IMA wiki/white paper only as an
> > Informative reference. I believe this will be adequate.
> > 
> > I've also dropped EVM support for now. Two concerns:
> > - NFS does not expose some file attributes that EVM protects
> > - The format of some file attributes might not be the same on all
> >    client OSes.
> > 
> > More to talk about in person, I hope.
> > 
> > https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/
> > 
> > 
> > --
> > Chuck Lever
> > 
> > 
> > 
> 
