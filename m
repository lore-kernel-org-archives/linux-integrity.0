Return-Path: <SRS0=+v6P=TW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F950C282CE
	for <linux-integrity@archiver.kernel.org>; Wed, 22 May 2019 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0720879
	for <linux-integrity@archiver.kernel.org>; Wed, 22 May 2019 14:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K27TltKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfEVO4l (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 May 2019 10:56:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVO4l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 10:56:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MErTJB054591;
        Wed, 22 May 2019 14:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2018-07-02;
 bh=FM0n79I5F3aFH2LgsY7qWtEZVdqaEaKHOvEd09gClIo=;
 b=K27TltKrcui2PSF7ElKUP9PQSJ2+mVWkS6PekcCR2CxyifA964Q1fU1oMz4KDj5jZnGz
 hA94S4JFSiJcbrZ/SjnP1A4AOsWqwVmVGG/kGhHzdWK8HnxOeFmC7u84qM5UPDb8A431
 IvxBDfBY4Dk0IuVhXAfhM2A4liD8MjDV8VItKy8otUrhnXaD4n7AkxRxxE969polnXBi
 1KGAzobgaEH/Tu5AtYkNKn8tnQ7kEoVkMtIFo3GY5zQlL86NJTh24ameqc428f+wMe16
 LVbPwt7dX2fhIw0XQLvRYF7oXUBKK68zwp2J0TqCmm3ukoxIbDa40CksBNIinQHH0rSw Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2smsk5cb01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 14:56:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MErgGM033207;
        Wed, 22 May 2019 14:54:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2smsguw6s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 14:54:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4MEsaE5031161;
        Wed, 22 May 2019 14:54:36 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 14:54:36 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: CAP_SYS_ADMIN requirement for updating IMA metadata
Message-Id: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
Date:   Wed, 22 May 2019 10:54:35 -0400
Cc:     linux-integrity@vger.kernel.org
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=834
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=867 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220106
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi-

I'm working on a section of draft-ietf-nfsv4-integrity-measurement that
discusses what kind of access permission is necessary to update a file's
IMA metadata. This is needed because every NFS operation has an associated
user ID -- an NFS server implementer needs to know which users are allowed
to alter the IMA metadata.

On Linux, because the metadata is stored in "security.ima", CAP_SYS_ADMIN
is required.

But on other NFS server implementations (ones that might not have a
capabilities system), IMA metadata could be stored via a mechanism that
does not require any special permission.

And, it seems to me that if a user can alter the file content, there is
no additional harm in her being allowed to update the IMA metadata.

Is there an architectural reason, other than that Linux stores IMA metadata
in a security.* xattr, for requiring a superuser privilege to update IMA
metadata?

Thanks in advance for any insight!


--
Chuck Lever



