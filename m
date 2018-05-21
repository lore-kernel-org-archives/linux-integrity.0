Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:54848 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeEUW2O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 May 2018 18:28:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w4LMHEg7148512
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 22:28:11 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2j29eyedy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 22:28:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w4LMSAnT010659
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 22:28:11 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w4LMSAOP020409
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 22:28:10 GMT
From: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Enabling EVM on NFS mounts
Message-Id: <729C6BCE-D60D-4687-8DD0-52E1EF35E535@oracle.com>
Date: Mon, 21 May 2018 15:28:09 -0700
To: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'm in the middle of rewriting

https://datatracker.ietf.org/doc/draft-cel-nfsv4-linux-seclabel-xtensions/

which was recently rejected by the nfsv4 Working Group for
plausible and fixable reasons. They like the idea, but my
proposal for using NFSv4 security labels is not workable
even as an experiment.

As I compose a fresh Internet-Draft I'm trying to understand
what an EVM HMAC covers, and I found this:

http://linux-ima.sourceforge.net/evmctl.1.html

> EVM protects file metadata by including following attributes into HMAC and signature calculation: inode number, inode generation, UID, GID, file mode, security.selinux, security.SMACK64, security.ima, security.capability.

> EVM HMAC and signature may also include additional file and file system attributes. Currently supported additional attributes are filesystem UUID and extra SMACK extended attributes.


The computation of the IMA HMAC is straightforward, but it
appears that the EVM HMAC is evolving, and not all of the
input items would necessarily be visible to remote EVM
consumers.

Is there any way an NFS client would be able to tell exactly
what attributes were used to compute an EVM hash, and what
should it do if the whole input set is not available for
verification?

Amongst the security. xattrs, I believe only security.selinux
is currently exposed via NFS. Thus an NFS client EVM would
see only that particular xattr and not others by which it can
compute or verify the EVM hash.

Does the inclusion here of "security.capability" mean that NFS
support for EVM and for file capabilities are inseparable? Is
the content of security.capability in a binary or human-readable
format?

Filesystem attributes such as a UUID, type, or disk label might
not be visible to NFS clients.

Would there be any reason to protect ACLs with the EVM hash?


--
Chuck Lever
