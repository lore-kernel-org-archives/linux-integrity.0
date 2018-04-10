Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:47822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDJOo1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 10:44:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w3AEfDJ2102928
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 14:44:27 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2h6pn4jg77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 14:44:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w3AEiPbe004887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 14:44:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w3AEiPXv002151
        for <linux-integrity@vger.kernel.org>; Tue, 10 Apr 2018 14:44:25 GMT
From: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Fwd: New Version Notification for
 draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
Message-Id: <FB6125E9-528C-47DD-9774-86D9D4975A54@oracle.com>
References: <152337099624.13448.11040477333954216664.idtracker@ietfa.amsl.com>
To: linux-integrity@vger.kernel.org
Date: Tue, 10 Apr 2018 08:44:24 -0600
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> Begin forwarded message:
> 
> From: internet-drafts@ietf.org
> Subject: New Version Notification for draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> Date: April 10, 2018 at 8:36:36 AM MDT
> To: "Charles Lever" <chuck.lever@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>
> 
> 
> A new version of I-D, draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> has been successfully submitted by Charles Lever and posted to the
> IETF repository.
> 
> Name:		draft-cel-nfsv4-linux-seclabel-xtensions
> Revision:	00
> Title:		Linux-related Extensions to NFS version 4.2 Security Labels
> Document date:	2018-04-09
> Group:		Individual Submission
> Pages:		8
> URL:            https://www.ietf.org/internet-drafts/draft-cel-nfsv4-linux-seclabel-xtensions-00.txt
> Status:         https://datatracker.ietf.org/doc/draft-cel-nfsv4-linux-seclabel-xtensions/
> Htmlized:       https://tools.ietf.org/html/draft-cel-nfsv4-linux-seclabel-xtensions-00
> Htmlized:       https://datatracker.ietf.org/doc/html/draft-cel-nfsv4-linux-seclabel-xtensions
> 
> 
> Abstract:
>   NFS version 4.2 introduces an optional feature known as NFSv4
>   Security Labels.  This document extends NFSv4 Security Labels to
>   support Linux file capabilities and the Linux Integrity Measurement
>   Architecture.
> 
> 
> 
> 
> Please note that it may take a couple of minutes from the time of submission
> until the htmlized version and diff are available at tools.ietf.org.
> 
> The IETF Secretariat

Initial revision, by no means final. Review comments welcome.

I'm toying with some ideas here. If you find anything controversial
you are welcome to provide input.


--
Chuck Lever
