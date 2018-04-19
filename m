Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:52618 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbeDSQcn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Apr 2018 12:32:43 -0400
Date: Thu, 19 Apr 2018 11:32:42 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
Message-ID: <20180419163242.GA3049@mail.hallyn.com>
References: <152337099624.13448.11040477333954216664.idtracker@ietfa.amsl.com>
 <FB6125E9-528C-47DD-9774-86D9D4975A54@oracle.com>
 <1523401800.5268.61.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523401800.5268.61.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> Hi Chuck,
> 
> On Tue, 2018-04-10 at 08:44 -0600, Chuck Lever wrote:
> > > Begin forwarded message:
> > > 
> > > From: internet-drafts@ietf.org
> > > Subject: New Version Notification for draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > > Date: April 10, 2018 at 8:36:36 AM MDT
> > > To: "Charles Lever" <chuck.lever@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>
> > > 
> > > 
> > > A new version of I-D, draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > > has been successfully submitted by Charles Lever and posted to the
> > > IETF repository.
> > > 
> > > Name:		draft-cel-nfsv4-linux-seclabel-xtensions
> > > Revision:	00
> > > Title:		Linux-related Extensions to NFS version 4.2 Security Labels
> > > Document date:	2018-04-09
> > > Group:		Individual Submission
> > > Pages:		8
> > > URL:            https://www.ietf.org/internet-drafts/draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> > > Status:         https://datatracker.ietf.org/doc/draft-cel-nfsv4-linux-seclabel-xtensions/
> > > Htmlized:       https://tools.ietf.org/html/draft-cel-nfsv4-linux-seclabel-xtensions-00
> > > Htmlized:       https://datatracker.ietf.org/doc/html/draft-cel-nfsv4-linux-seclabel-xtensions
> > > 
> > > 
> > > Abstract:
> > >   NFS version 4.2 introduces an optional feature known as NFSv4
> > >   Security Labels.  This document extends NFSv4 Security Labels to
> > >   support Linux file capabilities and the Linux Integrity Measurement
> > >   Architecture.
> > > 
> 
> Very nice!  Thank you so much for writing this up.

Hi Chuck,

did you have any plans to extend the file capabilities support to
also handle namespaced file capabilities?  Is that orthogonal to
this spec?
