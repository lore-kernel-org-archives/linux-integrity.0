Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F68AC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3AB2070B
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 21:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeLSVC3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:02:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730397AbeLSVC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 16:02:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJKxLiI064481
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 16:02:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfvqbam0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 16:02:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Dec 2018 21:02:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 21:02:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJL2NwY5177654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 21:02:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF20A11C04C;
        Wed, 19 Dec 2018 21:02:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4F811C054;
        Wed, 19 Dec 2018 21:02:22 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Dec 2018 21:02:22 +0000 (GMT)
Subject: Re: EVM: Permission denied with overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     iforster@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Wed, 19 Dec 2018 16:02:21 -0500
In-Reply-To: <CAOQ4uxhDh3okp1nYgZXxG+2siChfT8Oq3ncH1FFhQW_zBCstzw@mail.gmail.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <1545238601.2916.13.camel@HansenPartnership.com>
         <1545243311.3954.22.camel@linux.ibm.com>
         <1545248096.2916.26.camel@HansenPartnership.com>
         <CAOQ4uxhDh3okp1nYgZXxG+2siChfT8Oq3ncH1FFhQW_zBCstzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121921-0008-0000-0000-000002A3BA2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121921-0009-0000-0000-0000220E54D3
Message-Id: <1545253341.3954.83.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 22:12 +0200, Amir Goldstein wrote:
> On Wed, Dec 19, 2018 at 9:34 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Wed, 2018-12-19 at 13:15 -0500, Mimi Zohar wrote:
> > > On Wed, 2018-12-19 at 08:56 -0800, James Bottomley wrote:
> > > > On Wed, 2018-12-19 at 10:39 -0500, Mimi Zohar wrote:
> > > > > Confirmed, in linux-4.18.y d_backing_inode returns the real
> > > > > i_ino, but newer kernels do not.
> > > >
> > > > Just so we're clear, this isn't an issue with d_backing_inode(),
> > > > which hasn't changed since its introduction in 2015 and which
> > > > always returns dentry->d_inode (it was originally a helper for
> > > > unionfs which got merged even though unionfs didn't, which makes it
> > > > and the comment about upper/lower totally misleading).  The problem
> > > > is that overlayfs has changed the inode it places into d_inode.
> > > >
> > > > >   This is a problem for EVM as the i_ino is included in the HMAC
> > > > > calculation.
> > > >
> > > > Isn't the solution always to use portable signatures for
> > > > containers?
> > > > It's problematic to include inode and generation with an overlay
> > > > because if you change the metadata it gets copied up => new inode
> > > > number and generation on the upper filesystem but if we were always
> > > > using the underlying inode number and generation, the signature
> > > > would then be wrong on the copied up file.
> > > >
> > > > At base, most container images are sets of tar files, which are not
> > > > inode number preserving anyway, so even if we find a convoluted way
> > > > to fix the above, the EVM signature has to be portable because
> > > > otherwise its always wrong for container images.
> > >
> > > Ignaz's use case was mutable files, not immutable files with file
> > > signatures.
> >
> > The word "mutable" is problematic in terms of overlays.  Only the upper
> > layer is mutable, so if your EVM signed file is anywhere other than in
> > the top layer it's technically immutable.  What you get when you mutate
> > it is a copy up.  the VFS guarantee is that inode numbers are stable
> > only for the current mount and may change on a remount.  Most disk
> > backed filesystems have inode numbers encoded in their on disk inodes,
> > which is why they have far more stability than the simple VFS
> > requirement, but some filesystems can't have long term stable inode
> > numbers.  We recognise this problem in EVM with so called "portable
> > signatures" that don't include the inode number and generation.

For portable signatures, to bind the file metadata with the file data,
we've replaced the inode number and generation, with the
"security.ima" xattr.  Do we want this requirement/limitation for
overlays?

The existing EVM portable signature is an asymmetric algorithm based
signature.  Would we define a "portable" HMAC?

> > I'm interested in discussing two points
> >
> >    1. Can we actually come up with semantics where the EVM signature is
> >       always valid for overlays?
> 
> What you are looking for is a persistent and stable identifier for
> the inode object. Such a property already exists for filesystems that
> support NFS file handles.
> 
> As I wrote, you can *sometimes* rely on overlay i_ino to be consistent
> and stable (it will usually have the value of the pre copy up lower inode
> even after copy up), bug i_generation is nonsense.
> 
> You can *always* rely on overlay file handle to be a unique indetifier
> of the inode (even after mount cycle) as long as nfs_export=on and
> overlayfs supports NFS file handles (as well as the underlying layers).
> 
> 
> >    2. If the answer to 1. is "no" should we not always use portable
> >       signatures for overlay cases?
> 
> You can determine if overlayfs has exportfs ops and choose portable
> non-portable signatures per instance.
> 
> >
> > I think there are a load of nasty corner cases in 1. that make 2. far
> > more preferable, but perhaps we can begin with the use case that
> > requires non-portable signatures with overlays, because I don't think
> > I've heard it yet.
> >
> > >   Prior to 4.19, EVM was calculating and verifying the file
> > > HMAC properly.  With 4.19, it stopped working because the i_ino used
> > > in calculating the HMAC value stored in security.evm, is not the same
> > >  when verifying the HMAC value.
> >
> > Yes, but the same thing would happen on cifs or NFS or any other
> > filesystem that constructs inode numbers on the fly.  If we're not
> > proposing trying to fix them, why fix overlayfs?

Both EVM and IMA have been limited to local filesystems, originally
dependent on i_version.  Only recently has there been interest in
remote file systems.  There's a lot more than just adding a portable
EVM format to support remote filesystems.

Mimi
> 
> NFS file handles as inode identifier would work for those as well.
> 
> Thanks,
> Amir.
> 

