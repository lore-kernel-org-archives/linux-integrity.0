Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5200DC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 18:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F04920672
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeLSSer (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:34:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbeLSSer (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 13:34:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIK826022562
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 13:34:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfs97yg1b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 13:34:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Dec 2018 18:34:44 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 18:34:41 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJIYeTx7143842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 18:34:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5D1F42092;
        Wed, 19 Dec 2018 18:34:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D3734208C;
        Wed, 19 Dec 2018 18:34:40 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Dec 2018 18:34:39 +0000 (GMT)
Subject: Re: EVM: Permission denied with overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     iforster@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Wed, 19 Dec 2018 13:34:39 -0500
In-Reply-To: <CAOQ4uxgoMntXsxnsxtBOOPLDo3HgcYPWayuCuDzxEx2GJSMZtg@mail.gmail.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <CAOQ4uxgoMntXsxnsxtBOOPLDo3HgcYPWayuCuDzxEx2GJSMZtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121918-0028-0000-0000-0000032CD733
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121918-0029-0000-0000-000023E93A0C
Message-Id: <1545244479.3954.38.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 18:38 +0200, Amir Goldstein wrote:
> On Wed, Dec 19, 2018 at 5:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2018-12-18 at 18:00 -0500, Mimi Zohar wrote:
> > > Hi Ignaz,
> > >
> > > On Tue, 2018-12-18 at 20:49 +0100, Ignaz Forster wrote:
> > > > Hi,
> > > >
> > > > as a follow up to my attempts to use overlayfs on an IMA protected
> > > > system[1] I've now tried to also enable EVM. From what I understand this
> > > > should - at least in theory - be possible: EVM will call
> > > > d_backing_inode(dentry), which I thought would get the inode of the
> > > > underlying file system[2], and use that for HMAC verification.
> > > >
> > > > In practice simply trying to access an existing file will fail with
> > > > "Permission denied" already. In the corresponding audit log I can see
> > > > the file access (failed with "invalid-HMAC"), but with an inode number
> > > > unknown to me - stat returns a completely different number for the file
> > > > in the lower and target dir.
> > > >
> > > > For testing purposes I added a new hashing algorithm to
> > > > evm_ima_xattr_type which will not add the file system specific
> > > > attributes (inode number, generation, file system uuid) to the hash -
> > > > just like EVM_XATTR_PORTABLE_DIGSIG, but with the hashes generated by
> > > > the kernel. Files created with this signature can be read correctly,
> > > > though writing the files will still fail.
> > > >
> > > > Unfortunately I'm out of ideas what is happening here. If anybody wants
> > > > to have a look at this: Any help would be appreciated.
> > > >
> > > > Kind Regards,
> > > > Ignaz
> > > >
> > > > [1] https://www.spinics.net/lists/linux-integrity/msg03593.html
> > > > [2] https://www.kernel.org/doc/htmldocs/filesystems/API-d-backing-inode.html
> > > >
> > >
> > > After creating a file on the overlay, I wasn't able to access it from
> > > the overlay, but was able to access it from "upper".  Both "stat" and
> > > "getfattr -m ^security" returned exactly the same things for both
> > > pathnames.  However, the ino in the audit log was different.
> > >
> > > After modifying evm_calc_hmac_or_hash(), replacing d_backing_inode()
> > > with d_real_inode(), the hmac properly calculated for both the overlay
> > > and the upper pathnames.
> > >
> > > Something must have changed in d_backing_inode().
> >
> > Confirmed, in linux-4.18.y d_backing_inode returns the real i_ino, but
> > newer kernels do not.  This is a problem for EVM as the i_ino is
> > included in the HMAC calculation.
> >
> 
> Hi Mimi,
> 
> v4.19 has a big change that removes many VFS hacks in favor of
> overlayfs stacked file operations.
> 
> The major implication for VFS code is that file_inode(file) is now the overlayfs
> inode and not the real inode. Therefore, file_dentry(file) is also the overlayfs
> dentry and not the real dentry.
> 
> I am not sure how that change impacts EVM ?
> FWIW, d_backing_inode(dentry) was never anything more than d_inode(dentry).
> 
> Can you please try to describe in more details for someone who has no clue what
> EVM does how exactly the v4.19 change is manifested in the EVM use case.

IMA calculates and stores a file hash/signature on the file data
(security.ima).  EVM calculates and stores an HMAC/signature on the
file metadata (security.evm).  Some data needs to be included in the
HMAC/signature that binds the file metadata with the file data.  That
data is the inode's ino, generation, uid, gid, mode and the uuid.

> 
> AFAIKT, evm_calc_hmac_or_hash() would get the overlayfs dentry both in
> v4.18 and v4.19 and therefore d_backing_inode(dentry) should be the
> overlayfs inode in both kernels (?).
> 
> The value of overlayfs inode i_ino can be identical to i_ino of the real inode
> under some conditions, but far from always and the value of overlayfs inode
> i_generation is almost guaranteed to not match that of the real inode.
> 
> Ignaz, can you add some more debug prints to shed some light on what
> exactly has changed, between the two kernels?
> If the calculated hashes do not match in two different execution paths,
> please provide two sample stack traces that see different i_ino, so we can
> examine them.

Assuming you've created and overlay mounted the lower, upper, work,
and merged directories, accessing files only in the merged directory
fails.

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 4f9126ebfbf4..d0ffa08d4b23 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -193,6 +193,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 uint8_t type, struct evm_digest *data)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode1 = d_real_inode(dentry);
 	struct xattr_list *xattr;
 	struct shash_desc *desc;
 	size_t xattr_size = 0;
@@ -241,6 +242,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
+	if (inode != inode1)
+		pr_info("ino: %lu %lu %lu %s\n", inode->i_ino, inode1->i_ino,
+				dentry->d_inode->i_ino, dentry->d_name.name);
 	hmac_add_misc(desc, inode, type, data->digest);
 
 	/* Portable EVM signatures must include an IMA hash */
-- 

Mimi

