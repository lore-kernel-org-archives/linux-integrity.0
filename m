Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:41244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeG3TwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jul 2018 15:52:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UIEHtx017533
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jul 2018 18:16:05 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kge0cwvv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jul 2018 18:16:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UIG54b027696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jul 2018 18:16:05 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UIG5Wi012845
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jul 2018 18:16:05 GMT
From: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: update on IMA on NFS
Message-Id: <1FDC76D1-6F2F-446D-9A96-E65606ED8C7B@oracle.com>
Date: Mon, 30 Jul 2018 14:16:03 -0400
To: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I gave a 15 minute presentation on IMA on NFS during the nfsv4 Working Group
meeting at IETF 102 a couple of weeks ago. Meeting material is here:

  https://datatracker.ietf.org/meeting/102/session/nfsv4

The latest draft describing Integrity Measurement on NFS is here:

  https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/

Comments, questions, or corrections to my understanding are welcome.


The largest issue with the proposal remains how to construct a normative
Internet standard for IMA on NFS without a published standard for IMA itself.
I've been asked to inquire with the IMA community whether there is any
interest in or a plan for creating a standard around IMA on local filesystems?


Next, as I move forward with a prototype of IMA on NFS, I'd like to better
understand the considerations for how an NFS server should authorize read
access to file and attribute hashes, and how it should authorize updates to
these hashes. Is there writing or code I can look at in local file systems
that can give me insight about what kind of protection an NFS server needs
to provide for this metadata?


--
Chuck Lever
