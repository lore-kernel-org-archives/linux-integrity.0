Return-Path: <SRS0=ZD6g=O3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3704C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 23:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99456218A2
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLRXAk (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:00:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbeLRXAk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Dec 2018 18:00:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBIMojdS071228
        for <linux-integrity@vger.kernel.org>; Tue, 18 Dec 2018 18:00:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pf9881xx5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Dec 2018 18:00:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Dec 2018 23:00:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 23:00:33 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBIN0W7P44761152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 23:00:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C4D4C06D;
        Tue, 18 Dec 2018 23:00:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98BD34C050;
        Tue, 18 Dec 2018 23:00:31 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 23:00:31 +0000 (GMT)
Subject: Re: EVM: Permission denied with overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ignaz Forster <iforster@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Date:   Tue, 18 Dec 2018 18:00:31 -0500
In-Reply-To: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121823-0016-0000-0000-0000023865CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121823-0017-0000-0000-00003290B8E9
Message-Id: <1545174031.4178.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

On Tue, 2018-12-18 at 20:49 +0100, Ignaz Forster wrote:
> Hi,
> 
> as a follow up to my attempts to use overlayfs on an IMA protected 
> system[1] I've now tried to also enable EVM. From what I understand this 
> should - at least in theory - be possible: EVM will call 
> d_backing_inode(dentry), which I thought would get the inode of the 
> underlying file system[2], and use that for HMAC verification.
> 
> In practice simply trying to access an existing file will fail with 
> "Permission denied" already. In the corresponding audit log I can see 
> the file access (failed with "invalid-HMAC"), but with an inode number 
> unknown to me - stat returns a completely different number for the file 
> in the lower and target dir.
> 
> For testing purposes I added a new hashing algorithm to 
> evm_ima_xattr_type which will not add the file system specific 
> attributes (inode number, generation, file system uuid) to the hash - 
> just like EVM_XATTR_PORTABLE_DIGSIG, but with the hashes generated by 
> the kernel. Files created with this signature can be read correctly, 
> though writing the files will still fail.
> 
> Unfortunately I'm out of ideas what is happening here. If anybody wants 
> to have a look at this: Any help would be appreciated.
> 
> Kind Regards,
> Ignaz
> 
> [1] https://www.spinics.net/lists/linux-integrity/msg03593.html
> [2] https://www.kernel.org/doc/htmldocs/filesystems/API-d-backing-inode.html
> 

After creating a file on the overlay, I wasn't able to access it from
the overlay, but was able to access it from "upper".  Both "stat" and
"getfattr -m ^security" returned exactly the same things for both
pathnames.  However, the ino in the audit log was different.

After modifying evm_calc_hmac_or_hash(), replacing d_backing_inode()
with d_real_inode(), the hmac properly calculated for both the overlay
and the upper pathnames.

Something must have changed in d_backing_inode().

Mimi

