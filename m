Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:45508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIXP5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 19:15:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99FsWwh080839
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 15:58:21 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mxmftpfe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 15:58:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w99FwKu2025632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 15:58:20 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w99FwJ1M001177
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 15:58:20 GMT
From: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: LPC 2018
Message-Id: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
Date: Tue, 9 Oct 2018 11:58:18 -0400
To: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'm planning to attend LPC next month. I'm interested in discussing
IMA on distributed file systems in particular with anyone here who
might also attend. I expect it would be a narrow topic, so a birds
of a feather is probably appropriate, but hallway track could work
too.

I especially would like to discuss the on-disk format of IMA
metadata, and how the IMA module behaves when it encounters metadata
it does not recognize (or how you do on-disk format versioning).

I'm still working on an Internet Draft that specifies how to enable
IMA on NFS files. The biggest challenge has been the lack of IMA
spec. The current revision of the Draft describes the requirements
in generic terms, and cites the IMA wiki/white paper only as an
Informative reference. I believe this will be adequate.

I've also dropped EVM support for now. Two concerns:
- NFS does not expose some file attributes that EVM protects
- The format of some file attributes might not be the same on all
  client OSes.

More to talk about in person, I hope.

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/


--
Chuck Lever
