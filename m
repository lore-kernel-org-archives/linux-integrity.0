Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:38062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHTRoC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Aug 2018 13:44:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7KEIiNX071396
        for <linux-integrity@vger.kernel.org>; Mon, 20 Aug 2018 14:28:09 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtepgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 20 Aug 2018 14:28:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7KES8JA019514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 20 Aug 2018 14:28:08 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7KES80F029923
        for <linux-integrity@vger.kernel.org>; Mon, 20 Aug 2018 14:28:08 GMT
From: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: update on IMA on NFS
Date: Mon, 20 Aug 2018 10:28:06 -0400
References: <1FDC76D1-6F2F-446D-9A96-E65606ED8C7B@oracle.com>
To: linux-integrity@vger.kernel.org
In-Reply-To: <1FDC76D1-6F2F-446D-9A96-E65606ED8C7B@oracle.com>
Message-Id: <5AA34A3D-3D99-4E64-B95E-ED31395F98DF@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> On Jul 30, 2018, at 2:16 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> I gave a 15 minute presentation on IMA on NFS during the nfsv4 Working Group
> meeting at IETF 102 a couple of weeks ago. Meeting material is here:
> 
>  https://datatracker.ietf.org/meeting/102/session/nfsv4
> 
> The latest draft describing Integrity Measurement on NFS is here:
> 
>  https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/
> 
> Comments, questions, or corrections to my understanding are welcome.
> 
> 
> The largest issue with the proposal remains how to construct a normative
> Internet standard for IMA on NFS without a published standard for IMA itself.
> I've been asked to inquire with the IMA community whether there is any
> interest in or a plan for creating a standard around IMA on local filesystems?

Bump.

I haven't received any response to this question. It is important to know your
plans so I can construct an extension to NFS that can be standardized by the
IETF.

If the answer is "we have no plans and no intention to standardize this work
outside the Linux community" then I can adjust the document and protocol. I
just need a response confirming this is the case.

Thanks!


--
Chuck Lever
