Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:39382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXSHu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Apr 2018 14:07:50 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [Fwd: Re: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt]
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1524589082.3364.26.camel@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 12:07:41 -0600
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Michael Halcrow <mhalcrow@google.com>
Message-Id: <B30998E8-66A3-49FE-8078-B4B4A9AFD480@oracle.com>
References: <20180419163242.GA3049@mail.hallyn.com>
 <1524589082.3364.26.camel@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Serge-

Apologies for the delay. My e-mail system dropped your reply.
Mimi forwarded it to me today (thanks!). See below.


> On Apr 24, 2018, at 10:58 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> -------- Forwarded Message --------
> From: Serge E. Hallyn <serge@hallyn.com>
> To: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>, linux-integrity@vger.kernel.
> org, Serge E. Hallyn <serge@hallyn.com>, Michael Halcrow <mhalcrow@goo
> gle.com>
> Subject: Re: Fwd: New Version Notification for draft-cel-nfsv4-linux-
> seclabel-xtensions-00.txt
> Date: Thu, 19 Apr 2018 11:32:42 -0500
> 
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
>> Hi Chuck,
>> 
>> On Tue, 2018-04-10 at 08:44 -0600, Chuck Lever wrote:
>>>> Begin forwarded message:
>>>> 
>>>> From: internet-drafts@ietf.org
>>>> Subject: New Version Notification for draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
>>>> Date: April 10, 2018 at 8:36:36 AM MDT
>>>> To: "Charles Lever" <chuck.lever@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>
>>>> 
>>>> 
>>>> A new version of I-D, draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
>>>> has been successfully submitted by Charles Lever and posted to the
>>>> IETF repository.
>>>> 
>>>> Name:		draft-cel-nfsv4-linux-seclabel-xtensions
>>>> Revision:	00
>>>> Title:		Linux-related Extensions to NFS version 4.2 Security Labels
>>>> Document date:	2018-04-09
>>>> Group:		Individual Submission
>>>> Pages:		8
>>>> URL:            https://www.ietf.org/internet-drafts/draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
>>>> Status:         https://datatracker.ietf.org/doc/draft-cel-nfsv4-linux-seclabel-xtensions/
>>>> Htmlized:       https://tools.ietf.org/html/draft-cel-nfsv4-linux-seclabel-xtensions-00
>>>> Htmlized:       https://datatracker.ietf.org/doc/html/draft-cel-nfsv4-linux-seclabel-xtensions
>>>> 
>>>> 
>>>> Abstract:
>>>>  NFS version 4.2 introduces an optional feature known as NFSv4
>>>>  Security Labels.  This document extends NFSv4 Security Labels to
>>>>  support Linux file capabilities and the Linux Integrity Measurement
>>>>  Architecture.
>>>> 
>> 
>> Very nice!  Thank you so much for writing this up.
> 
> Hi Chuck,
> 
> did you have any plans to extend the file capabilities support to
> also handle namespaced file capabilities?  Is that orthogonal to
> this spec?

It probably isn't clear to readers who are not familiar with
how the IETF works; that's OK, there have been similar comments
about this document in other forums. Just to be clear, this I-D
is not a design doc for a Linux implementation of either IMA on
NFS, or file capabilities on NFS. It is only about what goes on
the wire. An eventual prototype implementation will help us
understand subtleties and further implementation requirements.

My naive response to your specific question is that namespaces
are objects that exist on Linux NFS clients, thus are not directly
exposed to servers or other clients. Do you have a convenient
description of file capabilities so I can better understand if
the NFS protocol needs to be aware of namespaces?


--
Chuck Lever
